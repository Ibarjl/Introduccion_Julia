# Patrones Idiomáticos de Julia
# Guía completa de operadores especiales, sintaxis idiomática y mejores prácticas

"""
Este archivo cubre los patrones idiomáticos más importantes de Julia, incluyendo
operadores especiales, sintaxis única y formas idiomáticas de escribir código.
"""

println("=== PATRONES IDIOMÁTICOS DE JULIA ===\n")

# ============================================================================
# 1. OPERADORES DE FUNCIONES ANÓNIMAS Y PIPELINE
# ============================================================================

println("1. OPERADORES DE FUNCIONES Y PIPELINE")
println("=" * 50)

# 1.1 Operador -> (funciones anónimas)
println("\n1.1 Operador -> (Funciones Anónimas)")
println("-" * 35)

# Función anónima básica
cuadrado = x -> x^2
println("cuadrado = x -> x^2")
println("cuadrado(5) = $(cuadrado(5))")

# Función anónima con múltiples argumentos
suma = (x, y) -> x + y
println("suma = (x, y) -> x + y")
println("suma(3, 4) = $(suma(3, 4))")

# Función anónima compleja
procesar = x -> begin
    temp = x * 2
    temp + 1
end
println("Función anónima con bloque:")
println("procesar(5) = $(procesar(5))")

# Uso con map
numeros = [1, 2, 3, 4, 5]
cuadrados = map(x -> x^2, numeros)
println("map(x -> x^2, $numeros) = $cuadrados")

# Uso con filter
pares = filter(x -> x % 2 == 0, numeros)
println("filter(x -> x % 2 == 0, $numeros) = $pares")

# 1.2 Operador |> (pipe)
println("\n1.2 Operador |> (Pipe)")
println("-" * 25)

# Pipeline básico
resultado = 5 |> x -> x^2 |> x -> x + 1
println("5 |> x -> x^2 |> x -> x + 1 = $resultado")

# Pipeline con funciones nombradas
function doblar(x)
    return x * 2
end

function incrementar(x)
    return x + 1
end

resultado_pipeline = 10 |> doblar |> incrementar
println("10 |> doblar |> incrementar = $resultado_pipeline")

# Pipeline complejo
datos = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
resultado_complejo = datos |>
    x -> filter(n -> n % 2 == 0, x) |>
    x -> map(n -> n^2, x) |>
    sum
println("Pipeline complejo con datos: $resultado_complejo")

# ============================================================================
# 2. OPERADOR => (PAIR Y DICCIONARIOS)
# ============================================================================

println("\n\n2. OPERADOR => (PAIR Y DICCIONARIOS)")
println("=" * 50)

# 2.1 Creación de Pairs
println("\n2.1 Creación de Pairs")
println("-" * 25)

par1 = "nombre" => "Juan"
par2 = :edad => 25
par3 = 1 => "uno"

println("par1 = \"nombre\" => \"Juan\": $par1")
println("par2 = :edad => 25: $par2")
println("par3 = 1 => \"uno\": $par3")

# Acceso a elementos del pair
println("par1.first = $(par1.first)")
println("par1.second = $(par1.second)")

# 2.2 Diccionarios con =>
println("\n2.2 Diccionarios con =>")
println("-" * 28)

# Creación de diccionario
persona = Dict(
    "nombre" => "María",
    "edad" => 30,
    "ciudad" => "Madrid"
)
println("Diccionario persona: $persona")

# Diccionario con símbolos
config = Dict(
    :host => "localhost",
    :puerto => 8080,
    :debug => true
)
println("Diccionario config: $config")

# 2.3 Uso en collect y otras funciones
println("\n2.3 Uso con collect y enumerate")
println("-" * 40)

# Con enumerate
lista = ["a", "b", "c", "d"]
indices_valores = collect(enumerate(lista))
println("collect(enumerate($lista)) = $indices_valores")

# ============================================================================
# 3. OPERADORES DE BROADCASTING
# ============================================================================

println("\n\n3. OPERADORES DE BROADCASTING")
println("=" * 50)

# 3.1 Operador . (punto)
println("\n3.1 Operador . (Punto - Broadcasting)")
println("-" * 42)

# Broadcasting en operaciones
arr1 = [1, 2, 3, 4]
arr2 = [10, 20, 30, 40]

suma_broadcast = arr1 .+ arr2
println("$arr1 .+ $arr2 = $suma_broadcast")

cuadrados_broadcast = arr1 .^ 2
println("$arr1 .^ 2 = $cuadrados_broadcast")

# Broadcasting con funciones
senos = sin.(arr1)
println("sin.($arr1) = $senos")

# Broadcasting con comparaciones
mayores = arr1 .> 2
println("$arr1 .> 2 = $mayores")

# 3.2 Broadcasting con matrices
println("\n3.2 Broadcasting con Matrices")
println("-" * 35)

matriz = [1 2 3; 4 5 6]
vector = [10, 20]

# Broadcasting suma (vector columna)
suma_matriz = matriz .+ vector
println("Broadcasting matriz + vector:")
println("$matriz .+ $vector =")
display(suma_matriz)

# ============================================================================
# 4. OPERADORES DE COMPARACIÓN Y LÓGICOS ENCADENADOS
# ============================================================================

println("\n\n4. OPERADORES ENCADENADOS")
println("=" * 50)

# 4.1 Comparaciones encadenadas
println("\n4.1 Comparaciones Encadenadas")
println("-" * 35)

x = 5
resultado_encadenado = 1 < x < 10
println("1 < $x < 10 = $resultado_encadenado")

y = 15
resultado_encadenado2 = 1 < y < 10
println("1 < $y < 10 = $resultado_encadenado2")

# Múltiples comparaciones
z = 7
resultado_multiple = 0 <= z <= 10 <= 20
println("0 <= $z <= 10 <= 20 = $resultado_multiple")

# ============================================================================
# 5. OPERADORES ESPECIALES DE JULIA
# ============================================================================

println("\n\n5. OPERADORES ESPECIALES")
println("=" * 50)

# 5.1 Operador \ (división izquierda)
println("\n5.1 Operador \\ (División Izquierda)")
println("-" * 38)

# Útil para álgebra lineal
A = [2 1; 1 3]
b = [3; 4]
x = A \ b
println("Resolver Ax = b:")
println("A = $A")
println("b = $b")
println("x = A \\ b = $x")

# 5.2 Operador ? : (ternario)
println("\n5.2 Operador ?: (Ternario)")
println("-" * 30)

edad = 18
estado = edad >= 18 ? "adulto" : "menor"
println("edad = $edad")
println("estado = edad >= 18 ? \"adulto\" : \"menor\" = $estado")

# Ternario anidado
puntuacion = 85
grado = puntuacion >= 90 ? "A" : puntuacion >= 80 ? "B" : puntuacion >= 70 ? "C" : "F"
println("puntuacion = $puntuacion")
println("grado = $grado")

# 5.3 Operador :: (anotación de tipo)
println("\n5.3 Operador :: (Anotación de Tipo)")
println("-" * 40)

function tipado(x::Int, y::Float64)::String
    return "x es $x (Int), y es $y (Float64)"
end

resultado_tipado = tipado(42, 3.14)
println("función tipada: $resultado_tipado")

# ============================================================================
# 6. PATRONES DE DESTRUCTURING
# ============================================================================

println("\n\n6. DESTRUCTURING (DESESTRUCTURACIÓN)")
println("=" * 50)

# 6.1 Tuplas
println("\n6.1 Destructuring de Tuplas")
println("-" * 32)

coordenada = (3, 4)
x, y = coordenada
println("coordenada = $coordenada")
println("x, y = coordenada -> x = $x, y = $y")

# Con funciones que devuelven múltiples valores
function obtener_nombre_edad()
    return "Ana", 25
end

nombre, edad = obtener_nombre_edad()
println("nombre, edad = obtener_nombre_edad() -> $nombre, $edad")

# 6.2 Arrays
println("\n6.2 Destructuring de Arrays")
println("-" * 31)

lista = [1, 2, 3, 4, 5]
primero, segundo, resto... = lista
println("lista = $lista")
println("primero, segundo, resto... = lista")
println("primero = $primero, segundo = $segundo, resto = $resto")

# ============================================================================
# 7. COMPREHENSIONS AVANZADAS
# ============================================================================

println("\n\n7. COMPREHENSIONS AVANZADAS")
println("=" * 50)

# 7.1 Array comprehensions
println("\n7.1 Array Comprehensions")
println("-" * 30)

# Básica
cuadrados_comp = [x^2 for x in 1:5]
println("[x^2 for x in 1:5] = $cuadrados_comp")

# Con condición
pares_cuadrados = [x^2 for x in 1:10 if x % 2 == 0]
println("[x^2 for x in 1:10 if x % 2 == 0] = $pares_cuadrados")

# Múltiples iteradores
productos = [x*y for x in 1:3, y in 1:3]
println("[x*y for x in 1:3, y in 1:3] =")
display(productos)

# 7.2 Dict comprehensions
println("\n7.2 Dict Comprehensions")
println("-" * 28)

cuadrados_dict = Dict(x => x^2 for x in 1:5)
println("Dict(x => x^2 for x in 1:5) = $cuadrados_dict")

# ============================================================================
# 8. MACROS IMPORTANTES
# ============================================================================

println("\n\n8. MACROS IMPORTANTES")
println("=" * 50)

# 8.1 @time
println("\n8.1 Macro @time")
println("-" * 20)

println("@time sqrt(2):")
@time sqrt(2)

# 8.2 @show
println("\n8.2 Macro @show")
println("-" * 20)

a = 42
b = 3.14
@show a + b

# 8.3 @assert
println("\n8.3 Macro @assert")
println("-" * 21)

x = 10
@assert x > 5 "x debe ser mayor que 5"
println("@assert x > 5 pasó correctamente")

# ============================================================================
# 9. DO BLOCKS
# ============================================================================

println("\n\n9. DO BLOCKS")
println("=" * 50)

# 9.1 Sintaxis do
println("\n9.1 Sintaxis do")
println("-" * 20)

# Equivalente a map(x -> x^2 + 1, [1,2,3,4])
resultado_do = map([1, 2, 3, 4]) do x
    x^2 + 1
end
println("map con do block: $resultado_do")

# Con múltiples líneas
resultado_complejo_do = map([1, 2, 3, 4, 5]) do x
    if x % 2 == 0
        x * 2
    else
        x * 3
    end
end
println("map complejo con do: $resultado_complejo_do")

# ============================================================================
# 10. SPLICING Y SPLATTING
# ============================================================================

println("\n\n10. SPLICING Y SPLATTING")
println("=" * 50)

# 10.1 Splatting con ...
println("\n10.1 Splatting con ...")
println("-" * 26)

function suma_tres(a, b, c)
    return a + b + c
end

valores = [1, 2, 3]
resultado_splat = suma_tres(valores...)
println("suma_tres(valores...) donde valores = $valores")
println("resultado = $resultado_splat")

# 10.2 Collecting con ...
println("\n10.2 Collecting con ...")
println("-" * 27)

function colectar_argumentos(primero, resto...)
    println("Primero: $primero")
    println("Resto: $resto")
    return primero, resto
end

resultado_collect = colectar_argumentos(1, 2, 3, 4, 5)
println("colectar_argumentos(1, 2, 3, 4, 5):")

# ============================================================================
# 11. MULTIPLE DISPATCH IDIOMS
# ============================================================================

println("\n\n11. MULTIPLE DISPATCH IDIOMS")
println("=" * 50)

# 11.1 Diferentes métodos para diferentes tipos
println("\n11.1 Métodos para Diferentes Tipos")
println("-" * 40)

# Definir función genérica
procesar_dato(x::Number) = "Procesando número: $x"
procesar_dato(x::String) = "Procesando texto: $x"
procesar_dato(x::Array) = "Procesando array de $(length(x)) elementos"

println("procesar_dato(42) = $(procesar_dato(42))")
println("procesar_dato(\"hola\") = $(procesar_dato("hola"))")
println("procesar_dato([1,2,3]) = $(procesar_dato([1,2,3]))")

# ============================================================================
# 12. PATRONES CON SÍMBOLOS
# ============================================================================

println("\n\n12. PATRONES CON SÍMBOLOS")
println("=" * 50)

# 12.1 Símbolos básicos
println("\n12.1 Símbolos Básicos")
println("-" * 24)

simbolo = :mi_simbolo
println("simbolo = :mi_simbolo")
println("typeof(simbolo) = $(typeof(simbolo))")

# Diccionario con símbolos (más eficiente)
config_simbolos = Dict(
    :nombre => "Julia",
    :version => "1.9",
    :rapido => true
)
println("Diccionario con símbolos: $config_simbolos")

# ============================================================================
# 13. PATRONES DE INICIALIZACIÓN
# ============================================================================

println("\n\n13. PATRONES DE INICIALIZACIÓN")
println("=" * 50)

# 13.1 Arrays especiales
println("\n13.1 Arrays Especiales")
println("-" * 26)

# Arrays de ceros y unos
ceros = zeros(3, 3)
unos = ones(2, 4)
println("zeros(3,3):")
display(ceros)
println("ones(2,4):")
display(unos)

# Rangos
rango = 1:2:10  # inicio:paso:fin
println("rango 1:2:10 = $(collect(rango))")

# ============================================================================
# 14. PATRONES DE STRING AVANZADOS
# ============================================================================

println("\n\n14. PATRONES DE STRING AVANZADOS")
println("=" * 50)

# 14.1 String interpolation avanzada
println("\n14.1 String Interpolation Avanzada")
println("-" * 40)

nombre = "Julia"
version = 1.9
mensaje = "Usando $nombre versión $version con $(2+2) núcleos"
println("mensaje = $mensaje")

# 14.2 Strings multilínea
println("\n14.2 Strings Multilínea")
println("-" * 28)

poema = """
    Las rosas son rojas,
    Las violetas son azules,
    Julia es rápida,
    Y elegante también.
    """
println("Poema multilínea:")
println(poema)

# ============================================================================
# 15. MEJORES PRÁCTICAS IDIOMÁTICAS
# ============================================================================

println("\n\n15. MEJORES PRÁCTICAS IDIOMÁTICAS")
println("=" * 50)

println("\n15.1 Preferir comprehensions sobre loops cuando sea apropiado")
# En lugar de:
# resultado = []
# for i in 1:10
#     if i % 2 == 0
#         push!(resultado, i^2)
#     end
# end

# Usar:
resultado_idiomatico = [i^2 for i in 1:10 if i % 2 == 0]
println("Comprehension idiomática: $resultado_idiomatico")

println("\n15.2 Usar broadcasting en lugar de loops para operaciones elemento a elemento")
arr = [1, 2, 3, 4, 5]
# En lugar de map(x -> x^2, arr), usar:
cuadrados_idiomatico = arr .^ 2
println("Broadcasting idiomático: $cuadrados_idiomatico")

println("\n15.3 Usar pipeline para transformaciones secuenciales")
resultado_pipeline_idiomatico = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10] |>
    x -> filter(iseven, x) |>
    x -> x .^ 2 |>
    sum
println("Pipeline idiomático: $resultado_pipeline_idiomatico")

println("\n15.4 Usar múltiple dispatch en lugar de condicionales tipo-específicos")
println("Ver ejemplo en sección 11.1")

println("\n15.5 Preferir símbolos sobre strings para claves que no cambian")
println("Ver ejemplo en sección 12.1")

# ============================================================================
# RESUMEN DE OPERADORES
# ============================================================================

println("\n\n" * "=" * 60)
println("RESUMEN DE OPERADORES IDIOMÁTICOS DE JULIA")
println("=" * 60)

operadores = [
    ("->", "Funciones anónimas", "x -> x^2"),
    ("=>", "Pairs y diccionarios", "\"clave\" => \"valor\""),
    ("|>", "Pipeline", "x |> f |> g"),
    (".", "Broadcasting", "arr .+ 1"),
    ("\\", "División izquierda", "A \\ b"),
    ("?:", "Operador ternario", "x > 0 ? \"pos\" : \"neg\""),
    ("::", "Anotación de tipo", "x::Int"),
    ("...", "Splatting/Slurping", "f(args...)"),
    (":", "Símbolos", ":symbol"),
    ("do", "Do blocks", "map(arr) do x; x^2; end")
]

for (op, desc, ejemplo) in operadores
    println("$(rpad(op, 4)) | $(rpad(desc, 25)) | $ejemplo")
end

println("\n¡Dominar estos patrones te hará un programador Julia más idiomático y eficiente!")
