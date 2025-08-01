# Operaciones de Módulo en Julia
# Funciones auxiliares para trabajar con operaciones modulares

"""
    Módulo OperacionesModulo

Proporciona funciones útiles para realizar operaciones modulares
y trabajar con aritmética modular en Julia.
"""
module OperacionesModulo

export  potencia_modular, mcd_extendido, inverso_modular, 
        es_primo_fermat, generar_primos, factorizar

"""
    potencia_modular(base, exponente, modulo)

Calcula (base^exponente) mod modulo de forma eficiente usando
exponenciación rápida para evitar desbordamiento.

# Ejemplos
```julia
julia> potencia_modular(3, 200, 7)
4

julia> potencia_modular(2, 10, 1000)
24
```
"""
function potencia_modular(base::Integer, exponente::Integer, modulo::Integer)
    if modulo == 1
        return 0
    end
    
    resultado = 1
    base = base % modulo
    
    while exponente > 0
        # Si el exponente es impar, multiplica base con resultado
        if exponente % 2 == 1
            resultado = (resultado * base) % modulo
        end
        
        # Divide exponente por 2
        exponente = exponente ÷ 2
        base = (base * base) % modulo
    end
    
    return resultado
end

"""
    mcd_extendido(a, b)

Calcula el máximo común divisor de a y b usando el algoritmo 
extendido de Euclides, devolviendo (mcd, x, y) donde ax + by = mcd.

# Ejemplos
```julia
julia> mcd_extendido(30, 18)
(6, -1, 2)

julia> mcd_extendido(35, 15)
(5, 1, -2)
```
"""
function mcd_extendido(a::Integer, b::Integer)
    if a == 0
        return (b, 0, 1)
    end
    
    mcd_val, x1, y1 = mcd_extendido(b % a, a)
    x = y1 - (b ÷ a) * x1
    y = x1
    
    return (mcd_val, x, y)
end

"""
    inverso_modular(a, m)

Encuentra el inverso modular de a módulo m.
Devuelve un entero x tal que (a * x) ≡ 1 (mod m),
o nothing si no existe el inverso.

# Ejemplos
```julia
julia> inverso_modular(3, 7)
5

julia> inverso_modular(2, 6)
nothing
```
"""
function inverso_modular(a::Integer, m::Integer)
    mcd_val, x, y = mcd_extendido(a, m)
    
    if mcd_val != 1
        return nothing  # No existe inverso modular
    end
    
    # Asegurar que el resultado sea positivo
    return (x % m + m) % m
end

"""
    es_primo_fermat(n, k=5)

Prueba de primalidad probabilística usando el pequeño teorema de Fermat.
Realiza k pruebas. Si devuelve false, n definitivamente es compuesto.
Si devuelve true, n es probablemente primo.

# Ejemplos
```julia
julia> es_primo_fermat(17)
true

julia> es_primo_fermat(15)
false
```
"""
function es_primo_fermat(n::Integer, k::Integer=5)
    # Casos especiales
    if n <= 1
        return false
    end
    if n <= 3
        return true
    end
    if n % 2 == 0
        return false
    end
    
    # Realizar k pruebas
    for _ in 1:k
        a = rand(2:n-1)
        if potencia_modular(a, n-1, n) != 1
            return false
        end
    end
    
    return true
end

"""
    generar_primos(limite)

Genera todos los números primos menores o iguales a limite
usando la Criba de Eratóstenes.

# Ejemplos
```julia
julia> generar_primos(20)
8-element Vector{Int64}:
  2
  3
  5
  7
 11
 13
 17
 19
```
"""
function generar_primos(limite::Integer)
    if limite < 2
        return Int[]
    end
    
    # Inicializar criba
    es_primo = fill(true, limite)
    es_primo[1] = false
    
    # Criba de Eratóstenes
    for i in 2:Int(√limite)
        if es_primo[i]
            for j in i*i:i:limite
                es_primo[j] = false
            end
        end
    end
    
    # Recopilar números primos
    primos = Int[]
    for i in 2:limite
        if es_primo[i]
            push!(primos, i)
        end
    end
    
    return primos
end

"""
    factorizar(n)

Encuentra la factorización prima de n.
Devuelve un diccionario donde las claves son los factores primos
y los valores son sus exponentes.

# Ejemplos
```julia
julia> factorizar(60)
Dict{Int64, Int64} with 3 entries:
  5 => 1
  2 => 2
  3 => 1

julia> factorizar(100)
Dict{Int64, Int64} with 2 entries:
  5 => 2
  2 => 2
```
"""
function factorizar(n::Integer)
    if n <= 1
        return Dict{Int, Int}()
    end
    
    factores = Dict{Int, Int}()
    
    # Dividir por 2
    while n % 2 == 0
        factores[2] = get(factores, 2, 0) + 1
        n ÷= 2
    end
    
    # Dividir por números impares
    i = 3
    while i * i <= n
        while n % i == 0
            factores[i] = get(factores, i, 0) + 1
            n ÷= i
        end
        i += 2
    end
    
    # Si n es un primo mayor que 2
    if n > 2
        factores[n] = get(factores, n, 0) + 1
    end
    
    return factores
end

"""
    euler_phi(n)

Calcula la función φ de Euler (Euler's totient function).
Cuenta cuántos enteros positivos menores o iguales a n
son coprimos con n.

# Ejemplos
```julia
julia> euler_phi(9)
6

julia> euler_phi(10)
4
```
"""
function euler_phi(n::Integer)
    if n == 1
        return 1
    end
    
    factores = factorizar(n)
    resultado = n
    
    for primo in keys(factores)
        resultado = resultado * (primo - 1) ÷ primo
    end
    
    return resultado
end

"""
    congruencia_lineal(a, b, m)

Resuelve la congruencia lineal ax ≡ b (mod m).
Devuelve todas las soluciones en el rango [0, m-1],
o un array vacío si no hay solución.

# Ejemplos
```julia
julia> congruencia_lineal(3, 4, 7)
[6]

julia> congruencia_lineal(2, 3, 6)
Int64[]
```
"""
function congruencia_lineal(a::Integer, b::Integer, m::Integer)
    mcd_val, x, y = mcd_extendido(a, m)
    
    if b % mcd_val != 0
        return Int[]  # No hay solución
    end
    
    # Reducir la congruencia
    a_red = a ÷ mcd_val
    b_red = b ÷ mcd_val
    m_red = m ÷ mcd_val
    
    # Encontrar una solución particular
    x_0 = (inverso_modular(a_red, m_red) * b_red) % m_red
    
    # Generar todas las soluciones
    soluciones = Int[]
    for i in 0:mcd_val-1
        sol = (x_0 + i * m_red) % m
        push!(soluciones, sol)
    end
    
    return sort(soluciones)
end

# Demostración de las funciones
function demo_operaciones_modulo()
    println("=== DEMO: OPERACIONES MODULARES ===\n")
    
    # Exponenciación modular
    println("1. Exponenciación Modular:")
    println("   3^200 mod 7 = $(potencia_modular(3, 200, 7))")
    println("   2^100 mod 13 = $(potencia_modular(2, 100, 13))")
    
    # MCD extendido
    println("\n2. MCD Extendido:")
    mcd_val, x, y = mcd_extendido(30, 18)
    println("   MCD(30, 18) = $mcd_val")
    println("   30×($x) + 18×($y) = $mcd_val")
    
    # Inverso modular
    println("\n3. Inverso Modular:")
    inv = inverso_modular(3, 7)
    println("   Inverso de 3 mod 7 = $inv")
    println("   Verificación: 3×$inv mod 7 = $((3*inv) % 7)")
    
    # Prueba de primalidad
    println("\n4. Prueba de Primalidad (Fermat):")
    numeros_test = [17, 21, 97, 100]
    for num in numeros_test
        es_primo = es_primo_fermat(num)
        println("   $num es primo: $es_primo")
    end
    
    # Generación de primos
    println("\n5. Primos hasta 30:")
    primos = generar_primos(30)
    println("   $primos")
    
    # Factorización
    println("\n6. Factorización:")
    numeros = [60, 100, 144]
    for num in numeros
        fact = factorizar(num)
        println("   $num = ", join(["$p^$e" for (p, e) in sort(collect(fact))], " × "))
    end
    
    # Función φ de Euler
    println("\n7. Función φ de Euler:")
    for n in [6, 9, 10, 12]
        phi_n = euler_phi(n)
        println("   φ($n) = $phi_n")
    end
    
    # Congruencias lineales
    println("\n8. Congruencias Lineales:")
    casos = [(3, 4, 7), (2, 3, 6), (5, 7, 12)]
    for (a, b, m) in casos
        sols = congruencia_lineal(a, b, m)
        if isempty(sols)
            println("   $(a)x ≡ $b (mod $m): Sin solución")
        else
            println("   $(a)x ≡ $b (mod $m): x = $(join(sols, ", "))")
        end
    end
end

end # module OperacionesModulo

# Ejecutar demostración si el archivo se ejecuta directamente
if abspath(PROGRAM_FILE) == @__FILE__
    using .OperacionesModulo
    demo_operaciones_modulo()
end
