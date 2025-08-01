# Ejercicio 10: Funciones en Julia
# Aprende a crear y usar funciones

# Función básica
function saludar()
    println("¡Hola mundo!")
end

# Llamar la función
saludar()

# Función con parámetros
function saludar_persona(nombre)
    println("¡Hola $nombre!")
end

saludar_persona("Julia")

# Función con múltiples parámetros
function sumar(a, b)
    return a + b
end

resultado = sumar(5, 3)
println("5 + 3 = $resultado")

# Función con valor de retorno implícito
function multiplicar(x, y)
    x * y  # El último valor se retorna automáticamente
end

producto = multiplicar(4, 6)
println("4 × 6 = $producto")

# Función con parámetros por defecto
function saludar_con_titulo(nombre, titulo="Sr./Sra.")
    println("¡Hola $titulo $nombre!")
end

saludar_con_titulo("García")
saludar_con_titulo("García", "Dr.")

# Función con argumentos con nombre (keyword arguments)
function crear_perfil(nombre; edad=0, ciudad="No especificada")
    println("Nombre: $nombre")
    println("Edad: $edad")
    println("Ciudad: $ciudad")
end

crear_perfil("Ana")
crear_perfil("Carlos", edad=25, ciudad="Madrid")

# Función que retorna múltiples valores
function dividir_con_resto(dividendo, divisor)
    cociente = dividendo ÷ divisor
    resto = dividendo % divisor
    return cociente, resto
end

c, r = dividir_con_resto(17, 5)
println("17 ÷ 5 = $c, resto = $r")

# Funciones anónimas (lambda)
cuadrado = x -> x^2
println("Cuadrado de 5: $(cuadrado(5))")

# Función anónima con múltiples parámetros
suma_anonima = (a, b) -> a + b
println("Suma anónima: $(suma_anonima(3, 7))")

# Funciones de orden superior
numeros = [1, 2, 3, 4, 5]
cuadrados = map(x -> x^2, numeros)
println("Cuadrados: $cuadrados")

pares = filter(x -> x % 2 == 0, numeros)
println("Números pares: $pares")

# Función recursiva
function factorial(n)
    if n <= 1
        return 1
    else
        return n * factorial(n - 1)
    end
end

fact_5 = factorial(5)
println("Factorial de 5: $fact_5")

# Función con tipo de parámetros especificado
function area_circulo(radio::Float64)::Float64
    return π * radio^2
end

area = area_circulo(3.0)
println("Área del círculo: $area")

# Función con argumentos variables
function sumar_todos(numeros...)
    suma = 0
    for num in numeros
        suma += num
    end
    return suma
end

total = sumar_todos(1, 2, 3, 4, 5)
println("Suma de varios números: $total")

# Función que modifica argumentos
function incrementar!(array)
    for i in 1:length(array)
        array[i] += 1
    end
end

mi_array = [1, 2, 3]
println("Antes: $mi_array")
incrementar!(mi_array)
println("Después: $mi_array")

# Función con documentación
"""
    calcular_promedio(numeros)

Calcula el promedio aritmético de una lista de números.

# Argumentos
- `numeros`: Array de números

# Retorna
- El promedio de los números

# Ejemplo
```julia
promedio = calcular_promedio([1, 2, 3, 4, 5])
```
"""
function calcular_promedio(numeros)
    return sum(numeros) / length(numeros)
end

promedio = calcular_promedio([10, 20, 30])
println("Promedio: $promedio")

# Función anidada
function operacion_compleja(x)
    function operacion_interna(y)
        return y^2 + 1
    end
    
    return operacion_interna(x) * 2
end

resultado_complejo = operacion_compleja(3)
println("Operación compleja: $resultado_complejo")

# Ejercicios para practicar:
# 1. Crea una función que determine si un número es primo
# 2. Escribe una función que invierta una cadena
# 3. Implementa una función que calcule la secuencia de Fibonacci
