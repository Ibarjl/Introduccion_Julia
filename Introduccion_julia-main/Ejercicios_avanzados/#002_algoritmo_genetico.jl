# Ejercicio Avanzado 2: Algoritmo Genético Simple
# Implementa un algoritmo genético para optimización

using Random

# Estructuras para el algoritmo genético
mutable struct Individuo
    genes::Vector{Float64}
    fitness::Float64
    
    Individuo(genes) = new(genes, 0.0)
end

mutable struct Poblacion
    individuos::Vector{Individuo}
    tamaño::Int
    generacion::Int
    mejor_fitness::Float64
    mejor_individuo::Individuo
    
    function Poblacion(tamaño, longitud_cromosoma, rango_genes=(-10.0, 10.0))
        individuos = [crear_individuo_aleatorio(longitud_cromosoma, rango_genes) for _ in 1:tamaño]
        new(individuos, tamaño, 0, -Inf, individuos[1])
    end
end

# Funciones de utilidad
function crear_individuo_aleatorio(longitud, rango=(-10.0, 10.0))
    """Crea un individuo con genes aleatorios"""
    genes = rand(longitud) * (rango[2] - rango[1]) .+ rango[1]
    return Individuo(genes)
end

# Funciones objetivo de ejemplo
function funcion_esfera(x::Vector{Float64})
    """Función esfera: f(x) = sum(xi^2) - minimizar"""
    return -sum(x.^2)  # Negativo porque queremos maximizar fitness
end

function funcion_rastrigin(x::Vector{Float64})
    """Función de Rastrigin: más compleja con múltiples óptimos locales"""
    A = 10
    n = length(x)
    return -(A * n + sum(x.^2 - A * cos.(2 * π * x)))
end

function funcion_rosenbrock(x::Vector{Float64})
    """Función de Rosenbrock: valle con óptimo global en (1,1,...)"""
    if length(x) < 2
        return 0.0
    end
    
    suma = 0.0
    for i in 1:(length(x)-1)
        suma += 100 * (x[i+1] - x[i]^2)^2 + (1 - x[i])^2
    end
    return -suma
end

function problema_mochila(x::Vector{Float64}, pesos, valores, capacidad)
    """Problema de la mochila: maximizar valor sujeto a restricción de peso"""
    # Convertir genes reales a binarios usando umbral
    seleccion = x .> 0.5
    
    peso_total = sum(pesos[seleccion])
    if peso_total > capacidad
        return 0.0  # Penalización por exceder capacidad
    end
    
    return sum(valores[seleccion])
end

# Operadores genéticos
function seleccion_torneo(poblacion::Poblacion, tamaño_torneo=3)
    """Selección por torneo"""
    candidatos = sample(poblacion.individuos, tamaño_torneo, replace=false)
    return candidatos[argmax([ind.fitness for ind in candidatos])]
end

function seleccion_ruleta(poblacion::Poblacion)
    """Selección por ruleta (proporcional al fitness)"""
    # Ajustar fitness para que todos sean positivos
    min_fitness = minimum([ind.fitness for ind in poblacion.individuos])
    fitness_ajustados = [ind.fitness - min_fitness + 1e-6 for ind in poblacion.individuos]
    
    total_fitness = sum(fitness_ajustados)
    probabilidades = fitness_ajustados / total_fitness
    
    r = rand()
    suma_acumulada = 0.0
    
    for (i, prob) in enumerate(probabilidades)
        suma_acumulada += prob
        if r <= suma_acumulada
            return poblacion.individuos[i]
        end
    end
    
    return poblacion.individuos[end]
end

function crossover_uniforme(padre1::Individuo, padre2::Individuo, prob_crossover=0.8)
    """Crossover uniforme"""
    if rand() > prob_crossover
        return deepcopy(padre1), deepcopy(padre2)
    end
    
    hijo1_genes = copy(padre1.genes)
    hijo2_genes = copy(padre2.genes)
    
    for i in 1:length(padre1.genes)
        if rand() < 0.5
            hijo1_genes[i], hijo2_genes[i] = hijo2_genes[i], hijo1_genes[i]
        end
    end
    
    return Individuo(hijo1_genes), Individuo(hijo2_genes)
end

function crossover_aritmetico(padre1::Individuo, padre2::Individuo, prob_crossover=0.8)
    """Crossover aritmético"""
    if rand() > prob_crossover
        return deepcopy(padre1), deepcopy(padre2)
    end
    
    alpha = rand()
    
    hijo1_genes = alpha * padre1.genes + (1 - alpha) * padre2.genes
    hijo2_genes = (1 - alpha) * padre1.genes + alpha * padre2.genes
    
    return Individuo(hijo1_genes), Individuo(hijo2_genes)
end

function mutacion_gaussiana(individuo::Individuo, prob_mutacion=0.1, sigma=0.1)
    """Mutación gaussiana"""
    individuo_mutado = deepcopy(individuo)
    
    for i in 1:length(individuo_mutado.genes)
        if rand() < prob_mutacion
            individuo_mutado.genes[i] += randn() * sigma
        end
    end
    
    return individuo_mutado
end

function mutacion_uniforme(individuo::Individuo, prob_mutacion=0.1, rango=(-1.0, 1.0))
    """Mutación uniforme"""
    individuo_mutado = deepcopy(individuo)
    
    for i in 1:length(individuo_mutado.genes)
        if rand() < prob_mutacion
            individuo_mutado.genes[i] = rand() * (rango[2] - rango[1]) + rango[1]
        end
    end
    
    return individuo_mutado
end

# Algoritmo principal
function evaluar_poblacion!(poblacion::Poblacion, funcion_fitness)
    """Evalúa el fitness de toda la población"""
    for individuo in poblacion.individuos
        individuo.fitness = funcion_fitness(individuo.genes)
    end
    
    # Actualizar mejor individuo
    mejor_idx = argmax([ind.fitness for ind in poblacion.individuos])
    if poblacion.individuos[mejor_idx].fitness > poblacion.mejor_fitness
        poblacion.mejor_fitness = poblacion.individuos[mejor_idx].fitness
        poblacion.mejor_individuo = deepcopy(poblacion.individuos[mejor_idx])
    end
end

function algoritmo_genetico(
    funcion_fitness,
    tamaño_poblacion=50,
    longitud_cromosoma=10,
    max_generaciones=100,
    prob_crossover=0.8,
    prob_mutacion=0.1,
    tipo_seleccion="torneo",
    tipo_crossover="aritmetico",
    tipo_mutacion="gaussiana",
    elitismo=true,
    verbose=true
)
    """Algoritmo genético principal"""
    
    # Inicializar población
    poblacion = Poblacion(tamaño_poblacion, longitud_cromosoma)
    evaluar_poblacion!(poblacion, funcion_fitness)
    
    historial_fitness = Float64[]
    historial_promedio = Float64[]
    
    if verbose
        println("🧬 ALGORITMO GENÉTICO INICIADO")
        println("=" ^ 50)
        println("Tamaño población: $tamaño_poblacion")
        println("Longitud cromosoma: $longitud_cromosoma")
        println("Máx. generaciones: $max_generaciones")
        println("Prob. crossover: $prob_crossover")
        println("Prob. mutación: $prob_mutacion")
        println("Tipo selección: $tipo_seleccion")
        println("Tipo crossover: $tipo_crossover")
        println("Tipo mutación: $tipo_mutacion")
        println("Elitismo: $elitismo")
        println("-" ^ 50)
    end
    
    for gen in 1:max_generaciones
        # Crear nueva generación
        nueva_poblacion = Individuo[]
        
        # Elitismo: mantener los mejores
        if elitismo
            # Ordenar por fitness descendente
            individuos_ordenados = sort(poblacion.individuos, by=x->x.fitness, rev=true)
            num_elite = max(1, tamaño_poblacion ÷ 10)  # 10% elite
            append!(nueva_poblacion, individuos_ordenados[1:num_elite])
        end
        
        # Generar resto de la población
        while length(nueva_poblacion) < tamaño_poblacion
            # Selección
            if tipo_seleccion == "torneo"
                padre1 = seleccion_torneo(poblacion)
                padre2 = seleccion_torneo(poblacion)
            else
                padre1 = seleccion_ruleta(poblacion)
                padre2 = seleccion_ruleta(poblacion)
            end
            
            # Crossover
            if tipo_crossover == "uniforme"
                hijo1, hijo2 = crossover_uniforme(padre1, padre2, prob_crossover)
            else
                hijo1, hijo2 = crossover_aritmetico(padre1, padre2, prob_crossover)
            end
            
            # Mutación
            if tipo_mutacion == "gaussiana"
                hijo1 = mutacion_gaussiana(hijo1, prob_mutacion)
                hijo2 = mutacion_gaussiana(hijo2, prob_mutacion)
            else
                hijo1 = mutacion_uniforme(hijo1, prob_mutacion)
                hijo2 = mutacion_uniforme(hijo2, prob_mutacion)
            end
            
            push!(nueva_poblacion, hijo1)
            if length(nueva_poblacion) < tamaño_poblacion
                push!(nueva_poblacion, hijo2)
            end
        end
        
        # Actualizar población
        poblacion.individuos = nueva_poblacion[1:tamaño_poblacion]
        poblacion.generacion = gen
        evaluar_poblacion!(poblacion, funcion_fitness)
        
        # Estadísticas
        fitness_actual = [ind.fitness for ind in poblacion.individuos]
        mejor_gen = maximum(fitness_actual)
        promedio_gen = sum(fitness_actual) / length(fitness_actual)
        
        push!(historial_fitness, mejor_gen)
        push!(historial_promedio, promedio_gen)
        
        if verbose && gen % 10 == 0
            println("Gen $gen: Mejor = $(round(mejor_gen, digits=4)), " *
                   "Promedio = $(round(promedio_gen, digits=4))")
        end
    end
    
    if verbose
        println("\n🏆 EVOLUCIÓN COMPLETADA")
        println("Mejor fitness: $(poblacion.mejor_fitness)")
        println("Mejor solución: $(poblacion.mejor_individuo.genes)")
        println("Generación final: $(poblacion.generacion)")
    end
    
    return (
        mejor_individuo = poblacion.mejor_individuo,
        mejor_fitness = poblacion.mejor_fitness,
        poblacion_final = poblacion,
        historial_fitness = historial_fitness,
        historial_promedio = historial_promedio
    )
end

# Funciones de análisis y visualización
function analizar_convergencia(historial_fitness, historial_promedio)
    """Analiza la convergencia del algoritmo"""
    println("\n📊 ANÁLISIS DE CONVERGENCIA")
    println("=" ^ 30)
    
    # Estadísticas básicas
    mejora_total = historial_fitness[end] - historial_fitness[1]
    generaciones = length(historial_fitness)
    
    println("🎯 Mejora total: $(round(mejora_total, digits=4))")
    println("📈 Mejora promedio por generación: $(round(mejora_total / generaciones, digits=6))")
    
    # Encontrar generación de mayor mejora
    mejoras = [historial_fitness[i] - historial_fitness[i-1] for i in 2:length(historial_fitness)]
    mejor_mejora_gen = argmax(mejoras) + 1
    println("🚀 Mayor mejora en generación: $mejor_mejora_gen")
    
    # Convergencia (últimas 20 generaciones sin mejora significativa)
    if generaciones >= 20
        ultimas_20 = historial_fitness[end-19:end]
        variacion = maximum(ultimas_20) - minimum(ultimas_20)
        if variacion < 0.001
            println("⚠️  Posible convergencia prematura (variación < 0.001)")
        else
            println("✅ Evolución activa (variación = $(round(variacion, digits=6)))")
        end
    end
end

function comparar_configuraciones()
    """Compara diferentes configuraciones del algoritmo genético"""
    println("\n🔬 COMPARACIÓN DE CONFIGURACIONES")
    println("=" ^ 40)
    
    configuraciones = [
        ("Torneo + Aritmético + Gaussiana", "torneo", "aritmetico", "gaussiana"),
        ("Ruleta + Uniforme + Uniforme", "ruleta", "uniforme", "uniforme"),
        ("Torneo + Uniforme + Gaussiana", "torneo", "uniforme", "gaussiana")
    ]
    
    resultados = []
    
    for (nombre, sel, cross, mut) in configuraciones
        println("\n🧪 Probando: $nombre")
        resultado = algoritmo_genetico(
            funcion_esfera,
            tamaño_poblacion=30,
            longitud_cromosoma=5,
            max_generaciones=50,
            tipo_seleccion=sel,
            tipo_crossover=cross,
            tipo_mutacion=mut,
            verbose=false
        )
        
        push!(resultados, (nombre, resultado.mejor_fitness))
        println("Mejor fitness: $(round(resultado.mejor_fitness, digits=4))")
    end
    
    # Mostrar ranking
    sort!(resultados, by=x->x[2], rev=true)
    println("\n🏆 RANKING DE CONFIGURACIONES:")
    for (i, (nombre, fitness)) in enumerate(resultados)
        println("$i. $nombre: $(round(fitness, digits=4))")
    end
end

function ejemplo_problema_mochila()
    """Ejemplo del problema de la mochila usando AG"""
    println("\n🎒 PROBLEMA DE LA MOCHILA")
    println("=" ^ 30)
    
    # Definir artículos (peso, valor)
    articulos = [
        (10, 60), (20, 100), (30, 120),
        (15, 80), (25, 110), (35, 140),
        (12, 70), (18, 90), (22, 105)
    ]
    
    pesos = [art[1] for art in articulos]
    valores = [art[2] for art in articulos]
    capacidad = 80
    
    println("Artículos disponibles:")
    for (i, (peso, valor)) in enumerate(articulos)
        ratio = valor / peso
        println("  $i. Peso: $peso, Valor: $valor, Ratio: $(round(ratio, digits=2))")
    end
    println("Capacidad de la mochila: $capacidad")
    
    # Función fitness específica para este problema
    fitness_mochila(x) = problema_mochila(x, pesos, valores, capacidad)
    
    # Ejecutar algoritmo genético
    resultado = algoritmo_genetico(
        fitness_mochila,
        tamaño_poblacion=40,
        longitud_cromosoma=length(articulos),
        max_generaciones=100,
        prob_mutacion=0.2,
        verbose=false
    )
    
    # Interpretar resultado
    seleccion = resultado.mejor_individuo.genes .> 0.5
    peso_total = sum(pesos[seleccion])
    valor_total = sum(valores[seleccion])
    
    println("\n🏆 MEJOR SOLUCIÓN:")
    println("Artículos seleccionados:")
    for (i, sel) in enumerate(seleccion)
        if sel
            println("  ✅ Artículo $i: Peso $(pesos[i]), Valor $(valores[i])")
        end
    end
    println("Peso total: $peso_total / $capacidad")
    println("Valor total: $valor_total")
    println("Eficiencia: $(round(valor_total / peso_total, digits=2))")
end

# Demostración principal
function demo_algoritmo_genetico()
    """Demostración completa del algoritmo genético"""
    println("=== DEMO ALGORITMO GENÉTICO ===\n")
    
    # Ejemplo 1: Optimización de función esfera
    println("🎯 Ejemplo 1: Minimización de función esfera")
    resultado1 = algoritmo_genetico(
        funcion_esfera,
        tamaño_poblacion=30,
        longitud_cromosoma=5,
        max_generaciones=50,
        verbose=true
    )
    
    analizar_convergencia(resultado1.historial_fitness, resultado1.historial_promedio)
    
    # Ejemplo 2: Problema de la mochila
    ejemplo_problema_mochila()
    
    # Ejemplo 3: Comparación de configuraciones
    comparar_configuraciones()
end

# Ejecutar demostración
demo_algoritmo_genetico()

println("\n¡Algoritmo genético implementado! Modifica la función demo para experimentar.")
