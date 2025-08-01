# Ejercicio 4: Vectores (Arrays) en Julia
# Aprende a trabajar con vectores y arrays

# Declaración de vectores
numeros = [1, 2, 3, 4, 5]
frutas = ["manzana", "banana", "naranja"]
mixto = [1, "dos", 3.0, true]

println("Números: $numeros")
println("Frutas: $frutas")
println("Mixto: $mixto")

# Propiedades de vectores
longitud = length(numeros)
println("Longitud del vector números: $longitud")

# Acceso a elementos (indexado desde 1)
primer_numero = numeros[1]
ultima_fruta = frutas[end]
println("Primer número: $primer_numero")
println("Última fruta: $ultima_fruta")

# Modificar elementos
numeros[1] = 10
println("Números modificados: $numeros")

# Agregar elementos
push!(frutas, "uva")
println("Frutas después de agregar: $frutas")

# Eliminar elementos
pop!(frutas)  # Elimina el último
println("Frutas después de eliminar: $frutas")

# Crear vectores con rangos
rango = collect(1:10)
pares = collect(2:2:20)
println("Rango 1-10: $rango")
println("Números pares: $pares")

# Operaciones con vectores
suma_total = sum(numeros)
promedio = sum(numeros) / length(numeros)
maximo = maximum(numeros)
minimo = minimum(numeros)

println("Suma total: $suma_total")
println("Promedio: $promedio")
println("Máximo: $maximo")
println("Mínimo: $minimo")

# Vectores multidimensionales
matriz = [[1, 2], [3, 4], [5, 6]]
println("Matriz: $matriz")

# Filtrar elementos
mayores_que_dos = filter(x -> x > 2, numeros)
println("Números mayores que 2: $mayores_que_dos")

# Mapear operaciones
cuadrados = map(x -> x^2, numeros)
println("Cuadrados: $cuadrados")

# Ejercicios para practicar:
# 1. Crea un vector con los días de la semana
# 2. Calcula la suma de los números del 1 al 100
# 3. Encuentra todos los números impares en un rango
