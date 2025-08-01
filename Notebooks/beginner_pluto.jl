### A Pluto.jl notebook ###
# v0.19.36

using Markdown
using InteractiveUtils

# ╔═╡ 7c8b2a1e-6f4b-11ee-1f7a-8b3c5d2e1f9a
md"""
# Guía Rápida para Principiantes en Julia

¡Bienvenido a Julia! Esta guía te llevará desde cero hasta poder escribir tus primeros programas en Julia en menos de 30 minutos.

## ¿Por qué Julia?

Julia fue diseñado para resolver el "problema de dos lenguajes":
- **Prototipado**: Usa un lenguaje fácil (Python, R, MATLAB)
- **Producción**: Reescribe en un lenguaje rápido (C, C++, Fortran)

Julia elimina esta necesidad: **fácil de escribir Y rápido de ejecutar**.
"""

# ╔═╡ 1a2b3c4d-6f4b-11ee-2f8a-9c4d6e3f2a1b
md"""
## 1. Primeros Pasos - ¡Hola Mundo!

Empecemos con lo básico:
"""

# ╔═╡ 2b3c4d5e-6f4b-11ee-3f9a-ad5e7f4a3b2c
begin
	# Tu primer programa en Julia
	println("¡Hola, mundo!")
	println("¡Bienvenido a Julia! 🚀")
end

# ╔═╡ 3c4d5e6f-6f4b-11ee-4faa-be6f8a5b4c3d
md"""
## 2. Variables - Almacenar Información

En Julia, crear variables es súper fácil:
"""

# ╔═╡ 4d5e6f7a-6f4b-11ee-5fab-cf7a9b6c5d4e
begin
	# Números
	mi_numero = 42
	mi_decimal = 3.14
	
	# Texto
	mi_nombre = "Ana"
	mi_apellido = "García"
	
	# Verdadero/Falso
	es_estudiante = true
	
	# Ver qué contienen
	println("Número: $mi_numero")
	println("Decimal: $mi_decimal")
	println("Nombre completo: $mi_nombre $mi_apellido")
	println("¿Es estudiante? $es_estudiante")
end

# ╔═╡ 5e6f7a8b-6f4b-11ee-6abc-da8bac7d6e5f
md"""
## 3. Matemáticas - Julia es una Calculadora Súper Poderosa

Julia maneja matemáticas de forma natural:
"""

# ╔═╡ 6f7a8b9c-6f4b-11ee-7bcd-eb9cbd8e7f6a
begin
	# Operaciones básicas
	a = 10
	b = 3
	
	println("$a + $b = ", a + b)  # Suma
	println("$a - $b = ", a - b)  # Resta
	println("$a * $b = ", a * b)  # Multiplicación
	println("$a / $b = ", a / b)  # División
	println("$a ^ $b = ", a ^ b)  # Potencia
	
	# Funciones matemáticas
	println("√$a = ", √a)         # Raíz cuadrada
	println("sin(π/2) = ", sin(π/2))  # Seno de π/2
end

# ╔═╡ 7a8b9cad-6f4b-11ee-8cde-fcadce9f8a7b
md"""
## 4. Listas - Almacenar Múltiples Cosas

Los arrays (listas) son fundamentales en Julia:
"""

# ╔═╡ 8b9cadbe-6f4b-11ee-9def-adbecfaa9b8c
begin
	# Crear listas
	numeros = [1, 2, 3, 4, 5]
	nombres = ["Ana", "Luis", "Carmen", "Diego"]
	mezclado = [1, "hola", 3.14, true]
	
	println("Números: $numeros")
	println("Nombres: $nombres")
	println("Mezclado: $mezclado")
	
	# Acceder a elementos (¡empieza en 1, no en 0!)
	println("Primer número: $(numeros[1])")
	println("Segundo nombre: $(nombres[2])")
	println("Último número: $(numeros[end])")
end

# ╔═╡ 9cadbecf-6f4b-11ee-aefa-becfdbab9c8d
begin
	# Operaciones con listas
	numeros_copia = copy(numeros)  # Hacemos una copia para no modificar la original
	push!(numeros_copia, 6)  # Agregar al final
	println("Después de agregar 6: $numeros_copia")
	
	pop!(numeros_copia)      # Quitar el último
	println("Después de quitar el último: $numeros_copia")
	
	# Longitud de la lista
	println("La lista tiene $(length(numeros_copia)) elementos")
end

# ╔═╡ adbecfda-6f4b-11ee-bfab-cfdbecba9d8e
md"""
## 5. Tomar Decisiones - If/Else

Haz que tu programa tome decisiones:
"""

# ╔═╡ becfdaeb-6f4b-11ee-cabc-daecfdcb9e8f
begin
	# Ejemplo: Clasificar edad
	edad = 20
	
	if edad < 13
		categoria = "niño"
	elseif edad < 20
		categoria = "adolescente"
	elseif edad < 65
		categoria = "adulto"
	else
		categoria = "adulto mayor"
	end
	
	println("Una persona de $edad años es: $categoria")
end

# ╔═╡ cfdaebfc-6f4b-11ee-dbcd-ebfdedc9af9a
begin
	# Ejemplo práctico: Calculadora de notas
	calificacion = 85
	
	if calificacion >= 90
		letra = "A"
		mensaje = "¡Excelente!"
	elseif calificacion >= 80
		letra = "B"
		mensaje = "¡Muy bien!"
	elseif calificacion >= 70
		letra = "C"
		mensaje = "Bien"
	elseif calificacion >= 60
		letra = "D"
		mensaje = "Necesitas mejorar"
	else
		letra = "F"
		mensaje = "Reprobado"
	end
	
	println("Calificación: $calificacion")
	println("Letra: $letra")
	println("Comentario: $mensaje")
end

# ╔═╡ daebfcad-6f4b-11ee-ecde-fceaedab9fab
md"""
## 6. Repetir Acciones - Bucles

Haz que tu programa repita cosas automáticamente:
"""

# ╔═╡ ebfcadbe-6f4b-11ee-fdef-adfbecba9fac
begin
	# Bucle for - repetir un número específico de veces
	println("Contando del 1 al 5:")
	for i in 1:5
		println("Número: $i")
	end
end

# ╔═╡ fcadbecf-6f4b-11ee-eafa-becfdbca9abd
begin
	# Bucle con listas
	frutas = ["manzana", "banana", "naranja", "uva"]
	
	println("Mis frutas favoritas:")
	for fruta in frutas
		println("- Me gusta la $fruta")
	end
end

# ╔═╡ adbecfda-6f4b-11ee-fbab-cfdbecba9ace
begin
	# Bucle while - repetir mientras algo sea verdad
	contador = 1
	suma = 0
	
	println("Sumando números del 1 al 10:")
	while contador <= 10
		suma = suma + contador
		println("$contador: suma actual = $suma")
		contador = contador + 1
	end
	
	println("Total final: $suma")
end

# ╔═╡ becfdaeb-6f4b-11ee-acbc-daecfdcb9adf
md"""
## 7. Funciones - Reutilizar Código

Las funciones te permiten organizar y reutilizar tu código:
"""

# ╔═╡ cfdaebfc-6f4b-11ee-bdcd-ebfdedc9acea
function saludar(nombre)
	return "¡Hola, $nombre! ¿Cómo estás?"
end

# ╔═╡ daebfcad-6f4b-11ee-cede-fceaedab9dfb
begin
	# Usar la función
	mensaje1 = saludar("María")
	mensaje2 = saludar("Carlos")
	
	println(mensaje1)
	println(mensaje2)
end

# ╔═╡ ebfcadbe-6f4b-11ee-dfef-adfbecba9eac
function calcular_area_rectangulo(ancho, alto)
	area = ancho * alto
	return area
end

# ╔═╡ fcadbecf-6f4b-11ee-eafa-becfdbca9fbd
function es_par(numero)
	return numero % 2 == 0
end

# ╔═╡ adbecfda-6f4b-11ee-fbab-cfdbecba9ace
begin
	# Usar las funciones
	mi_area = calcular_area_rectangulo(5, 3)
	println("El área del rectángulo es: $mi_area")
	
	numero_test = 8
	if es_par(numero_test)
		println("$numero_test es par")
	else
		println("$numero_test es impar")
	end
end

# ╔═╡ becfdaeb-6f4b-11ee-acbc-daecfdcb9adf
md"""
## 8. Proyecto Práctico - Calculadora Personal

¡Vamos a crear algo útil combinando todo lo que hemos aprendido!
"""

# ╔═╡ cfdaebfc-6f4b-11ee-bdcd-ebfdedc9acea
function calculadora(operacion, a, b)
	if operacion == "suma" || operacion == "+"
		return a + b
	elseif operacion == "resta" || operacion == "-"
		return a - b
	elseif operacion == "multiplicacion" || operacion == "*"
		return a * b
	elseif operacion == "division" || operacion == "/"
		if b == 0
			return "Error: No se puede dividir por cero"
		else
			return a / b
		end
	else
		return "Operación no reconocida"
	end
end

# ╔═╡ daebfcad-6f4b-11ee-cede-fceaedab9dfb
begin
	# Probar la calculadora
	println("=== MI CALCULADORA ===")
	println("10 + 5 = ", calculadora("+", 10, 5))
	println("10 - 5 = ", calculadora("-", 10, 5))
	println("10 * 5 = ", calculadora("*", 10, 5))
	println("10 / 5 = ", calculadora("/", 10, 5))
	println("10 / 0 = ", calculadora("/", 10, 0))
end

# ╔═╡ ebfcadbe-6f4b-11ee-dfef-adfbecba9eac
function analizar_numeros(numeros)
	println("\n=== ANÁLISIS DE NÚMEROS ===")
	println("Lista: $numeros")
	println("Cantidad de números: $(length(numeros))")
	
	# Estadísticas básicas
	suma_total = sum(numeros)
	promedio = suma_total / length(numeros)
	numero_mayor = maximum(numeros)
	numero_menor = minimum(numeros)
	
	println("Suma total: $suma_total")
	println("Promedio: $(round(promedio, digits=2))")
	println("Número mayor: $numero_mayor")
	println("Número menor: $numero_menor")
	
	# Contar pares e impares
	pares = 0
	impares = 0
	
	for num in numeros
		if num % 2 == 0
			pares = pares + 1
		else
			impares = impares + 1
		end
	end
	
	println("Números pares: $pares")
	println("Números impares: $impares")
end

# ╔═╡ fcadbecf-6f4b-11ee-eafa-becfdbca9fbd
begin
	# Probar el analizador
	mi_lista = [1, 15, 3, 22, 8, 7, 12, 9, 4, 18]
	analizar_numeros(mi_lista)
end

# ╔═╡ 1a2b3c4d-6f4c-11ee-2f8a-9c4d6e3f2a1b
md"""
## 9. Generador de Tablas de Multiplicar

Un proyecto divertido para practicar bucles anidados:
"""

# ╔═╡ 2b3c4d5e-6f4c-11ee-3f9a-ad5e7f4a3b2c
function tabla_multiplicar(numero, hasta=10)
	println("\n=== TABLA DEL $numero ===")
	
	for i in 1:hasta
		resultado = numero * i
		println("$numero x $i = $resultado")
	end
end

# ╔═╡ 3c4d5e6f-6f4c-11ee-4faa-be6f8a5b4c3d
begin
	# Generar tabla del 7
	tabla_multiplicar(7)
	
	# Generar tabla del 3 hasta el 5
	tabla_multiplicar(3, 5)
end

# ╔═╡ 4d5e6f7a-6f4c-11ee-5fab-cf7a9b6c5d4e
function tablas_multiples(desde, hasta)
	println("\n=== TABLAS DEL $desde AL $hasta ===")
	
	for tabla in desde:hasta
		println("\nTabla del $tabla:")
		for i in 1:5  # Solo hasta 5 para no saturar
			resultado = tabla * i
			println("  $tabla x $i = $resultado")
		end
	end
end

# ╔═╡ 5e6f7a8b-6f4c-11ee-6abc-da8bac7d6e5f
begin
	# Generar tablas del 2 al 4
	tablas_multiples(2, 4)
end

# ╔═╡ 6f7a8b9c-6f4c-11ee-7bcd-eb9cbd8e7f6a
md"""
## 10. Juego Simple - Adivina el Número

¡Vamos a crear un juego!
"""

# ╔═╡ 7a8b9cad-6f4c-11ee-8cde-fcadce9f8a7b
function simular_juego_adivinanza()
	# Número secreto (entre 1 y 100)
	numero_secreto = 42  # En un juego real sería rand(1:100)
	intentos = 0
	max_intentos = 7
	
	println("=== JUEGO: ADIVINA EL NÚMERO ===")
	println("He pensado un número entre 1 y 100")
	println("Tienes $max_intentos intentos para adivinarlo")
	
	# Simulamos algunos intentos
	adivinanzas = [25, 50, 35, 40, 44, 42]  # En un juego real sería input del usuario
	
	for adivinanza in adivinanzas
		intentos = intentos + 1
		
		println("\nIntento $intentos: ¿Es $adivinanza?")
		
		if adivinanza == numero_secreto
			println("🎉 ¡CORRECTO! ¡Adivinaste en $intentos intentos!")
			return
		elseif adivinanza < numero_secreto
			println("📈 Muy bajo. Intenta con un número más grande.")
		else
			println("📉 Muy alto. Intenta con un número más pequeño.")
		end
		
		if intentos >= max_intentos
			println("\n😞 Se acabaron los intentos. El número era $numero_secreto")
			return
		end
	end
end

# ╔═╡ 8b9cadbe-6f4c-11ee-9def-adbecfaa9b8c
begin
	# Jugar
	simular_juego_adivinanza()
end

# ╔═╡ 9cadbecf-6f4c-11ee-aefa-becfdbab9c8d
md"""
## 11. Ejercicios para Practicar

¡Ahora es tu turno! Intenta resolver estos ejercicios:

### Ejercicio 1: Conversor de temperatura
Crea una función que convierta Celsius a Fahrenheit
Fórmula: F = C * 9/5 + 32
"""

# ╔═╡ adbecfda-6f4c-11ee-bfab-cfdbecba9d8e
function celsius_a_fahrenheit(celsius)
	# Tu código aquí
	# return ...
	return "¡Completa esta función!"
end

# ╔═╡ becfdaeb-6f4c-11ee-cabc-daecfdcb9e8f
md"""
### Ejercicio 2: Contador de vocales
Crea una función que cuente cuántas vocales hay en una palabra
"""

# ╔═╡ cfdaebfc-6f4c-11ee-dbcd-ebfdedc9af9a
function contar_vocales(palabra)
	# Pista: usa un bucle for y la función lowercase()
	# Las vocales son: a, e, i, o, u
	
	# Tu código aquí
	return "¡Completa esta función!"
end

# ╔═╡ daebfcad-6f4c-11ee-ecde-fceaedab9fab
md"""
### Ejercicio 3: Calculadora de promedio de notas
Crea una función que reciba una lista de notas y devuelva:
- El promedio
- La nota más alta
- La nota más baja
- Cuántas notas están por encima del promedio
"""

# ╔═╡ ebfcadbe-6f4c-11ee-fdef-adfbecba9fac
function analizar_notas_ejercicio(notas)
	# Tu código aquí
	return "¡Completa esta función!"
end

# ╔═╡ fcadbecf-6f4c-11ee-eafa-becfdbca9abd
md"""
## 12. Soluciones de los Ejercicios

Aquí están las soluciones. ¡Intenta resolverlos primero antes de mirar!
"""

# ╔═╡ adbecfda-6f4c-11ee-fbab-cfdbecba9ace
function celsius_a_fahrenheit_solucion(celsius)
	fahrenheit = celsius * 9/5 + 32
	return fahrenheit
end

# ╔═╡ becfdaeb-6f4c-11ee-acbc-daecfdcb9adf
begin
	# Pruebas
	println("0°C = ", celsius_a_fahrenheit_solucion(0), "°F")
	println("25°C = ", celsius_a_fahrenheit_solucion(25), "°F")
	println("100°C = ", celsius_a_fahrenheit_solucion(100), "°F")
end

# ╔═╡ cfdaebfc-6f4c-11ee-bdcd-ebfdedc9acea
function contar_vocales_solucion(palabra)
	vocales = "aeiou"
	contador = 0
	
	for letra in lowercase(palabra)
		if letra in vocales
			contador = contador + 1
		end
	end
	
	return contador
end

# ╔═╡ daebfcad-6f4c-11ee-cede-fceaedab9dfb
begin
	# Pruebas
	println("Vocales en 'Julia': ", contar_vocales_solucion("Julia"))
	println("Vocales en 'programacion': ", contar_vocales_solucion("programacion"))
	println("Vocales en 'Hola mundo': ", contar_vocales_solucion("Hola mundo"))
end

# ╔═╡ ebfcadbe-6f4c-11ee-dfef-adfbecba9eac
function analizar_notas_solucion(notas)
	# Calcular estadísticas
	promedio = sum(notas) / length(notas)
	nota_alta = maximum(notas)
	nota_baja = minimum(notas)
	
	# Contar notas por encima del promedio
	por_encima = 0
	for nota in notas
		if nota > promedio
			por_encima = por_encima + 1
		end
	end
	
	# Mostrar resultados
	println("\n=== ANÁLISIS DE NOTAS ===")
	println("Notas: $notas")
	println("Promedio: $(round(promedio, digits=2))")
	println("Nota más alta: $nota_alta")
	println("Nota más baja: $nota_baja")
	println("Notas por encima del promedio: $por_encima")
end

# ╔═╡ fcadbecf-6f4c-11ee-eafa-becfdbca9fbd
begin
	# Prueba
	mis_notas = [85, 92, 78, 96, 87, 91, 83]
	analizar_notas_solucion(mis_notas)
end

# ╔═╡ 1a2b3c4d-6f4d-11ee-2f8a-9c4d6e3f2a1b
md"""
## 🎉 ¡Felicidades!

Has completado tu primera introducción a Julia con Pluto.jl. Ahora sabes:

✅ **Variables**: Almacenar información  
✅ **Operaciones**: Matemáticas y lógica  
✅ **Arrays**: Listas de datos  
✅ **Condicionales**: Tomar decisiones  
✅ **Bucles**: Repetir acciones  
✅ **Funciones**: Organizar código  
✅ **Proyectos**: Combinar todo  

## ¿Qué sigue?

1. **Práctica**: Resuelve más problemas
2. **Explora**: Aprende sobre paquetes de Julia
3. **Construye**: Crea proyectos más grandes
4. **Conecta**: Únete a la comunidad de Julia

### Recursos útiles:
- [Julia Documentation](https://docs.julialang.org/)
- [Julia Academy](https://juliaacademy.com/)
- [Julia Discourse](https://discourse.julialang.org/)
- [Julia Packages](https://juliapackages.com/)
- [Pluto.jl Documentation](https://plutojl.org/)

¡Sigue programando y divirtiéndote con Julia! 🚀

## Ventajas de usar Pluto.jl:

🔄 **Reactividad**: Los cambios se propagan automáticamente  
🎯 **Orden automático**: No importa el orden de las celdas  
📦 **Gestión de paquetes**: Built-in package manager  
🌐 **Exportación HTML**: Comparte tus notebooks como páginas web  
🔒 **Una variable por celda**: Evita errores de scope  
✨ **Interfaz moderna**: Diseño limpio y responsivo
"""

# ╔═╡ Cell order:
# ╠═7c8b2a1e-6f4b-11ee-1f7a-8b3c5d2e1f9a
# ╠═1a2b3c4d-6f4b-11ee-2f8a-9c4d6e3f2a1b
# ╠═2b3c4d5e-6f4b-11ee-3f9a-ad5e7f4a3b2c
# ╠═3c4d5e6f-6f4b-11ee-4faa-be6f8a5b4c3d
# ╠═4d5e6f7a-6f4b-11ee-5fab-cf7a9b6c5d4e
# ╠═5e6f7a8b-6f4b-11ee-6abc-da8bac7d6e5f
# ╠═6f7a8b9c-6f4b-11ee-7bcd-eb9cbd8e7f6a
# ╠═7a8b9cad-6f4b-11ee-8cde-fcadce9f8a7b
# ╠═8b9cadbe-6f4b-11ee-9def-adbecfaa9b8c
# ╠═9cadbecf-6f4b-11ee-aefa-becfdbab9c8d
# ╠═adbecfda-6f4b-11ee-bfab-cfdbecba9d8e
# ╠═becfdaeb-6f4b-11ee-cabc-daecfdcb9e8f
# ╠═cfdaebfc-6f4b-11ee-dbcd-ebfdedc9af9a
# ╠═daebfcad-6f4b-11ee-ecde-fceaedab9fab
# ╠═ebfcadbe-6f4b-11ee-fdef-adfbecba9fac
# ╠═fcadbecf-6f4b-11ee-eafa-becfdbca9abd
# ╠═adbecfda-6f4b-11ee-fbab-cfdbecba9ace
# ╠═becfdaeb-6f4b-11ee-acbc-daecfdcb9adf
# ╠═cfdaebfc-6f4b-11ee-bdcd-ebfdedc9acea
# ╠═daebfcad-6f4b-11ee-cede-fceaedab9dfb
# ╠═ebfcadbe-6f4b-11ee-dfef-adfbecba9eac
# ╠═fcadbecf-6f4b-11ee-eafa-becfdbca9fbd
# ╠═adbecfda-6f4b-11ee-fbab-cfdbecba9ace
# ╠═becfdaeb-6f4b-11ee-acbc-daecfdcb9adf
# ╠═cfdaebfc-6f4b-11ee-bdcd-ebfdedc9acea
# ╠═daebfcad-6f4b-11ee-cede-fceaedab9dfb
# ╠═ebfcadbe-6f4b-11ee-dfef-adfbecba9eac
# ╠═fcadbecf-6f4b-11ee-eafa-becfdbca9fbd
# ╠═1a2b3c4d-6f4c-11ee-2f8a-9c4d6e3f2a1b
# ╠═2b3c4d5e-6f4c-11ee-3f9a-ad5e7f4a3b2c
# ╠═3c4d5e6f-6f4c-11ee-4faa-be6f8a5b4c3d
# ╠═4d5e6f7a-6f4c-11ee-5fab-cf7a9b6c5d4e
# ╠═5e6f7a8b-6f4c-11ee-6abc-da8bac7d6e5f
# ╠═6f7a8b9c-6f4c-11ee-7bcd-eb9cbd8e7f6a
# ╠═7a8b9cad-6f4c-11ee-8cde-fcadce9f8a7b
# ╠═8b9cadbe-6f4c-11ee-9def-adbecfaa9b8c
# ╠═9cadbecf-6f4c-11ee-aefa-becfdbab9c8d
# ╠═adbecfda-6f4c-11ee-bfab-cfdbecba9d8e
# ╠═becfdaeb-6f4c-11ee-cabc-daecfdcb9e8f
# ╠═cfdaebfc-6f4c-11ee-dbcd-ebfdedc9af9a
# ╠═daebfcad-6f4c-11ee-ecde-fceaedab9fab
# ╠═ebfcadbe-6f4c-11ee-fdef-adfbecba9fac
# ╠═fcadbecf-6f4c-11ee-eafa-becfdbca9abd
# ╠═adbecfda-6f4c-11ee-fbab-cfdbecba9ace
# ╠═becfdaeb-6f4c-11ee-acbc-daecfdcb9adf
# ╠═cfdaebfc-6f4c-11ee-bdcd-ebfdedc9acea
# ╠═daebfcad-6f4c-11ee-cede-fceaedab9dfb
# ╠═ebfcadbe-6f4c-11ee-dfef-adfbecba9eac
# ╠═fcadbecf-6f4c-11ee-eafa-becfdbca9fbd
# ╠═1a2b3c4d-6f4d-11ee-2f8a-9c4d6e3f2a1b
