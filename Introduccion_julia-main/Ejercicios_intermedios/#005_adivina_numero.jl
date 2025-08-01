# Ejercicio Intermedio 5: Juego de Adivina el Número
# Un juego interactivo donde el usuario debe adivinar un número secreto

using Random

# Configuración del juego
const NIVELES_DIFICULTAD = Dict(
    1 => (1, 10, 5),      # (min, max, intentos)
    2 => (1, 50, 7),
    3 => (1, 100, 10),
    4 => (1, 500, 12),
    5 => (1, 1000, 15)
)

const NOMBRES_DIFICULTAD = Dict(
    1 => "Muy Fácil",
    2 => "Fácil", 
    3 => "Normal",
    4 => "Difícil",
    5 => "Muy Difícil"
)

mutable struct EstadisticasJuego
    partidas_jugadas::Int
    partidas_ganadas::Int
    total_intentos::Int
    mejor_racha::Int
    racha_actual::Int
    tiempo_total::Float64
    
    EstadisticasJuego() = new(0, 0, 0, 0, 0, 0.0)
end

function mostrar_menu_dificultad()
    """Muestra el menú de selección de dificultad"""
    println("\n🎯 SELECCIONA LA DIFICULTAD:")
    println("-" ^ 30)
    for (nivel, (min_val, max_val, intentos)) in NIVELES_DIFICULTAD
        nombre = NOMBRES_DIFICULTAD[nivel]
        println("$nivel. $nombre ($min_val-$max_val, $intentos intentos)")
    end
    print("Elige dificultad (1-5): ")
end

function obtener_dificultad()
    """Obtiene la dificultad seleccionada por el usuario"""
    while true
        mostrar_menu_dificultad()
        try
            dificultad = parse(Int, readline())
            if dificultad in keys(NIVELES_DIFICULTAD)
                return dificultad
            else
                println("❌ Dificultad no válida. Elige entre 1-5.")
            end
        catch
            println("❌ Entrada no válida. Ingresa un número.")
        end
    end
end

function obtener_numero_usuario(min_val, max_val)
    """Obtiene y valida el número ingresado por el usuario"""
    while true
        print("Tu número ($min_val-$max_val): ")
        try
            numero = parse(Int, readline())
            if numero < min_val || numero > max_val
                println("❌ El número debe estar entre $min_val y $max_val")
                continue
            end
            return numero
        catch
            println("❌ Ingresa un número válido")
        end
    end
end

function dar_pista(numero_usuario, numero_secreto, min_val, max_val)
    """Proporciona pistas basadas en la diferencia"""
    diferencia = abs(numero_usuario - numero_secreto)
    rango = max_val - min_val
    
    if diferencia == 0
        return "🎉 ¡CORRECTO!"
    elseif diferencia <= rango * 0.05  # Muy cerca (5% del rango)
        return numero_usuario < numero_secreto ? "🔥 ¡Muy cerca! Un poco más alto" : "🔥 ¡Muy cerca! Un poco más bajo"
    elseif diferencia <= rango * 0.15  # Cerca (15% del rango)
        return numero_usuario < numero_secreto ? "🌡️ Cerca, pero más alto" : "🌡️ Cerca, pero más bajo"
    elseif diferencia <= rango * 0.35  # Tibio (35% del rango)
        return numero_usuario < numero_secreto ? "📈 Más alto" : "📉 Más bajo"
    else  # Frío
        return numero_usuario < numero_secreto ? "❄️ Muy bajo" : "❄️ Muy alto"
    end
end

function jugar_partida(dificultad, stats)
    """Ejecuta una partida completa del juego"""
    min_val, max_val, max_intentos = NIVELES_DIFICULTAD[dificultad]
    nombre_dif = NOMBRES_DIFICULTAD[dificultad]
    numero_secreto = rand(min_val:max_val)
    
    println("\n🎮 NUEVA PARTIDA - Dificultad: $nombre_dif")
    println("🎯 Adivina el número entre $min_val y $max_val")
    println("💡 Tienes $max_intentos intentos")
    println("🚀 ¡Comencemos!")
    
    tiempo_inicio = time()
    intentos_usados = 0
    historial_intentos = Int[]
    
    for intento in 1:max_intentos
        println("\n" * "="^40)
        println("🎲 Intento $intento de $max_intentos")
        
        if !isempty(historial_intentos)
            println("📝 Intentos anteriores: $(join(historial_intentos, ", "))")
        end
        
        numero_usuario = obtener_numero_usuario(min_val, max_val)
        push!(historial_intentos, numero_usuario)
        intentos_usados += 1
        
        pista = dar_pista(numero_usuario, numero_secreto, min_val, max_val)
        println(pista)
        
        if numero_usuario == numero_secreto
            tiempo_juego = time() - tiempo_inicio
            
            # Actualizar estadísticas
            stats.partidas_jugadas += 1
            stats.partidas_ganadas += 1
            stats.total_intentos += intentos_usados
            stats.racha_actual += 1
            stats.mejor_racha = max(stats.mejor_racha, stats.racha_actual)
            stats.tiempo_total += tiempo_juego
            
            println("\n🏆 ¡FELICITACIONES! ¡Ganaste!")
            println("⏱️  Tiempo: $(round(tiempo_juego, digits=1)) segundos")
            println("🎯 Intentos usados: $intentos_usados/$max_intentos")
            
            # Calcular puntuación
            puntuacion = calcular_puntuacion(intentos_usados, max_intentos, tiempo_juego, dificultad)
            println("⭐ Puntuación: $puntuacion puntos")
            
            return true
        end
        
        if intento < max_intentos
            intentos_restantes = max_intentos - intento
            println("🔄 Te quedan $intentos_restantes intentos")
            
            # Pista adicional si quedan pocos intentos
            if intentos_restantes <= 2
                dar_pista_avanzada(numero_secreto, min_val, max_val)
            end
        end
    end
    
    # El jugador perdió
    tiempo_juego = time() - tiempo_inicio
    stats.partidas_jugadas += 1
    stats.total_intentos += intentos_usados
    stats.racha_actual = 0
    stats.tiempo_total += tiempo_juego
    
    println("\n💥 ¡Se acabaron los intentos!")
    println("🎯 El número secreto era: $numero_secreto")
    println("📊 Tus intentos: $(join(historial_intentos, " → "))")
    return false
end

function dar_pista_avanzada(numero_secreto, min_val, max_val)
    """Da pistas avanzadas cuando quedan pocos intentos"""
    # Pista sobre par/impar
    if numero_secreto % 2 == 0
        println("💡 Pista extra: El número es PAR")
    else
        println("💡 Pista extra: El número es IMPAR")
    end
    
    # Pista sobre rango más específico
    rango = max_val - min_val
    if numero_secreto <= min_val + rango ÷ 3
        println("🎯 Pista de rango: Está en el tercio INFERIOR")
    elseif numero_secreto <= min_val + 2 * rango ÷ 3
        println("🎯 Pista de rango: Está en el tercio MEDIO")
    else
        println("🎯 Pista de rango: Está en el tercio SUPERIOR")
    end
end

function calcular_puntuacion(intentos_usados, max_intentos, tiempo, dificultad)
    """Calcula la puntuación basada en el rendimiento"""
    base_points = 1000 * dificultad
    
    # Bonificación por eficiencia en intentos
    eficiencia_intentos = (max_intentos - intentos_usados + 1) / max_intentos
    bonus_intentos = base_points * eficiencia_intentos * 0.5
    
    # Bonificación por velocidad (menos tiempo = más puntos)
    max_tiempo = 300  # 5 minutos máximo
    eficiencia_tiempo = max(0, (max_tiempo - tiempo) / max_tiempo)
    bonus_tiempo = base_points * eficiencia_tiempo * 0.3
    
    # Bonificación por dificultad
    bonus_dificultad = base_points * (dificultad - 1) * 0.2
    
    puntuacion_total = base_points + bonus_intentos + bonus_tiempo + bonus_dificultad
    return round(Int, puntuacion_total)
end

function mostrar_estadisticas(stats)
    """Muestra las estadísticas del jugador"""
    if stats.partidas_jugadas == 0
        println("📊 Aún no has jugado ninguna partida")
        return
    end
    
    porcentaje_victoria = (stats.partidas_ganadas / stats.partidas_jugadas) * 100
    promedio_intentos = stats.total_intentos / stats.partidas_jugadas
    tiempo_promedio = stats.tiempo_total / stats.partidas_jugadas
    
    println("\n📊 ESTADÍSTICAS DEL JUGADOR")
    println("=" ^ 40)
    println("🎮 Partidas jugadas: $(stats.partidas_jugadas)")
    println("🏆 Partidas ganadas: $(stats.partidas_ganadas)")
    println("📈 Porcentaje de victoria: $(round(porcentaje_victoria, digits=1))%")
    println("🎯 Promedio de intentos: $(round(promedio_intentos, digits=1))")
    println("⏱️  Tiempo promedio: $(round(tiempo_promedio, digits=1)) segundos")
    println("🔥 Mejor racha: $(stats.mejor_racha)")
    println("🚀 Racha actual: $(stats.racha_actual)")
end

function modo_practica()
    """Modo de práctica con configuración personalizada"""
    println("\n🏋️ MODO PRÁCTICA")
    
    print("Número mínimo: ")
    min_val = parse(Int, readline())
    print("Número máximo: ")
    max_val = parse(Int, readline())
    print("Número de intentos: ")
    max_intentos = parse(Int, readline())
    
    numero_secreto = rand(min_val:max_val)
    println("\n🎯 Adivina el número entre $min_val y $max_val")
    println("💡 Tienes $max_intentos intentos")
    
    for intento in 1:max_intentos
        println("\nIntento $intento de $max_intentos")
        numero_usuario = obtener_numero_usuario(min_val, max_val)
        
        if numero_usuario == numero_secreto
            println("🎉 ¡CORRECTO! ¡Ganaste en $intento intentos!")
            return
        else
            pista = dar_pista(numero_usuario, numero_secreto, min_val, max_val)
            println(pista)
        end
    end
    
    println("💥 ¡Se acabaron los intentos! El número era: $numero_secreto")
end

function juego_principal()
    """Función principal del juego"""
    println("🎲 BIENVENIDO AL JUEGO DE ADIVINA EL NÚMERO")
    println("=" ^ 50)
    
    stats = EstadisticasJuego()
    
    while true
        println("\n🎮 MENÚ PRINCIPAL")
        println("1. 🎯 Jugar partida")
        println("2. 🏋️ Modo práctica")
        println("3. 📊 Ver estadísticas")
        println("4. 🔄 Reiniciar estadísticas")
        println("5. 📋 Reglas del juego")
        println("0. 🚪 Salir")
        print("Selecciona una opción: ")
        
        try
            opcion = parse(Int, readline())
            
            if opcion == 0
                println("¡Gracias por jugar! 👋")
                break
            elseif opcion == 1
                dificultad = obtener_dificultad()
                jugar_partida(dificultad, stats)
            elseif opcion == 2
                modo_practica()
            elseif opcion == 3
                mostrar_estadisticas(stats)
            elseif opcion == 4
                print("¿Estás seguro? (s/n): ")
                if lowercase(strip(readline())) == "s"
                    stats = EstadisticasJuego()
                    println("📊 Estadísticas reiniciadas")
                end
            elseif opcion == 5
                mostrar_reglas()
            else
                println("❌ Opción no válida")
            end
        catch
            println("❌ Entrada no válida")
        end
        
        println("\nPresiona Enter para continuar...")
        readline()
    end
end

function mostrar_reglas()
    """Muestra las reglas del juego"""
    println("\n📋 REGLAS DEL JUEGO")
    println("=" ^ 30)
    println("🎯 Objetivo: Adivinar el número secreto")
    println("🎮 Selecciona una dificultad (1-5)")
    println("🔢 Ingresa números dentro del rango")
    println("💡 Recibe pistas después de cada intento")
    println("🏆 Gana adivinando antes de quedarte sin intentos")
    println("⭐ Gana más puntos con menos intentos y menos tiempo")
    println("\n🔥 TIPOS DE PISTAS:")
    println("  🎉 ¡CORRECTO! - ¡Ganaste!")
    println("  🔥 Muy cerca - Estás a punto de acertar")
    println("  🌡️ Cerca - Te estás acercando")
    println("  📈/📉 Más alto/bajo - Dirección correcta")
    println("  ❄️ Muy alto/bajo - Estás lejos")
end

# Función de demo automática
function demo_juego()
    """Demostración automática del juego"""
    println("=== DEMO DEL JUEGO ===")
    
    # Simular una partida
    numero_secreto = 42
    min_val, max_val = 1, 100
    
    println("Número secreto (demo): $numero_secreto")
    println("Simulando intentos...")
    
    intentos_demo = [50, 25, 35, 40, 42]
    
    for (i, intento) in enumerate(intentos_demo)
        pista = dar_pista(intento, numero_secreto, min_val, max_val)
        println("Intento $i: $intento → $pista")
        if intento == numero_secreto
            break
        end
    end
end

# Ejecutar demo
demo_juego()

# Descomenta la siguiente línea para jugar
# juego_principal()

println("\n¡Juego de adivina el número implementado! Descomenta 'juego_principal()' para jugar.")
