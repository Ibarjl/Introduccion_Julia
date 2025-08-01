# Ejercicio 2: Operaciones Básicas en Julia
# Aprende las operaciones aritméticas fundamentales

# Operaciones aritméticas básicas
a = 10
b = 3

suma = a + b
resta = a - b
multiplicacion = a * b
division = a / b
division_entera = a ÷ b  # o div(a, b)
modulo = a % b
potencia = a ^ b

println("Números: a = $a, b = $b")
println("Suma: $a + $b = $suma")
println("Resta: $a - $b = $resta")
println("Multiplicación: $a * $b = $multiplicacion")
println("División: $a / $b = $division")
println("División entera: $a ÷ $b = $division_entera")
println("Módulo: $a % $b = $modulo")
println("Potencia: $a ^ $b = $potencia")

# Operaciones con precedencia
resultado1 = 2 + 3 * 4
resultado2 = (2 + 3) * 4
println("\nPrecedencia:")
println("2 + 3 * 4 = $resultado1")
println("(2 + 3) * 4 = $resultado2")

# Operaciones con números decimales
x = 3.7
y = 2.1
println("\nOperaciones con decimales:")
println("$x + $y = $(x + y)")
println("$x - $y = $(x - y)")
println("$x * $y = $(x * y)")
println("$x / $y = $(x / y)")

# Ejercicios para practicar:
# 1. Calcula el área de un círculo con radio 5
# 2. Convierte temperatura de Celsius a Fahrenheit
# 3. Calcula el promedio de tres números
