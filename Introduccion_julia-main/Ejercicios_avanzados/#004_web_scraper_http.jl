# Ejercicio Avanzado 4: Web Scraper HTTP
# Extrae datos de páginas web usando HTTP y parsing HTML básico

using HTTP
using Base64

# Estructuras para el web scraper
struct WebPage
    url::String
    status_code::Int
    headers::Dict{String, String}
    content::String
    content_type::String
    size::Int
    load_time::Float64
end

struct ExtractedData
    title::String
    links::Vector{String}
    images::Vector{String}
    text_content::String
    meta_tags::Dict{String, String}
    forms::Vector{Dict{String, Any}}
end

struct ScrapingResult
    page::WebPage
    data::ExtractedData
    success::Bool
    error_message::String
end

# Cliente HTTP personalizado
mutable struct WebScraper
    headers::Dict{String, String}
    timeout::Int
    max_redirects::Int
    user_agent::String
    cookies::Dict{String, String}
    
    function WebScraper()
        default_headers = Dict(
            "User-Agent" => "Julia WebScraper 1.0",
            "Accept" => "text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8",
            "Accept-Language" => "en-US,en;q=0.9",
            "Accept-Encoding" => "gzip, deflate",
            "Connection" => "keep-alive",
            "Upgrade-Insecure-Requests" => "1"
        )
        
        new(default_headers, 30, 5, "Julia WebScraper 1.0", Dict{String, String}())
    end
end

# Funciones de descarga
function fetch_page(scraper::WebScraper, url::String)::WebPage
    """Descarga una página web"""
    start_time = time()
    
    try
        # Preparar headers
        request_headers = copy(scraper.headers)
        if !isempty(scraper.cookies)
            cookie_string = join(["$k=$v" for (k, v) in scraper.cookies], "; ")
            request_headers["Cookie"] = cookie_string
        end
        
        # Realizar petición HTTP
        response = HTTP.get(
            url,
            headers=request_headers,
            readtimeout=scraper.timeout,
            redirect_limit=scraper.max_redirects
        )
        
        load_time = time() - start_time
        
        # Procesar headers de respuesta
        response_headers = Dict{String, String}()
        for (key, value) in response.headers
            response_headers[key] = value
        end
        
        # Determinar content type
        content_type = get(response_headers, "Content-Type", "text/html")
        
        # Convertir contenido a string
        content = String(response.body)
        
        return WebPage(
            url,
            response.status,
            response_headers,
            content,
            content_type,
            length(content),
            load_time
        )
        
    catch e
        # En caso de error, devolver página vacía con error
        load_time = time() - start_time
        return WebPage(
            url,
            0,
            Dict{String, String}(),
            "",
            "",
            0,
            load_time
        )
    end
end

# Parser HTML básico (sin dependencias externas)
function extract_text_between(content::String, start_tag::String, end_tag::String)::Vector{String}
    """Extrae texto entre tags HTML"""
    results = String[]
    content_lower = lowercase(content)
    start_tag_lower = lowercase(start_tag)
    end_tag_lower = lowercase(end_tag)
    
    start_pos = 1
    while true
        # Buscar tag de inicio
        tag_start = findnext(start_tag_lower, content_lower, start_pos)
        if tag_start === nothing
            break
        end
        
        # Encontrar el final del tag de inicio
        tag_end = findnext('>', content, tag_start.stop)
        if tag_end === nothing
            break
        end
        
        # Buscar tag de cierre
        close_start = findnext(end_tag_lower, content_lower, tag_end)
        if close_start === nothing
            break
        end
        
        # Extraer contenido
        extracted = content[tag_end+1:close_start.start-1]
        extracted = strip(remove_html_tags(extracted))
        
        if !isempty(extracted)
            push!(results, extracted)
        end
        
        start_pos = close_start.stop
    end
    
    return results
end

function extract_attributes(tag::String, attr_name::String)::Vector{String}
    """Extrae valores de atributos de tags HTML"""
    results = String[]
    
    # Patrón para encontrar el atributo
    pattern = Regex("$attr_name\\s*=\\s*[\"']([^\"']*)[\"']", "i")
    
    for match in eachmatch(pattern, tag)
        if length(match.captures) > 0 && match.captures[1] !== nothing
            push!(results, match.captures[1])
        end
    end
    
    return results
end

function remove_html_tags(content::String)::String
    """Remueve tags HTML del contenido"""
    # Remover scripts y styles completos
    content = replace(content, r"<script[^>]*>.*?</script>"is => "")
    content = replace(content, r"<style[^>]*>.*?</style>"is => "")
    
    # Remover comentarios HTML
    content = replace(content, r"<!--.*?-->"s => "")
    
    # Remover tags HTML
    content = replace(content, r"<[^>]*>" => " ")
    
    # Limpiar espacios múltiples
    content = replace(content, r"\s+" => " ")
    
    return strip(content)
end

function extract_links(content::String, base_url::String="")::Vector{String}
    """Extrae todos los enlaces de la página"""
    links = String[]
    
    # Buscar tags <a> con href
    link_pattern = r"<a[^>]*href\s*=\s*[\"']([^\"']*)[\"'][^>]*>"i
    
    for match in eachmatch(link_pattern, content)
        if length(match.captures) > 0 && match.captures[1] !== nothing
            link = match.captures[1]
            
            # Convertir enlaces relativos a absolutos
            if !isempty(base_url) && !startswith(link, "http")
                if startswith(link, "/")
                    # Enlace absoluto relativo
                    uri = HTTP.URI(base_url)
                    link = "$(uri.scheme)://$(uri.host)$link"
                elseif !startswith(link, "#") && !startswith(link, "mailto:")
                    # Enlace relativo
                    link = joinpath(base_url, link)
                end
            end
            
            if startswith(link, "http") && link ∉ links
                push!(links, link)
            end
        end
    end
    
    return links
end

function extract_images(content::String, base_url::String="")::Vector{String}
    """Extrae todas las imágenes de la página"""
    images = String[]
    
    # Buscar tags <img> con src
    img_pattern = r"<img[^>]*src\s*=\s*[\"']([^\"']*)[\"'][^>]*>"i
    
    for match in eachmatch(img_pattern, content)
        if length(match.captures) > 0 && match.captures[1] !== nothing
            img_src = match.captures[1]
            
            # Convertir rutas relativas a absolutas
            if !isempty(base_url) && !startswith(img_src, "http")
                if startswith(img_src, "/")
                    uri = HTTP.URI(base_url)
                    img_src = "$(uri.scheme)://$(uri.host)$img_src"
                else
                    img_src = joinpath(base_url, img_src)
                end
            end
            
            if img_src ∉ images
                push!(images, img_src)
            end
        end
    end
    
    return images
end

function extract_title(content::String)::String
    """Extrae el título de la página"""
    titles = extract_text_between(content, "<title", "</title>")
    return isempty(titles) ? "Sin título" : titles[1]
end

function extract_meta_tags(content::String)::Dict{String, String}
    """Extrae meta tags de la página"""
    meta_tags = Dict{String, String}()
    
    # Buscar meta tags
    meta_pattern = r"<meta[^>]*>"i
    
    for match in eachmatch(meta_pattern, content)
        tag = match.match
        
        # Extraer name y content
        names = extract_attributes(tag, "name")
        contents = extract_attributes(tag, "content")
        
        if !isempty(names) && !isempty(contents)
            meta_tags[names[1]] = contents[1]
        end
        
        # También buscar property (para Open Graph)
        properties = extract_attributes(tag, "property")
        if !isempty(properties) && !isempty(contents)
            meta_tags[properties[1]] = contents[1]
        end
    end
    
    return meta_tags
end

function extract_forms(content::String)::Vector{Dict{String, Any}}
    """Extrae información de formularios"""
    forms = Dict{String, Any}[]
    
    # Buscar formularios
    form_pattern = r"<form[^>]*>(.*?)</form>"is
    
    for match in eachmatch(form_pattern, content)
        form_content = match.captures[1]
        form_tag = match.match
        
        # Extraer atributos del formulario
        method = extract_attributes(form_tag, "method")
        action = extract_attributes(form_tag, "action")
        
        # Extraer campos de entrada
        input_pattern = r"<input[^>]*>"i
        inputs = Dict{String, String}[]
        
        for input_match in eachmatch(input_pattern, form_content)
            input_tag = input_match.match
            
            input_type = extract_attributes(input_tag, "type")
            input_name = extract_attributes(input_tag, "name")
            input_value = extract_attributes(input_tag, "value")
            
            input_info = Dict{String, String}()
            if !isempty(input_type)
                input_info["type"] = input_type[1]
            end
            if !isempty(input_name)
                input_info["name"] = input_name[1]
            end
            if !isempty(input_value)
                input_info["value"] = input_value[1]
            end
            
            if !isempty(input_info)
                push!(inputs, input_info)
            end
        end
        
        form_info = Dict{String, Any}(
            "method" => isempty(method) ? "GET" : uppercase(method[1]),
            "action" => isempty(action) ? "" : action[1],
            "inputs" => inputs
        )
        
        push!(forms, form_info)
    end
    
    return forms
end

# Función principal de scraping
function scrape_page(scraper::WebScraper, url::String)::ScrapingResult
    """Realiza scraping completo de una página"""
    try
        # Descargar página
        page = fetch_page(scraper, url)
        
        if page.status_code == 0
            return ScrapingResult(
                page,
                ExtractedData("", String[], String[], "", Dict{String, String}(), Dict{String, Any}[]),
                false,
                "Error al descargar la página"
            )
        end
        
        if page.status_code >= 400
            return ScrapingResult(
                page,
                ExtractedData("", String[], String[], "", Dict{String, String}(), Dict{String, Any}[]),
                false,
                "Error HTTP: $(page.status_code)"
            )
        end
        
        # Extraer datos
        title = extract_title(page.content)
        links = extract_links(page.content, url)
        images = extract_images(page.content, url)
        text_content = remove_html_tags(page.content)
        meta_tags = extract_meta_tags(page.content)
        forms = extract_forms(page.content)
        
        extracted_data = ExtractedData(
            title,
            links,
            images,
            text_content,
            meta_tags,
            forms
        )
        
        return ScrapingResult(page, extracted_data, true, "")
        
    catch e
        empty_page = WebPage(url, 0, Dict{String, String}(), "", "", 0, 0.0)
        empty_data = ExtractedData("", String[], String[], "", Dict{String, String}(), Dict{String, Any}[])
        return ScrapingResult(empty_page, empty_data, false, string(e))
    end
end

# Funciones de utilidad
function print_scraping_result(result::ScrapingResult)
    """Imprime resultado del scraping de forma legible"""
    println("🌐 RESULTADO DEL SCRAPING")
    println("=" ^ 50)
    
    if !result.success
        println("❌ Error: $(result.error_message)")
        return
    end
    
    page = result.page
    data = result.data
    
    # Información de la página
    println("📄 INFORMACIÓN DE LA PÁGINA:")
    println("  URL: $(page.url)")
    println("  Status: $(page.status_code)")
    println("  Content-Type: $(page.content_type)")
    println("  Tamaño: $(page.size) bytes")
    println("  Tiempo de carga: $(round(page.load_time, digits=2)) segundos")
    
    # Datos extraídos
    println("\n📊 DATOS EXTRAÍDOS:")
    println("  Título: $(data.title)")
    println("  Enlaces encontrados: $(length(data.links))")
    println("  Imágenes encontradas: $(length(data.images))")
    println("  Meta tags: $(length(data.meta_tags))")
    println("  Formularios: $(length(data.forms))")
    println("  Longitud del texto: $(length(data.text_content)) caracteres")
    
    # Mostrar algunos enlaces
    if !isempty(data.links)
        println("\n🔗 PRIMEROS 5 ENLACES:")
        for (i, link) in enumerate(data.links[1:min(5, length(data.links))])
            println("  $i. $link")
        end
        if length(data.links) > 5
            println("  ... y $(length(data.links) - 5) más")
        end
    end
    
    # Mostrar meta tags importantes
    if !isempty(data.meta_tags)
        println("\n🏷️  META TAGS IMPORTANTES:")
        important_tags = ["description", "keywords", "author", "og:title", "og:description"]
        for tag in important_tags
            if haskey(data.meta_tags, tag)
                value = data.meta_tags[tag]
                if length(value) > 100
                    value = value[1:97] * "..."
                end
                println("  $tag: $value")
            end
        end
    end
    
    # Mostrar formularios
    if !isempty(data.forms)
        println("\n📝 FORMULARIOS:")
        for (i, form) in enumerate(data.forms)
            println("  Formulario $i:")
            println("    Método: $(form["method"])")
            println("    Acción: $(form["action"])")
            println("    Campos: $(length(form["inputs"]))")
        end
    end
end

function save_scraping_result(result::ScrapingResult, filename::String)
    """Guarda resultado de scraping en archivo"""
    if !result.success
        println("❌ No se puede guardar resultado fallido")
        return
    end
    
    # Crear resumen
    summary = Dict(
        "url" => result.page.url,
        "timestamp" => string(now()),
        "status_code" => result.page.status_code,
        "title" => result.data.title,
        "links_count" => length(result.data.links),
        "images_count" => length(result.data.images),
        "text_length" => length(result.data.text_content),
        "links" => result.data.links,
        "images" => result.data.images,
        "meta_tags" => result.data.meta_tags,
        "forms" => result.data.forms,
        "text_content" => result.data.text_content[1:min(1000, length(result.data.text_content))]  # Primeros 1000 caracteres
    )
    
    # Escribir archivo (formato simple)
    open(filename, "w") do file
        for (key, value) in summary
            println(file, "$key: $value")
            println(file, "---")
        end
    end
    
    println("✅ Resultado guardado en: $filename")
end

# Scraper batch para múltiples URLs
function scrape_multiple_urls(scraper::WebScraper, urls::Vector{String}; delay::Float64=1.0)
    """Realiza scraping de múltiples URLs con delay entre peticiones"""
    results = ScrapingResult[]
    
    println("🚀 Iniciando scraping de $(length(urls)) URLs...")
    
    for (i, url) in enumerate(urls)
        println("📥 Procesando $i/$(length(urls)): $url")
        
        result = scrape_page(scraper, url)
        push!(results, result)
        
        if result.success
            println("  ✅ Éxito: $(result.data.title)")
        else
            println("  ❌ Error: $(result.error_message)")
        end
        
        # Delay entre peticiones para ser respetuoso
        if i < length(urls)
            sleep(delay)
        end
    end
    
    # Resumen final
    successful = count(r -> r.success, results)
    println("\n📊 RESUMEN FINAL:")
    println("  URLs procesadas: $(length(urls))")
    println("  Exitosos: $successful")
    println("  Fallidos: $(length(urls) - successful)")
    
    return results
end

# Demostración
function demo_web_scraper()
    """Demostración del web scraper"""
    println("=== DEMO WEB SCRAPER ===\n")
    
    # Crear scraper
    scraper = WebScraper()
    
    # URLs de ejemplo (usar URLs públicas que permitan scraping)
    test_urls = [
        "https://httpbin.org/html",  # Página de prueba
        "https://example.com",       # Página simple
    ]
    
    println("🔧 Configuración del scraper:")
    println("  User-Agent: $(scraper.user_agent)")
    println("  Timeout: $(scraper.timeout) segundos")
    println("  Max redirects: $(scraper.max_redirects)")
    
    # Test con una URL
    println("\n🧪 Test con URL individual:")
    for url in test_urls
        println("\n🌐 Scrapeando: $url")
        result = scrape_page(scraper, url)
        print_scraping_result(result)
        
        if result.success
            println("\n💾 Guardando resultado...")
            filename = "scraping_$(replace(url, r"[^a-zA-Z0-9]" => "_")).txt"
            save_scraping_result(result, filename)
        end
        
        println("\n" * "="^50)
    end
    
    # Test batch
    if length(test_urls) > 1
        println("\n🚀 Test scraping batch:")
        batch_results = scrape_multiple_urls(scraper, test_urls, delay=0.5)
        
        println("\n📈 Estadísticas del batch:")
        total_links = sum(length(r.data.links) for r in batch_results if r.success)
        total_images = sum(length(r.data.images) for r in batch_results if r.success)
        avg_load_time = sum(r.page.load_time for r in batch_results if r.success) / 
                       count(r -> r.success, batch_results)
        
        println("  Total de enlaces encontrados: $total_links")
        println("  Total de imágenes encontradas: $total_images")
        println("  Tiempo promedio de carga: $(round(avg_load_time, digits=2)) segundos")
    end
end

# Ejecutar demostración
demo_web_scraper()

println("\n¡Web scraper implementado! Modifica las URLs de prueba para experimentar.")
