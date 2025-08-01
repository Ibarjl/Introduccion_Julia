# Ejercicio Intermedio 1: Calculadora Básica
# Una calculadora con interfaz de línea de comandos

function mostrar_menu()
    println("\n=== CALCULADORA BÁSICA ===")
    println("1. Suma")
    println("2. Resta") 
    println("3. Multiplicación")
    println("4. División")
    println("5. Potencia")
    println("6. Raíz cuadrada")
    println("7. Factorial")
    println("8. Historial")
    println("9. Limpiar historial")
    println("0. Salir")
    print("Selecciona una opción: ")
end

function obtener_numero(mensaje)
    while true
        print(mensaje)
        try
            input = readline()
            return parse(Float64, input)
        catch
            println("Error: Ingresa un número válido")
        end
    end
end

function obtener_dos_numeros()
    a = obtener_numero("Ingresa el primer número: ")
    b = obtener_numero("Ingresa el segundo número: ")
    return a, b
end

function suma(a, b)
    return a + b
end

function resta(a, b)
    return a - b
end

function multiplicacion(a, b)
    return a * b
end

function division(a, b)
    if b == 0
        error("División por cero no permitida")
    end
    return a / b
end

function potencia(a, b)
    return a ^ b
end

function raiz_cuadrada(a)
    if a < 0
        error("No se puede calcular la raíz cuadrada de un número negativo")
    end
    return sqrt(a)
end

function factorial_recursivo(n)
    if n < 0
        error("El factorial no está definido para números negativos")
    elseif n == 0 || n == 1
        return 1
    else
        return n * factorial_recursivo(n - 1)
    end
end

function mostrar_historial(historial)
    if isempty(historial)
        println("El historial está vacío")
    else
        println("\n=== HISTORIAL ===")
        for (i, operacion) in enumerate(historial)
            println("$i. $operacion")
        end
    end
end

function ejecutar_calculadora()
    historial = String[]
    
    println("¡Bienvenido a la Calculadora Básica!")
    
    while true
        mostrar_menu()
        
        try
            opcion = parse(Int, readline())
            
            if opcion == 0
                println("¡Gracias por usar la calculadora!")
                break
            elseif opcion == 1
                a, b = obtener_dos_numeros()
                resultado = suma(a, b)
                operacion = "$a + $b = $resultado"
                println("Resultado: $resultado")
                push!(historial, operacion)
                
            elseif opcion == 2
                a, b = obtener_dos_numeros()
                resultado = resta(a, b)
                operacion = "$a - $b = $resultado"
                println("Resultado: $resultado")
                push!(historial, operacion)
                
            elseif opcion == 3
                a, b = obtener_dos_numeros()
                resultado = multiplicacion(a, b)
                operacion = "$a × $b = $resultado"
                println("Resultado: $resultado")
                push!(historial, operacion)
                
            elseif opcion == 4
                a, b = obtener_dos_numeros()
                try
                    resultado = division(a, b)
                    operacion = "$a ÷ $b = $resultado"
                    println("Resultado: $resultado")
                    push!(historial, operacion)
                catch e
                    println("Error: $e")
                end
                
            elseif opcion == 5
                a, b = obtener_dos_numeros()
                resultado = potencia(a, b)
                operacion = "$a ^ $b = $resultado"
                println("Resultado: $resultado")
                push!(historial, operacion)
                
            elseif opcion == 6
                a = obtener_numero("Ingresa el número: ")
                try
                    resultado = raiz_cuadrada(a)
                    operacion = "√$a = $resultado"
                    println("Resultado: $resultado")
                    push!(historial, operacion)
                catch e
                    println("Error: $e")
                end
                
            elseif opcion == 7
                a = obtener_numero("Ingresa el número: ")
                try
                    n = Int(a)
                    resultado = factorial_recursivo(n)
                    operacion = "$n! = $resultado"
                    println("Resultado: $resultado")
                    push!(historial, operacion)
                catch e
                    println("Error: $e")
                end
                
            elseif opcion == 8
                mostrar_historial(historial)
                
            elseif opcion == 9
                empty!(historial)
                println("Historial limpiado")
                
            else
                println("Opción no válida")
            end
            
        catch
            println("Error: Ingresa una opción válida")
        end
        
        println("\nPresiona Enter para continuar...")
        readline()
    end
end

# Función para testing (sin interfaz)
function test_calculadora()
    println("=== TESTING CALCULADORA ===")
    
    # Test operaciones básicas
    println("Suma: $(suma(5, 3)) (esperado: 8)")
    println("Resta: $(resta(10, 4)) (esperado: 6)")
    println("Multiplicación: $(multiplicacion(6, 7)) (esperado: 42)")
    println("División: $(division(15, 3)) (esperado: 5)")
    println("Potencia: $(potencia(2, 3)) (esperado: 8)")
    println("Raíz cuadrada: $(raiz_cuadrada(16)) (esperado: 4)")
    println("Factorial: $(factorial_recursivo(5)) (esperado: 120)")
    
    # Test manejo de errores
    try
        division(5, 0)
    catch e
        println("Error de división capturado correctamente: $e")
    end
    
    try
        raiz_cuadrada(-4)
    catch e
        println("Error de raíz cuadrada capturado correctamente: $e")
    end
end

# Ejecutar tests
test_calculadora()

# Descomenta la siguiente línea para ejecutar la calculadora interactiva
# ejecutar_calculadora()

println("\n¡Calculadora básica implementada! Descomenta 'ejecutar_calculadora()' para usarla.")
