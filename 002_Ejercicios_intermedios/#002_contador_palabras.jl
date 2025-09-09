# Ejercicio Intermedio 2: Contador de Palabras
# Analiza texto y cuenta frecuencia de palabras

using Base: split, strip, lowercase

function limpiar_texto(texto)
    """Limpia el texto removiendo puntuación y normalizando"""
    # Convertir a minúsculas
    texto_limpio = lowercase(texto)
    
    # Remover puntuación común
    puntuacion = ['!', '?', '.', ',', ';', ':', '"', '\'', '(', ')', '[', ']', '{', '}', '-', '_']
    for p in puntuacion
        texto_limpio = replace(texto_limpio, p => " ")
    end
    
    return texto_limpio
end

function contar_palabras(texto)
    """Cuenta la frecuencia de cada palabra en el texto"""
    # Limpiar y dividir el texto
    texto_limpio = limpiar_texto(texto)
    palabras = split(texto_limpio)
    
    # Filtrar palabras vacías
    palabras = filter(p -> length(strip(p)) > 0, palabras)
    
    # Contar frecuencias
    contador = Dict{String, Int}()
    for palabra in palabras
        palabra = strip(palabra)
        if length(palabra) > 0
            contador[palabra] = get(contador, palabra, 0) + 1
        end
    end
    
    return contador
end

function palabras_mas_frecuentes(contador, n=10)
    """Devuelve las n palabras más frecuentes"""
    # Convertir a array de tuplas (palabra, frecuencia)
    palabras_freq = [(palabra, freq) for (palabra, freq) in contador]
    
    # Ordenar por frecuencia (descendente)
    sort!(palabras_freq, by=x -> x[2], rev=true)
    
    # Devolver las primeras n
    return palabras_freq[1:min(n, length(palabras_freq))]
end

function estadisticas_texto(texto)
    """Calcula estadísticas generales del texto"""
    contador = contar_palabras(texto)
    
    stats = Dict(
        "total_caracteres" => length(texto),
        "total_palabras" => sum(values(contador)),
        "palabras_unicas" => length(contador),
        "promedio_longitud_palabra" => sum(length(palabra) for palabra in keys(contador)) / length(contador)
    )
    
    return stats
end

function filtrar_palabras_cortas(contador, min_longitud=3)
    """Filtra palabras que son muy cortas"""
    return Dict(palabra => freq for (palabra, freq) in contador if length(palabra) >= min_longitud)
end

function buscar_palabra(contador, palabra)
    """Busca una palabra específica en el contador"""
    palabra_limpia = lowercase(strip(palabra))
    frecuencia = get(contador, palabra_limpia, 0)
    return frecuencia
end

function palabras_que_empiezan_con(contador, prefijo)
    """Encuentra palabras que empiezan con un prefijo específico"""
    prefijo_limpio = lowercase(strip(prefijo))
    coincidencias = []
    
    for (palabra, freq) in contador
        if startswith(palabra, prefijo_limpio)
            push!(coincidencias, (palabra, freq))
        end
    end
    
    # Ordenar por frecuencia
    sort!(coincidencias, by=x -> x[2], rev=true)
    return coincidencias
end

function generar_reporte(texto, titulo="Análisis de Texto")
    """Genera un reporte completo del análisis"""
    println("=" ^ 50)
    println(titulo)
    println("=" ^ 50)
    
    # Estadísticas generales
    stats = estadisticas_texto(texto)
    println("\n📊 ESTADÍSTICAS GENERALES:")
    println("  Total de caracteres: $(stats["total_caracteres"])")
    println("  Total de palabras: $(stats["total_palabras"])")
    println("  Palabras únicas: $(stats["palabras_unicas"])")
    println("  Promedio longitud palabra: $(round(stats["promedio_longitud_palabra"], digits=2)) caracteres")
    
    # Contar palabras
    contador = contar_palabras(texto)
    
    # Palabras más frecuentes
    println("\n🔥 TOP 10 PALABRAS MÁS FRECUENTES:")
    top_palabras = palabras_mas_frecuentes(contador, 10)
    for (i, (palabra, freq)) in enumerate(top_palabras)
        println("  $i. '$palabra': $freq veces")
    end
    
    # Palabras más largas
    println("\n📏 PALABRAS MÁS LARGAS:")
    palabras_largas = sort([(palabra, length(palabra)) for palabra in keys(contador)], by=x -> x[2], rev=true)
    for (i, (palabra, longitud)) in enumerate(palabras_largas[1:min(5, length(palabras_largas))])
        println("  $i. '$palabra': $longitud caracteres")
    end
    
    # Filtrar palabras cortas
    contador_filtrado = filtrar_palabras_cortas(contador, 4)
    println("\n🔍 TOP 5 PALABRAS LARGAS MÁS FRECUENTES (≥4 caracteres):")
    top_largas = palabras_mas_frecuentes(contador_filtrado, 5)
    for (i, (palabra, freq)) in enumerate(top_largas)
        println("  $i. '$palabra': $freq veces")
    end
    
    return contador
end

function contador_interactivo()
    """Versión interactiva del contador de palabras"""
    println("=== CONTADOR DE PALABRAS INTERACTIVO ===\n")
    
    while true
        println("Opciones:")
        println("1. Analizar texto")
        println("2. Buscar palabra específica")
        println("3. Palabras que empiezan con...")
        println("0. Salir")
        print("Selecciona una opción: ")
        
        try
            opcion = parse(Int, readline())
            
            if opcion == 0
                println("¡Hasta luego!")
                break
            elseif opcion == 1
                print("Ingresa el texto a analizar: ")
                texto = readline()
                if !isempty(texto)
                    generar_reporte(texto)
                else
                    println("No ingresaste texto.")
                end
            elseif opcion == 2
                print("Ingresa el texto a analizar: ")
                texto = readline()
                if !isempty(texto)
                    contador = contar_palabras(texto)
                    print("¿Qué palabra quieres buscar? ")
                    palabra = readline()
                    freq = buscar_palabra(contador, palabra)
                    if freq > 0
                        println("La palabra '$palabra' aparece $freq veces.")
                    else
                        println("La palabra '$palabra' no se encontró en el texto.")
                    end
                end
            elseif opcion == 3
                print("Ingresa el texto a analizar: ")
                texto = readline()
                if !isempty(texto)
                    contador = contar_palabras(texto)
                    print("Ingresa el prefijo: ")
                    prefijo = readline()
                    coincidencias = palabras_que_empiezan_con(contador, prefijo)
                    if !isempty(coincidencias)
                        println("Palabras que empiezan con '$prefijo':")
                        for (palabra, freq) in coincidencias
                            println("  '$palabra': $freq veces")
                        end
                    else
                        println("No se encontraron palabras que empiecen con '$prefijo'.")
                    end
                end
            else
                println("Opción no válida")
            end
        catch
            println("Error: Ingresa una opción válida")
        end
        
        println("\nPresiona Enter para continuar...")
        readline()
    end
end

# Función de testing
function test_contador()
    println("=== TESTING CONTADOR DE PALABRAS ===\n")
    
    texto_ejemplo = """
    Julia es un lenguaje de programación de alto nivel y alto rendimiento.
    Julia fue diseñado para la computación científica, pero también es útil
    para el desarrollo de aplicaciones web, análisis de datos y más.
    La sintaxis de Julia es similar a Python, pero con el rendimiento de C.
    """
    
    contador = generar_reporte(texto_ejemplo, "Análisis de Texto de Ejemplo")
    
    # Tests específicos
    println("\n🧪 TESTS ESPECÍFICOS:")
    println("Búsqueda de 'julia': $(buscar_palabra(contador, "julia")) veces")
    println("Búsqueda de 'programación': $(buscar_palabra(contador, "programación")) veces")
    
    palabras_j = palabras_que_empiezan_con(contador, "j")
    println("Palabras que empiezan con 'j': $(length(palabras_j))")
    for (palabra, freq) in palabras_j
        println("  '$palabra': $freq")
    end
end

# Ejecutar tests
test_contador()

# Descomenta la siguiente línea para la versión interactiva
# contador_interactivo()

println("\n¡Contador de palabras implementado! Descomenta 'contador_interactivo()' para usarlo.")
