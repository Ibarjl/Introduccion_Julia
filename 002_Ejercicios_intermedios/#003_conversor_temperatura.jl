# Ejercicio Intermedio 3: Conversor de Temperatura
# Convierte entre diferentes escalas de temperatura

# Definir las escalas de temperatura disponibles
const ESCALAS = ["C", "F", "K", "R"]  # Celsius, Fahrenheit, Kelvin, Rankine
const NOMBRES_ESCALAS = Dict(
    "C" => "Celsius",
    "F" => "Fahrenheit", 
    "K" => "Kelvin",
    "R" => "Rankine"
)

# Funciones de conversión desde Celsius
function celsius_a_fahrenheit(celsius)
    return celsius * 9/5 + 32
end

function celsius_a_kelvin(celsius)
    return celsius + 273.15
end

function celsius_a_rankine(celsius)
    return (celsius + 273.15) * 9/5
end

# Funciones de conversión hacia Celsius
function fahrenheit_a_celsius(fahrenheit)
    return (fahrenheit - 32) * 5/9
end

function kelvin_a_celsius(kelvin)
    return kelvin - 273.15
end

function rankine_a_celsius(rankine)
    return (rankine * 5/9) - 273.15
end

# Función principal de conversión
function convertir_temperatura(valor, escala_origen, escala_destino)
    """Convierte temperatura entre cualquier par de escalas"""
    
    # Validar escalas
    if !(escala_origen in ESCALAS) || !(escala_destino in ESCALAS)
        error("Escalas válidas: $(join(ESCALAS, ", "))")
    end
    
    # Si son la misma escala, devolver el mismo valor
    if escala_origen == escala_destino
        return valor
    end
    
    # Primero convertir todo a Celsius
    celsius = if escala_origen == "C"
        valor
    elseif escala_origen == "F"
        fahrenheit_a_celsius(valor)
    elseif escala_origen == "K"
        kelvin_a_celsius(valor)
    elseif escala_origen == "R"
        rankine_a_celsius(valor)
    end
    
    # Luego convertir de Celsius a la escala destino
    resultado = if escala_destino == "C"
        celsius
    elseif escala_destino == "F"
        celsius_a_fahrenheit(celsius)
    elseif escala_destino == "K"
        celsius_a_kelvin(celsius)
    elseif escala_destino == "R"
        celsius_a_rankine(celsius)
    end
    
    return resultado
end

# Función para obtener símbolo de unidad
function obtener_simbolo(escala)
    simbolos = Dict("C" => "°C", "F" => "°F", "K" => "K", "R" => "°R")
    return get(simbolos, escala, "")
end

# Función para validar temperaturas físicamente posibles
function validar_temperatura(valor, escala)
    """Valida que la temperatura esté dentro de rangos físicos razonables"""
    
    # Convertir a Kelvin para validación universal
    kelvin = convertir_temperatura(valor, escala, "K")
    
    if kelvin < 0
        @warn "Temperatura $(valor)$(obtener_simbolo(escala)) está por debajo del cero absoluto"
        return false
    elseif kelvin > 10000  # Temperatura muy alta
        @warn "Temperatura $(valor)$(obtener_simbolo(escala)) es extremadamente alta"
        return false
    end
    
    return true
end

# Función para crear tabla de conversiones
function tabla_conversiones(temperatura, escala_origen)
    """Crea una tabla con todas las conversiones posibles"""
    
    println("\n📊 TABLA DE CONVERSIONES")
    println("Temperatura original: $temperatura$(obtener_simbolo(escala_origen))")
    println("-" ^ 40)
    
    for escala_destino in ESCALAS
        if escala_destino != escala_origen
            resultado = convertir_temperatura(temperatura, escala_origen, escala_destino)
            nombre = NOMBRES_ESCALAS[escala_destino]
            simbolo = obtener_simbolo(escala_destino)
            println("$nombre: $(round(resultado, digits=2))$simbolo")
        end
    end
end

# Función para conversiones por lotes
function convertir_lote(temperaturas, escala_origen, escala_destino)
    """Convierte múltiples temperaturas de una vez"""
    
    resultados = []
    for temp in temperaturas
        try
            resultado = convertir_temperatura(temp, escala_origen, escala_destino)
            push!(resultados, resultado)
        catch e
            push!(resultados, "Error: $e")
        end
    end
    
    return resultados
end

# Función para encontrar punto de ebullición y congelación del agua
function puntos_agua()
    """Muestra los puntos de congelación y ebullición del agua en todas las escalas"""
    
    println("\n💧 PUNTOS DEL AGUA")
    println("=" ^ 30)
    
    # Punto de congelación (0°C)
    println("🧊 Punto de congelación:")
    for escala in ESCALAS
        temp = convertir_temperatura(0, "C", escala)
        println("  $(NOMBRES_ESCALAS[escala]): $(round(temp, digits=2))$(obtener_simbolo(escala))")
    end
    
    # Punto de ebullición (100°C)
    println("\n🔥 Punto de ebullición:")
    for escala in ESCALAS
        temp = convertir_temperatura(100, "C", escala)
        println("  $(NOMBRES_ESCALAS[escala]): $(round(temp, digits=2))$(obtener_simbolo(escala))")
    end
end

# Función para obtener entrada del usuario
function obtener_temperatura()
    while true
        print("Ingresa la temperatura: ")
        try
            return parse(Float64, readline())
        catch
            println("Error: Ingresa un número válido")
        end
    end
end

function obtener_escala(mensaje)
    while true
        print("$mensaje ($(join(ESCALAS, "/"))): ")
        escala = uppercase(strip(readline()))
        if escala in ESCALAS
            return escala
        else
            println("Error: Escala no válida. Usa: $(join(ESCALAS, ", "))")
        end
    end
end

# Programa interactivo
function conversor_interactivo()
    println("🌡️  CONVERSOR DE TEMPERATURA")
    println("=" ^ 40)
    
    while true
        println("\nOpciones:")
        println("1. Conversión simple")
        println("2. Tabla completa de conversiones") 
        println("3. Conversión por lotes")
        println("4. Puntos del agua")
        println("5. Información sobre escalas")
        println("0. Salir")
        print("Selecciona una opción: ")
        
        try
            opcion = parse(Int, readline())
            
            if opcion == 0
                println("¡Hasta luego!")
                break
                
            elseif opcion == 1
                temperatura = obtener_temperatura()
                origen = obtener_escala("Escala de origen")
                destino = obtener_escala("Escala de destino")
                
                if validar_temperatura(temperatura, origen)
                    resultado = convertir_temperatura(temperatura, origen, destino)
                    println("\n✅ Resultado: $temperatura$(obtener_simbolo(origen)) = $(round(resultado, digits=2))$(obtener_simbolo(destino))")
                end
                
            elseif opcion == 2
                temperatura = obtener_temperatura()
                origen = obtener_escala("Escala de origen")
                
                if validar_temperatura(temperatura, origen)
                    tabla_conversiones(temperatura, origen)
                end
                
            elseif opcion == 3
                print("Ingresa temperaturas separadas por comas: ")
                entrada = readline()
                try
                    temperaturas = [parse(Float64, strip(t)) for t in split(entrada, ",")]
                    origen = obtener_escala("Escala de origen")
                    destino = obtener_escala("Escala de destino")
                    
                    resultados = convertir_lote(temperaturas, origen, destino)
                    
                    println("\n📋 RESULTADOS DEL LOTE:")
                    for (i, (orig, res)) in enumerate(zip(temperaturas, resultados))
                        println("$i. $orig$(obtener_simbolo(origen)) → $res$(obtener_simbolo(destino))")
                    end
                catch
                    println("Error: Formato inválido. Usa números separados por comas.")
                end
                
            elseif opcion == 4
                puntos_agua()
                
            elseif opcion == 5
                println("\n📚 INFORMACIÓN SOBRE ESCALAS:")
                println("• Celsius (°C): Escala basada en el agua (0°C = congelación, 100°C = ebullición)")
                println("• Fahrenheit (°F): Escala usada principalmente en EEUU")
                println("• Kelvin (K): Escala absoluta usada en ciencia (0K = cero absoluto)")
                println("• Rankine (°R): Escala absoluta basada en Fahrenheit")
                
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
function test_conversor()
    println("=== TESTING CONVERSOR DE TEMPERATURA ===\n")
    
    # Tests de conversión
    println("🧪 Tests de conversión:")
    test_cases = [
        (0, "C", "F", 32),      # Congelación del agua
        (100, "C", "F", 212),   # Ebullición del agua
        (32, "F", "C", 0),      # Fahrenheit a Celsius
        (0, "C", "K", 273.15),  # Celsius a Kelvin
        (273.15, "K", "C", 0),  # Kelvin a Celsius
    ]
    
    for (valor, origen, destino, esperado) in test_cases
        resultado = convertir_temperatura(valor, origen, destino)
        status = abs(resultado - esperado) < 0.01 ? "✅" : "❌"
        println("$status $(valor)$(obtener_simbolo(origen)) → $(round(resultado, digits=2))$(obtener_simbolo(destino)) (esperado: $esperado)")
    end
    
    # Test de tabla de conversiones
    println("\n📊 Ejemplo de tabla de conversiones:")
    tabla_conversiones(25, "C")
    
    # Test de puntos del agua
    puntos_agua()
    
    # Test de validación
    println("\n⚠️  Tests de validación:")
    println("Temperatura válida (25°C): $(validar_temperatura(25, "C"))")
    println("Temperatura inválida (-300°C): $(validar_temperatura(-300, "C"))")
end

# Ejecutar tests
test_conversor()

# Descomenta la siguiente línea para la versión interactiva
# conversor_interactivo()

println("\n¡Conversor de temperatura implementado! Descomenta 'conversor_interactivo()' para usarlo.")
