# Ejercicio Intermedio 6: Calculadora de Interés Compuesto
# Calcula interés compuesto con diferentes opciones y visualizaciones

using Printf

# Struct para almacenar parámetros de inversión
struct ParametrosInversion
    capital_inicial::Float64
    tasa_interes_anual::Float64  # Como decimal (ej: 0.05 para 5%)
    tiempo_años::Float64
    frecuencia_capitalizacion::Int  # Veces por año (1=anual, 12=mensual, etc.)
    aporte_adicional::Float64      # Aporte adicional periódico
    frecuencia_aporte::Int         # Veces por año del aporte
end

# Funciones de cálculo
function interes_compuesto_basico(capital, tasa, tiempo, frecuencia)
    """Calcula interés compuesto básico: A = P(1 + r/n)^(nt)"""
    return capital * (1 + tasa / frecuencia)^(frecuencia * tiempo)
end

function interes_compuesto_con_aportes(params::ParametrosInversion)
    """Calcula interés compuesto considerando aportes adicionales periódicos"""
    
    # Valor futuro del capital inicial
    valor_inicial = interes_compuesto_basico(
        params.capital_inicial,
        params.tasa_interes_anual,
        params.tiempo_años,
        params.frecuencia_capitalizacion
    )
    
    # Valor futuro de los aportes (si los hay)
    valor_aportes = 0.0
    if params.aporte_adicional > 0
        # Tasa por período de aporte
        tasa_por_aporte = params.tasa_interes_anual / params.frecuencia_aporte
        # Número total de aportes
        total_aportes = params.frecuencia_aporte * params.tiempo_años
        
        # Fórmula de anualidad ordinaria
        if tasa_por_aporte > 0
            valor_aportes = params.aporte_adicional * 
                           (((1 + tasa_por_aporte)^total_aportes - 1) / tasa_por_aporte)
        else
            valor_aportes = params.aporte_adicional * total_aportes
        end
    end
    
    return valor_inicial + valor_aportes
end

function calcular_tiempo_necesario(capital_inicial, capital_objetivo, tasa, frecuencia)
    """Calcula el tiempo necesario para alcanzar un capital objetivo"""
    if capital_objetivo <= capital_inicial
        return 0.0
    end
    
    # t = ln(A/P) / (n * ln(1 + r/n))
    return log(capital_objetivo / capital_inicial) / (frecuencia * log(1 + tasa / frecuencia))
end

function calcular_tasa_necesaria(capital_inicial, capital_objetivo, tiempo, frecuencia)
    """Calcula la tasa de interés necesaria para alcanzar un objetivo"""
    if tiempo <= 0 || capital_objetivo <= capital_inicial
        return 0.0
    end
    
    # Resolver para r: r = n * ((A/P)^(1/(n*t)) - 1)
    return frecuencia * ((capital_objetivo / capital_inicial)^(1 / (frecuencia * tiempo)) - 1)
end

function tabla_amortizacion(params::ParametrosInversion, mostrar_detalle=false)
    """Genera tabla de amortización año por año"""
    
    resultados = []
    capital_actual = params.capital_inicial
    
    for año in 1:Int(ceil(params.tiempo_años))
        # Calcular interés ganado en el año
        tiempo_año = min(1.0, params.tiempo_años - año + 1)
        
        # Capital al inicio del año
        capital_inicio = capital_actual
        
        # Interés ganado durante el año
        interes_año = capital_inicio * (
            (1 + params.tasa_interes_anual / params.frecuencia_capitalizacion)^
            (params.frecuencia_capitalizacion * tiempo_año) - 1
        )
        
        # Aportes durante el año
        aportes_año = if año <= params.tiempo_años
            params.aporte_adicional * min(params.frecuencia_aporte, 
                                        params.frecuencia_aporte * tiempo_año)
        else
            0.0
        end
        
        # Capital al final del año
        capital_final = capital_inicio + interes_año + aportes_año
        
        push!(resultados, (
            año = año,
            capital_inicio = capital_inicio,
            interes_ganado = interes_año,
            aportes = aportes_año,
            capital_final = capital_final
        ))
        
        capital_actual = capital_final
        
        if año >= params.tiempo_años
            break
        end
    end
    
    return resultados
end

function comparar_frecuencias(capital, tasa, tiempo)
    """Compara diferentes frecuencias de capitalización"""
    
    frecuencias = Dict(
        "Anual" => 1,
        "Semestral" => 2,
        "Trimestral" => 4,
        "Mensual" => 12,
        "Semanal" => 52,
        "Diario" => 365
    )
    
    println("\n📊 COMPARACIÓN DE FRECUENCIAS DE CAPITALIZACIÓN")
    println("Capital inicial: \$$(format_currency(capital))")
    println("Tasa anual: $(tasa*100)%")
    println("Tiempo: $tiempo años")
    println("-" ^ 60)
    
    resultados = []
    for (nombre, freq) in sort(collect(frecuencias), by=x->x[2])
        valor_final = interes_compuesto_basico(capital, tasa, tiempo, freq)
        interes_total = valor_final - capital
        push!(resultados, (nombre, freq, valor_final, interes_total))
        
        println("$(rpad(nombre, 12)): \$$(format_currency(valor_final)) " *
                "(interés: \$$(format_currency(interes_total)))")
    end
    
    # Mostrar diferencia con capitalización continua
    valor_continuo = capital * exp(tasa * tiempo)
    interes_continuo = valor_continuo - capital
    println("$(rpad("Continuo", 12)): \$$(format_currency(valor_continuo)) " *
            "(interés: \$$(format_currency(interes_continuo)))")
    
    return resultados
end

function analisis_sensibilidad(params::ParametrosInversion)
    """Analiza sensibilidad a cambios en parámetros"""
    
    println("\n🔍 ANÁLISIS DE SENSIBILIDAD")
    println("=" ^ 50)
    
    valor_base = interes_compuesto_con_aportes(params)
    
    # Variaciones de tasa de interés
    println("\n📈 Efecto de cambios en la tasa de interés:")
    variaciones_tasa = [-0.02, -0.01, -0.005, 0.005, 0.01, 0.02]
    
    for variacion in variaciones_tasa
        nueva_tasa = params.tasa_interes_anual + variacion
        if nueva_tasa > 0
            params_temp = ParametrosInversion(
                params.capital_inicial,
                nueva_tasa,
                params.tiempo_años,
                params.frecuencia_capitalizacion,
                params.aporte_adicional,
                params.frecuencia_aporte
            )
            nuevo_valor = interes_compuesto_con_aportes(params_temp)
            diferencia = nuevo_valor - valor_base
            porcentaje = (diferencia / valor_base) * 100
            
            signo = variacion >= 0 ? "+" : ""
            println("  Tasa $signo$(variacion*100)%: \$$(format_currency(nuevo_valor)) " *
                   "($signo$(round(porcentaje, digits=1))%)")
        end
    end
    
    # Variaciones de tiempo
    println("\n⏰ Efecto de cambios en el tiempo:")
    variaciones_tiempo = [-2, -1, 1, 2, 5]
    
    for variacion in variaciones_tiempo
        nuevo_tiempo = params.tiempo_años + variacion
        if nuevo_tiempo > 0
            params_temp = ParametrosInversion(
                params.capital_inicial,
                params.tasa_interes_anual,
                nuevo_tiempo,
                params.frecuencia_capitalizacion,
                params.aporte_adicional,
                params.frecuencia_aporte
            )
            nuevo_valor = interes_compuesto_con_aportes(params_temp)
            diferencia = nuevo_valor - valor_base
            porcentaje = (diferencia / valor_base) * 100
            
            signo = variacion >= 0 ? "+" : ""
            println("  Tiempo $signo$variacion años: \$$(format_currency(nuevo_valor)) " *
                   "($signo$(round(porcentaje, digits=1))%)")
        end
    end
end

function format_currency(valor)
    """Formatea números como moneda"""
    return @sprintf("%.2f", valor)
end

function mostrar_resumen_detallado(params::ParametrosInversion)
    """Muestra un resumen detallado de la inversión"""
    
    valor_final = interes_compuesto_con_aportes(params)
    total_invertido = params.capital_inicial + 
                     (params.aporte_adicional * params.frecuencia_aporte * params.tiempo_años)
    interes_total = valor_final - total_invertido
    
    println("\n💰 RESUMEN DETALLADO DE LA INVERSIÓN")
    println("=" ^ 50)
    println("📅 Período: $(params.tiempo_años) años")
    println("💵 Capital inicial: \$$(format_currency(params.capital_inicial))")
    println("📈 Tasa anual: $(params.tasa_interes_anual*100)%")
    println("🔄 Capitalización: $(obtener_nombre_frecuencia(params.frecuencia_capitalizacion))")
    
    if params.aporte_adicional > 0
        println("💰 Aporte periódico: \$$(format_currency(params.aporte_adicional))")
        println("📅 Frecuencia aportes: $(obtener_nombre_frecuencia(params.frecuencia_aporte))")
        println("💼 Total aportado: \$$(format_currency(total_invertido))")
    end
    
    println("\n🎯 RESULTADOS:")
    println("💎 Valor final: \$$(format_currency(valor_final))")
    println("💹 Interés ganado: \$$(format_currency(interes_total))")
    println("📊 Rendimiento: $(round((interes_total/total_invertido)*100, digits=2))%")
    
    # Análisis adicional
    tasa_efectiva = (valor_final / total_invertido)^(1/params.tiempo_años) - 1
    println("📈 Tasa efectiva anual: $(round(tasa_efectiva*100, digits=2))%")
    
    return valor_final
end

function obtener_nombre_frecuencia(frecuencia)
    """Convierte frecuencia numérica a nombre"""
    nombres = Dict(1 => "Anual", 2 => "Semestral", 4 => "Trimestral", 
                  12 => "Mensual", 26 => "Quincenal", 52 => "Semanal", 
                  365 => "Diario")
    return get(nombres, frecuencia, "$frecuencia veces/año")
end

function calculadora_interactiva()
    """Calculadora interactiva de interés compuesto"""
    
    println("🧮 CALCULADORA DE INTERÉS COMPUESTO")
    println("=" ^ 40)
    
    while true
        println("\nOpciones:")
        println("1. 💰 Cálculo básico")
        println("2. 📈 Con aportes adicionales")
        println("3. ⏰ Calcular tiempo necesario")
        println("4. 📊 Calcular tasa necesaria")
        println("5. 📋 Tabla de amortización")
        println("6. 🔍 Comparar frecuencias")
        println("7. 📊 Análisis de sensibilidad")
        println("0. 🚪 Salir")
        print("Selecciona una opción: ")
        
        try
            opcion = parse(Int, readline())
            
            if opcion == 0
                println("¡Hasta luego! 👋")
                break
                
            elseif opcion == 1
                println("\n💰 CÁLCULO BÁSICO")
                capital = obtener_numero_positivo("Capital inicial (\$): ")
                tasa = obtener_numero_positivo("Tasa anual (%): ") / 100
                tiempo = obtener_numero_positivo("Tiempo (años): ")
                frecuencia = obtener_frecuencia()
                
                params = ParametrosInversion(capital, tasa, tiempo, frecuencia, 0.0, 1)
                mostrar_resumen_detallado(params)
                
            elseif opcion == 2
                println("\n📈 CÁLCULO CON APORTES")
                capital = obtener_numero_positivo("Capital inicial (\$): ")
                tasa = obtener_numero_positivo("Tasa anual (%): ") / 100
                tiempo = obtener_numero_positivo("Tiempo (años): ")
                frecuencia = obtener_frecuencia()
                aporte = obtener_numero_positivo("Aporte adicional (\$): ")
                freq_aporte = obtener_frecuencia("Frecuencia de aportes")
                
                params = ParametrosInversion(capital, tasa, tiempo, frecuencia, aporte, freq_aporte)
                mostrar_resumen_detallado(params)
                
            elseif opcion == 3
                println("\n⏰ CALCULAR TIEMPO NECESARIO")
                capital_inicial = obtener_numero_positivo("Capital inicial (\$): ")
                objetivo = obtener_numero_positivo("Capital objetivo (\$): ")
                tasa = obtener_numero_positivo("Tasa anual (%): ") / 100
                frecuencia = obtener_frecuencia()
                
                tiempo = calcular_tiempo_necesario(capital_inicial, objetivo, tasa, frecuencia)
                println("⏱️ Tiempo necesario: $(round(tiempo, digits=2)) años")
                
            elseif opcion == 4
                println("\n📊 CALCULAR TASA NECESARIA")
                capital_inicial = obtener_numero_positivo("Capital inicial (\$): ")
                objetivo = obtener_numero_positivo("Capital objetivo (\$): ")
                tiempo = obtener_numero_positivo("Tiempo (años): ")
                frecuencia = obtener_frecuencia()
                
                tasa = calcular_tasa_necesaria(capital_inicial, objetivo, tiempo, frecuencia)
                println("📈 Tasa necesaria: $(round(tasa*100, digits=2))% anual")
                
            elseif opcion == 5
                println("\n📋 TABLA DE AMORTIZACIÓN")
                capital = obtener_numero_positivo("Capital inicial (\$): ")
                tasa = obtener_numero_positivo("Tasa anual (%): ") / 100
                tiempo = obtener_numero_positivo("Tiempo (años): ")
                
                params = ParametrosInversion(capital, tasa, tiempo, 1, 0.0, 1)
                tabla = tabla_amortizacion(params)
                
                println("\n📊 EVOLUCIÓN AÑO A AÑO:")
                println("Año | Capital Inicio | Interés    | Capital Final")
                println("-" ^ 50)
                for fila in tabla
                    println("$(rpad(fila.año, 3)) | " *
                           "\$$(rpad(format_currency(fila.capital_inicio), 13)) | " *
                           "\$$(rpad(format_currency(fila.interes_ganado), 9)) | " *
                           "\$$(format_currency(fila.capital_final))")
                end
                
            elseif opcion == 6
                println("\n🔍 COMPARAR FRECUENCIAS")
                capital = obtener_numero_positivo("Capital inicial (\$): ")
                tasa = obtener_numero_positivo("Tasa anual (%): ") / 100
                tiempo = obtener_numero_positivo("Tiempo (años): ")
                
                comparar_frecuencias(capital, tasa, tiempo)
                
            elseif opcion == 7
                println("\n📊 ANÁLISIS DE SENSIBILIDAD")
                capital = obtener_numero_positivo("Capital inicial (\$): ")
                tasa = obtener_numero_positivo("Tasa anual (%): ") / 100
                tiempo = obtener_numero_positivo("Tiempo (años): ")
                
                params = ParametrosInversion(capital, tasa, tiempo, 12, 0.0, 1)
                analisis_sensibilidad(params)
                
            else
                println("❌ Opción no válida")
            end
            
        catch e
            println("❌ Error: $e")
        end
        
        println("\nPresiona Enter para continuar...")
        readline()
    end
end

function obtener_numero_positivo(mensaje)
    """Obtiene un número positivo del usuario"""
    while true
        print(mensaje)
        try
            numero = parse(Float64, readline())
            if numero > 0
                return numero
            else
                println("❌ El número debe ser positivo")
            end
        catch
            println("❌ Ingresa un número válido")
        end
    end
end

function obtener_frecuencia(tipo="Frecuencia de capitalización")
    """Obtiene frecuencia de capitalización"""
    println("\n$tipo:")
    println("1. Anual (1)")
    println("2. Semestral (2)")
    println("3. Trimestral (4)")
    println("4. Mensual (12)")
    println("5. Semanal (52)")
    println("6. Diario (365)")
    print("Selecciona (1-6): ")
    
    opciones = [1, 2, 4, 12, 52, 365]
    
    while true
        try
            seleccion = parse(Int, readline())
            if 1 <= seleccion <= 6
                return opciones[seleccion]
            else
                println("❌ Selección no válida")
            end
        catch
            println("❌ Ingresa un número válido")
        end
    end
end

function ejemplo_demostrativo()
    """Ejecuta ejemplos demostrativos"""
    println("=== EJEMPLOS DEMOSTRATIVOS ===\n")
    
    # Ejemplo 1: Inversión básica
    println("📊 Ejemplo 1: Inversión básica")
    params1 = ParametrosInversion(10000.0, 0.07, 10.0, 12, 0.0, 1)
    valor1 = mostrar_resumen_detallado(params1)
    
    # Ejemplo 2: Con aportes mensuales
    println("\n📊 Ejemplo 2: Con aportes mensuales")
    params2 = ParametrosInversion(5000.0, 0.06, 15.0, 12, 200.0, 12)
    valor2 = mostrar_resumen_detallado(params2)
    
    # Comparación de frecuencias
    println("\n📊 Ejemplo 3: Comparación de frecuencias")
    comparar_frecuencias(10000.0, 0.05, 10.0)
end

# Ejecutar ejemplo demostrativo
ejemplo_demostrativo()

# Descomenta la siguiente línea para la calculadora interactiva
# calculadora_interactiva()

println("\n¡Calculadora de interés compuesto implementada! Descomenta 'calculadora_interactiva()' para usarla.")
