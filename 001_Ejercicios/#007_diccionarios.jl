# Ejercicio 7: Diccionarios en Julia
# Aprende a trabajar con diccionarios (mapas clave-valor)

# Declaración de diccionarios
edades = Dict("Ana" => 25, "Carlos" => 30, "María" => 28)
precios = Dict("manzana" => 1.50, "banana" => 0.80, "naranja" => 2.00)
info_personal = Dict(:nombre => "Julia", :version => 1.8, :tipo => "lenguaje")

println("Edades: $edades")
println("Precios: $precios")
println("Info personal: $info_personal")

# Acceso a valores
edad_ana = edades["Ana"]
precio_manzana = precios["manzana"]
nombre_lenguaje = info_personal[:nombre]

println("Edad de Ana: $edad_ana")
println("Precio de manzana: $precio_manzana")
println("Nombre del lenguaje: $nombre_lenguaje")

# Modificar valores
edades["Ana"] = 26
precios["banana"] = 0.90
println("Edades actualizadas: $edades")
println("Precios actualizados: $precios")

# Agregar nuevos pares clave-valor
edades["Luis"] = 22
precios["uva"] = 3.00
println("Después de agregar Luis: $edades")
println("Después de agregar uva: $precios")

# Eliminar elementos
delete!(edades, "Carlos")
println("Después de eliminar Carlos: $edades")

# Verificar existencia de claves
tiene_ana = haskey(edades, "Ana")
tiene_pedro = haskey(edades, "Pedro")
println("¿Tiene clave 'Ana'?: $tiene_ana")
println("¿Tiene clave 'Pedro'?: $tiene_pedro")

# Obtener todas las claves y valores
todas_personas = keys(edades)
todas_edades = values(edades)
println("Personas: $todas_personas")
println("Edades: $todas_edades")

# Iterar sobre diccionarios
println("\nIterando sobre edades:")
for (persona, edad) in edades
    println("$persona tiene $edad años")
end

# Diccionario con valores por defecto
get_edad = get(edades, "Pedro", 0)  # Devuelve 0 si no existe
println("Edad de Pedro (con default): $get_edad")

# Longitud del diccionario
num_personas = length(edades)
println("Número de personas: $num_personas")

# Diccionario vacío
vacio = Dict()
println("Diccionario vacío: $vacio")

# Diccionario desde pares
desde_pares = Dict([("a", 1), ("b", 2), ("c", 3)])
println("Desde pares: $desde_pares")

# Merge de diccionarios
dict1 = Dict("x" => 1, "y" => 2)
dict2 = Dict("y" => 3, "z" => 4)
merged = merge(dict1, dict2)
println("Diccionarios merged: $merged")

# Diccionario anidado
estudiantes = Dict(
    "curso1" => Dict("Ana" => 85, "Carlos" => 92),
    "curso2" => Dict("Ana" => 90, "Carlos" => 88)
)
println("Estudiantes: $estudiantes")
nota_ana_curso1 = estudiantes["curso1"]["Ana"]
println("Nota de Ana en curso1: $nota_ana_curso1")

# Ejercicios para practicar:
# 1. Crea un diccionario con información de países y capitales
# 2. Cuenta la frecuencia de palabras en una frase
# 3. Invierte un diccionario (valores como claves)
