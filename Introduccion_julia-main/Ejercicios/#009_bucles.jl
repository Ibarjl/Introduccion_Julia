# Ejercicio 9: Bucles en Julia
# Aprende a usar bucles for y while

# Bucle for básico
println("Contando del 1 al 5:")
for i in 1:5
    println("Número: $i")
end

# Bucle for con arrays
frutas = ["manzana", "banana", "naranja"]
println("\nFrutas:")
for fruta in frutas
    println("Me gusta la $fruta")
end

# Bucle for con índices
println("\nFrutas con índices:")
for (indice, fruta) in enumerate(frutas)
    println("$indice: $fruta")
end

# Bucle for con diccionarios
edades = Dict("Ana" => 25, "Carlos" => 30, "María" => 28)
println("\nEdades:")
for (nombre, edad) in edades
    println("$nombre tiene $edad años")
end

# Bucle while
contador = 1
println("\nBucle while (1 a 3):")
while contador <= 3
    println("Contador: $contador")
    contador += 1
end

# Bucle while con condición
numero = 16
println("\nDividiendo $numero por 2 hasta que sea menor que 2:")
while numero >= 2
    println("Número actual: $numero")
    numero = numero / 2
end

# Bucles anidados
println("\nTabla de multiplicar (3x3):")
for i in 1:3
    for j in 1:3
        resultado = i * j
        print("$i×$j=$resultado  ")
    end
    println()  # Nueva línea
end

# break - salir del bucle
println("\nBuscando el primer número par:")
for num in [1, 3, 5, 4, 7, 8]
    if num % 2 == 0
        println("Encontré el número par: $num")
        break
    end
    println("$num es impar")
end

# continue - saltar a la siguiente iteración
println("\nSolo números impares:")
for num in 1:8
    if num % 2 == 0
        continue  # Saltar números pares
    end
    println("Número impar: $num")
end

# Comprensiones de arrays (array comprehensions)
cuadrados = [x^2 for x in 1:5]
println("\nCuadrados: $cuadrados")

pares = [x for x in 1:10 if x % 2 == 0]
println("Números pares: $pares")

# Bucle for con múltiples variables
puntos = [(1, 2), (3, 4), (5, 6)]
println("\nPuntos:")
for (x, y) in puntos
    println("Punto: ($x, $y)")
end

# Bucle infinito con break
println("\nBucle infinito con break:")
i = 1
while true
    println("Iteración $i")
    i += 1
    if i > 3
        break
    end
end

# Bucle for con step
println("\nContando de 2 en 2:")
for i in 1:2:10
    println("Número: $i")
end

# Bucle for hacia atrás
println("\nCuenta regresiva:")
for i in 5:-1:1
    println("$i")
end
println("¡Despegue!")

# Bucle con zip (combinar arrays)
nombres = ["Ana", "Carlos", "María"]
edades_array = [25, 30, 28]
println("\nCombinando arrays:")
for (nombre, edad) in zip(nombres, edades_array)
    println("$nombre: $edad años")
end

# Acumular valores en bucles
suma = 0
for i in 1:10
    suma += i
end
println("\nSuma de 1 a 10: $suma")

# Ejercicios para practicar:
# 1. Calcula el factorial de un número usando un bucle
# 2. Encuentra todos los números primos menores que 50
# 3. Crea un patrón de asteriscos en forma de triángulo
