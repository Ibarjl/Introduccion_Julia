# Ejercicio Intermedio 4: Generador de Números Primos
# Encuentra y genera números primos usando diferentes algoritmos

function es_primo_basico(n)
    """Algoritmo básico para verificar si un número es primo"""
    if n < 2
        return false
    end
    
    if n == 2
        return true
    end
    
    if n % 2 == 0
        return false
    end
    
    # Verificar divisibilidad hasta la raíz cuadrada
    for i in 3:2:Int(sqrt(n))
        if n % i == 0
            return false
        end
    end
    
    return true
end

function es_primo_optimizado(n)
    """Versión optimizada del test de primalidad"""
    if n < 2
        return false
    end
    
    if n == 2 || n == 3
        return true
    end
    
    if n % 2 == 0 || n % 3 == 0
        return false
    end
    
    # Verificar números de la forma 6k ± 1
    i = 5
    while i * i <= n
        if n % i == 0 || n % (i + 2) == 0
            return false
        end
        i += 6
    end
    
    return true
end

function criba_eratostenes(limite)
    """Implementa la Criba de Eratóstenes para encontrar primos hasta un límite"""
    if limite < 2
        return Int[]
    end
    
    # Crear array de candidatos
    es_primo = fill(true, limite)
    es_primo[1] = false  # 1 no es primo
    
    for i in 2:Int(sqrt(limite))
        if es_primo[i]
            # Marcar múltiplos como no primos
            for j in (i*i):i:limite
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

function generar_primos_hasta(limite)
    """Genera primos hasta un límite usando el método optimizado"""
    primos = Int[]
    
    for i in 2:limite
        if es_primo_optimizado(i)
            push!(primos, i)
        end
    end
    
    return primos
end

function siguiente_primo(n)
    """Encuentra el siguiente número primo después de n"""
    candidato = n + 1
    while !es_primo_optimizado(candidato)
        candidato += 1
    end
    return candidato
end

function primos_en_rango(inicio, fin)
    """Encuentra todos los primos en un rango específico"""
    primos = Int[]
    
    for i in inicio:fin
        if es_primo_optimizado(i)
            push!(primos, i)
        end
    end
    
    return primos
end

function factorizacion_prima(n)
    """Encuentra la factorización en números primos de n"""
    if n < 2
        return Int[]
    end
    
    factores = Int[]
    
    # Verificar factor de 2
    while n % 2 == 0
        push!(factores, 2)
        n = n ÷ 2
    end
    
    # Verificar factores impares
    factor = 3
    while factor * factor <= n
        while n % factor == 0
            push!(factores, factor)
            n = n ÷ factor
        end
        factor += 2
    end
    
    # Si n es un primo mayor que 2
    if n > 2
        push!(factores, n)
    end
    
    return factores
end

function es_primo_wilson(n)
    """Test de Wilson: (p-1)! ≡ -1 (mod p) si y solo si p es primo"""
    # Solo práctico para números pequeños debido al factorial
    if n < 2
        return false
    end
    
    if n > 20  # Limitamos por el costo computacional del factorial
        return es_primo_optimizado(n)
    end
    
    factorial_n_minus_1 = 1
    for i in 1:(n-1)
        factorial_n_minus_1 = (factorial_n_minus_1 * i) % n
    end
    
    return factorial_n_minus_1 == n - 1
end

function contar_primos_hasta(limite)
    """Cuenta cuántos primos hay hasta un límite"""
    contador = 0
    for i in 2:limite
        if es_primo_optimizado(i)
            contador += 1
        end
    end
    return contador
end

function estadisticas_primos(primos)
    """Calcula estadísticas sobre una lista de primos"""
    if isempty(primos)
        return Dict()
    end
    
    gaps = [primos[i+1] - primos[i] for i in 1:length(primos)-1]
    
    return Dict(
        "cantidad" => length(primos),
        "menor" => minimum(primos),
        "mayor" => maximum(primos),
        "suma" => sum(primos),
        "promedio" => sum(primos) / length(primos),
        "gap_promedio" => isempty(gaps) ? 0 : sum(gaps) / length(gaps),
        "gap_maximo" => isempty(gaps) ? 0 : maximum(gaps)
    )
end

function primos_gemelos(limite)
    """Encuentra pares de primos gemelos (primos que difieren en 2)"""
    gemelos = Tuple{Int,Int}[]
    primos = generar_primos_hasta(limite)
    
    for i in 1:length(primos)-1
        if primos[i+1] - primos[i] == 2
            push!(gemelos, (primos[i], primos[i+1]))
        end
    end
    
    return gemelos
end

function benchmark_algoritmos(limite)
    """Compara el rendimiento de diferentes algoritmos"""
    println("🏃 BENCHMARK DE ALGORITMOS (límite: $limite)")
    println("-" ^ 50)
    
    # Algoritmo básico
    @time primos_basico = [i for i in 2:limite if es_primo_basico(i)]
    println("Algoritmo básico: $(length(primos_basico)) primos encontrados")
    
    # Algoritmo optimizado
    @time primos_optimizado = [i for i in 2:limite if es_primo_optimizado(i)]
    println("Algoritmo optimizado: $(length(primos_optimizado)) primos encontrados")
    
    # Criba de Eratóstenes
    @time primos_criba = criba_eratostenes(limite)
    println("Criba de Eratóstenes: $(length(primos_criba)) primos encontrados")
    
    # Verificar que todos dan el mismo resultado
    if primos_basico == primos_optimizado == primos_criba
        println("✅ Todos los algoritmos produjeron el mismo resultado")
    else
        println("❌ Los algoritmos produjeron resultados diferentes")
    end
end

function menu_interactivo()
    """Menú interactivo para explorar números primos"""
    println("🔢 GENERADOR DE NÚMEROS PRIMOS")
    println("=" ^ 40)
    
    while true
        println("\nOpciones:")
        println("1. Verificar si un número es primo")
        println("2. Generar primos hasta un límite")
        println("3. Encontrar primos en un rango")
        println("4. Factorización prima")
        println("5. Siguiente primo")
        println("6. Primos gemelos")
        println("7. Estadísticas de primos")
        println("8. Benchmark de algoritmos")
        println("0. Salir")
        print("Selecciona una opción: ")
        
        try
            opcion = parse(Int, readline())
            
            if opcion == 0
                println("¡Hasta luego!")
                break
                
            elseif opcion == 1
                print("Ingresa un número: ")
                n = parse(Int, readline())
                resultado = es_primo_optimizado(n)
                println("$n $(resultado ? "ES" : "NO ES") primo")
                
            elseif opcion == 2
                print("Ingresa el límite: ")
                limite = parse(Int, readline())
                primos = generar_primos_hasta(limite)
                println("Primos hasta $limite: $(length(primos))")
                if length(primos) <= 50
                    println("Primos: $(join(primos, ", "))")
                else
                    println("Primeros 20: $(join(primos[1:20], ", "))...")
                    println("Últimos 20: $(join(primos[end-19:end], ", "))")
                end
                
            elseif opcion == 3
                print("Inicio del rango: ")
                inicio = parse(Int, readline())
                print("Fin del rango: ")
                fin = parse(Int, readline())
                primos = primos_en_rango(inicio, fin)
                println("Primos entre $inicio y $fin: $(join(primos, ", "))")
                
            elseif opcion == 4
                print("Número a factorizar: ")
                n = parse(Int, readline())
                factores = factorizacion_prima(n)
                println("Factorización prima de $n: $(join(factores, " × "))")
                println("Verificación: $(prod(factores)) = $n")
                
            elseif opcion == 5
                print("Número base: ")
                n = parse(Int, readline())
                siguiente = siguiente_primo(n)
                println("El siguiente primo después de $n es: $siguiente")
                
            elseif opcion == 6
                print("Límite para buscar primos gemelos: ")
                limite = parse(Int, readline())
                gemelos = primos_gemelos(limite)
                println("Primos gemelos hasta $limite:")
                for (p1, p2) in gemelos[1:min(20, length(gemelos))]
                    println("  ($p1, $p2)")
                end
                if length(gemelos) > 20
                    println("  ... y $(length(gemelos) - 20) más")
                end
                
            elseif opcion == 7
                print("Límite para estadísticas: ")
                limite = parse(Int, readline())
                primos = generar_primos_hasta(limite)
                stats = estadisticas_primos(primos)
                println("\n📊 ESTADÍSTICAS DE PRIMOS:")
                for (clave, valor) in stats
                    if isa(valor, Float64)
                        println("  $clave: $(round(valor, digits=2))")
                    else
                        println("  $clave: $valor")
                    end
                end
                
            elseif opcion == 8
                print("Límite para benchmark: ")
                limite = parse(Int, readline())
                benchmark_algoritmos(limite)
                
            else
                println("Opción no válida")
            end
            
        catch e
            println("Error: $e")
        end
        
        println("\nPresiona Enter para continuar...")
        readline()
    end
end

function test_generador_primos()
    """Función de testing"""
    println("=== TESTING GENERADOR DE PRIMOS ===\n")
    
    # Test básico de primalidad
    test_numbers = [2, 3, 4, 5, 17, 25, 29, 97, 100]
    expected = [true, true, false, true, true, false, true, true, false]
    
    println("🧪 Test de primalidad:")
    for (num, exp) in zip(test_numbers, expected)
        result = es_primo_optimizado(num)
        status = result == exp ? "✅" : "❌"
        println("$status $num es primo: $result (esperado: $exp)")
    end
    
    # Test de criba
    println("\n🔍 Test de Criba de Eratóstenes:")
    primos_hasta_30 = criba_eratostenes(30)
    esperados = [2, 3, 5, 7, 11, 13, 17, 19, 23, 29]
    println("Primos hasta 30: $(join(primos_hasta_30, ", "))")
    println("Correcto: $(primos_hasta_30 == esperados ? "✅" : "❌")")
    
    # Test de factorización
    println("\n🔢 Test de factorización:")
    test_factorization = [(12, [2, 2, 3]), (17, [17]), (60, [2, 2, 3, 5])]
    for (num, expected_factors) in test_factorization
        factors = factorizacion_prima(num)
        correct = factors == expected_factors
        status = correct ? "✅" : "❌"
        println("$status Factorización de $num: $(join(factors, "×")) (esperado: $(join(expected_factors, "×")))")
    end
    
    # Estadísticas de ejemplo
    primos_100 = generar_primos_hasta(100)
    stats = estadisticas_primos(primos_100)
    println("\n📊 Estadísticas de primos hasta 100:")
    println("Cantidad: $(stats["cantidad"])")
    println("Gap promedio: $(round(stats["gap_promedio"], digits=2))")
end

# Ejecutar tests
test_generador_primos()

# Descomenta la siguiente línea para la versión interactiva
# menu_interactivo()

println("\n¡Generador de primos implementado! Descomenta 'menu_interactivo()' para usarlo.")
