# Ejercicio 12: Manejo de Errores en Julia
# Aprende a manejar errores y excepciones

# Función que puede generar errores
function dividir(a, b)
    if b == 0
        error("División por cero no permitida")
    end
    return a / b
end

# Manejo básico con try-catch
println("=== Manejo básico de errores ===")
try
    resultado = dividir(10, 2)
    println("10 / 2 = $resultado")
    
    # Esto causará un error
    resultado_error = dividir(10, 0)
    println("Esto no se ejecutará")
catch e
    println("Error capturado: $e")
end

# Capturar tipos específicos de errores
println("\n=== Captura de errores específicos ===")
function procesar_numero(x)
    try
        # Intentar convertir a entero
        numero = parse(Int, x)
        resultado = 100 / numero
        return resultado
    catch e
        if isa(e, ArgumentError)
            println("Error: '$x' no es un número válido")
        elseif isa(e, DivideError)
            println("Error: División por cero")
        else
            println("Error desconocido: $e")
        end
        return nothing
    end
end

# Probar diferentes casos
procesar_numero("5")      # Funciona
procesar_numero("abc")    # ArgumentError
procesar_numero("0")      # DivideError

# try-catch-finally
println("\n=== try-catch-finally ===")
function leer_archivo_simulado(nombre)
    try
        if nombre == "inexistente.txt"
            error("Archivo no encontrado")
        end
        println("Procesando archivo: $nombre")
        return "contenido del archivo"
    catch e
        println("Error al leer archivo: $e")
        return nothing
    finally
        println("Limpieza: cerrando recursos")
    end
end

leer_archivo_simulado("documento.txt")
leer_archivo_simulado("inexistente.txt")

# Crear excepciones personalizadas
println("\n=== Excepciones personalizadas ===")
struct EdadInvalidaError <: Exception
    edad::Int
    mensaje::String
end

function validar_edad(edad)
    if edad < 0
        throw(EdadInvalidaError(edad, "La edad no puede ser negativa"))
    elseif edad > 150
        throw(EdadInvalidaError(edad, "La edad es demasiado alta"))
    end
    return true
end

try
    validar_edad(25)   # OK
    println("Edad válida")
    validar_edad(-5)   # Error
catch e
    if isa(e, EdadInvalidaError)
        println("Error de edad: $(e.mensaje). Valor: $(e.edad)")
    else
        rethrow(e)
    end
end

# assert para verificaciones
println("\n=== Uso de assert ===")
function calcular_raiz_cuadrada(x)
    @assert x >= 0 "El número debe ser no negativo para calcular la raíz cuadrada"
    return sqrt(x)
end

try
    resultado = calcular_raiz_cuadrada(16)
    println("√16 = $resultado")
    
    # Esto fallará
    calcular_raiz_cuadrada(-4)
catch e
    println("Assertion falló: $e")
end

# Manejo de errores en bucles
println("\n=== Errores en bucles ===")
numeros_string = ["1", "2", "abc", "4", "xyz", "6"]
numeros_validos = []

for num_str in numeros_string
    try
        numero = parse(Int, num_str)
        push!(numeros_validos, numero)
    catch e
        println("'$num_str' no es un número válido, saltando...")
        continue
    end
end

println("Números válidos: $numeros_validos")

# @warn y @info para mensajes
println("\n=== Mensajes de advertencia e información ===")
function procesar_datos(datos)
    if length(datos) == 0
        @warn "Los datos están vacíos"
        return []
    end
    
    if length(datos) < 10
        @info "Conjunto de datos pequeño ($(length(datos)) elementos)"
    end
    
    return datos .* 2
end

procesar_datos([])
procesar_datos([1, 2, 3])

# Manejo de errores con valores por defecto
println("\n=== Valores por defecto en errores ===")
function obtener_configuracion(clave, default=nothing)
    configuraciones = Dict("host" => "localhost", "puerto" => 8080)
    
    try
        return configuraciones[clave]
    catch KeyError
        if default !== nothing
            @warn "Clave '$clave' no encontrada, usando valor por defecto: $default"
            return default
        else
            error("Clave '$clave' no encontrada y no se proporcionó valor por defecto")
        end
    end
end

host = obtener_configuracion("host")
puerto = obtener_configuracion("puerto")
timeout = obtener_configuracion("timeout", 30)
println("Host: $host, Puerto: $puerto, Timeout: $timeout")

# Propagación controlada de errores
println("\n=== Propagación de errores ===")
function nivel1()
    nivel2()
end

function nivel2()
    nivel3()
end

function nivel3()
    error("Error en el nivel más profundo")
end

try
    nivel1()
catch e
    println("Error capturado en el nivel superior: $e")
    # Mostrar stacktrace
    for (exc, bt) in Base.catch_stack()
        showerror(stdout, exc, bt)
        println()
    end
end

# Ejercicios para practicar:
# 1. Crea una función que valide datos de entrada con manejo de errores
# 2. Implementa un sistema de reintentos para operaciones que pueden fallar
# 3. Diseña una jerarquía de excepciones personalizadas para tu aplicación
