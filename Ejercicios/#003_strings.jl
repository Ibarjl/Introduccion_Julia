# Ejercicio 3: Strings (Cadenas) en Julia
# Aprende a manipular cadenas de texto

# Declaración de strings
saludo = "Hola"
nombre = "Julia"
mensaje = "Bienvenido al mundo de la programación"

# Concatenación de strings
mensaje_completo = saludo * " " * nombre
mensaje_interpolado = "$saludo $nombre"

println("Concatenación: ", mensaje_completo)
println("Interpolación: ", mensaje_interpolado)

# Propiedades de strings
longitud = length(mensaje)
println("Longitud del mensaje: $longitud")

# Acceso a caracteres (indexado desde 1)
primer_caracter = mensaje[1]
ultimo_caracter = mensaje[end]
println("Primer carácter: $primer_caracter")
println("Último carácter: $ultimo_caracter")

# Subcadenas
subcadena = mensaje[1:10]
println("Subcadena (1:10): $subcadena")

# Operaciones útiles con strings
mayusculas = uppercase(mensaje)
minusculas = lowercase(mensaje)
println("Mayúsculas: $mayusculas")
println("Minúsculas: $minusculas")

# Buscar en strings
contiene = occursin("mundo", mensaje)
println("¿Contiene 'mundo'?: $contiene")

# Dividir strings
palabras = split(mensaje, " ")
println("Palabras: $palabras")

# Unir strings
texto_unido = join(["Hola", "mundo", "Julia"], "-")
println("Texto unido: $texto_unido")

# Strings multilínea
poema = """
En Julia programamos,
con elegancia y precisión,
¡es un lenguaje genial!
"""
println(poema)

# Ejercicios para practicar:
# 1. Crea tu nombre completo usando interpolación
# 2. Cuenta cuántas vocales tiene una palabra
# 3. Invierte una cadena de texto
