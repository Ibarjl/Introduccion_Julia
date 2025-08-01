# Ejercicio 8: Condicionales en Julia
# Aprende a usar estructuras de control condicionales

# Condicional if básico
edad = 18

if edad >= 18
    println("Eres mayor de edad")
end

# if-else
puntuacion = 85

if puntuacion >= 90
    println("Excelente")
else
    println("Bien, pero puedes mejorar")
end

# if-elseif-else
temperatura = 25

if temperatura < 0
    println("Está congelando")
elseif temperatura < 15
    println("Hace frío")
elseif temperatura < 25
    println("Temperatura agradable")
else
    println("Hace calor")
end

# Operadores de comparación
a = 10
b = 5

println("a == b: $(a == b)")
println("a != b: $(a != b)")
println("a > b: $(a > b)")
println("a < b: $(a < b)")
println("a >= b: $(a >= b)")
println("a <= b: $(a <= b)")

# Operadores lógicos
tiene_licencia = true
mayor_edad = true
puede_conducir = tiene_licencia && mayor_edad
println("¿Puede conducir?: $puede_conducir")

llueve = false
soleado = true
buen_dia = !llueve || soleado
println("¿Es un buen día?: $buen_dia")

# Condicional ternario (operador ?)
numero = 7
resultado = numero % 2 == 0 ? "par" : "impar"
println("El número $numero es $resultado")

# Verificar tipo
valor = 42
if isa(valor, Int)
    println("$valor es un entero")
elseif isa(valor, Float64)
    println("$valor es un float")
else
    println("$valor es de otro tipo")
end

# Verificar pertenencia
dia = "lunes"
dias_laborales = ["lunes", "martes", "miércoles", "jueves", "viernes"]

if dia in dias_laborales
    println("$dia es un día laboral")
else
    println("$dia es fin de semana")
end

# Condicionales con funciones
function clasificar_numero(n)
    if n > 0
        return "positivo"
    elseif n < 0
        return "negativo"
    else
        return "cero"
    end
end

numero_test = -5
clasificacion = clasificar_numero(numero_test)
println("El número $numero_test es $clasificacion")

# Short-circuit evaluation
x = 10
y = 0

# Solo evalúa la segunda expresión si la primera es verdadera
y != 0 && println("División: $(x / y)")  # No se ejecuta
y == 0 || println("y no es cero")  # No se ejecuta

# Ejemplo con nothing y missing
valor_nulo = nothing
if valor_nulo === nothing
    println("El valor es nothing")
end

# Condicionales anidados
hora = 14
dia_semana = "sábado"

if dia_semana in ["sábado", "domingo"]
    if hora < 12
        println("Fin de semana por la mañana")
    else
        println("Fin de semana por la tarde")
    end
else
    if hora < 9
        println("Día laboral temprano")
    elseif hora < 17
        println("Horario de trabajo")
    else
        println("Después del trabajo")
    end
end

# Ejercicios para practicar:
# 1. Crea un programa que determine si un año es bisiesto
# 2. Clasifica notas en A, B, C, D, F según puntuación
# 3. Determina el mayor de tres números
