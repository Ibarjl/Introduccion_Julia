# Ejercicio 6: Sets (Conjuntos) en Julia
# Aprende a trabajar con sets (colecciones de elementos únicos)

# Declaración de sets
numeros_set = Set([1, 2, 3, 4, 5])
frutas_set = Set(["manzana", "banana", "naranja"])
duplicados = Set([1, 2, 2, 3, 3, 3])  # Los duplicados se eliminan automáticamente

println("Set de números: $numeros_set")
println("Set de frutas: $frutas_set")
println("Set sin duplicados: $duplicados")

# Verificar pertenencia
contiene_3 = 3 in numeros_set
contiene_banana = "banana" in frutas_set
contiene_uva = "uva" in frutas_set

println("¿Contiene 3?: $contiene_3")
println("¿Contiene banana?: $contiene_banana")
println("¿Contiene uva?: $contiene_uva")

# Agregar elementos
push!(frutas_set, "uva")
push!(frutas_set, "manzana")  # No se duplicará
println("Frutas después de agregar: $frutas_set")

# Eliminar elementos
delete!(frutas_set, "banana")
println("Frutas después de eliminar banana: $frutas_set")

# Propiedades de sets
tamaño = length(numeros_set)
esta_vacio = isempty(Set())
println("Tamaño del set números: $tamaño")
println("¿Set vacío está vacío?: $esta_vacio")

# Operaciones de conjuntos
set_a = Set([1, 2, 3, 4])
set_b = Set([3, 4, 5, 6])

# Unión
union_sets = union(set_a, set_b)
println("Unión de A y B: $union_sets")

# Intersección
interseccion = intersect(set_a, set_b)
println("Intersección de A y B: $interseccion")

# Diferencia
diferencia_a_b = setdiff(set_a, set_b)
diferencia_b_a = setdiff(set_b, set_a)
println("A - B: $diferencia_a_b")
println("B - A: $diferencia_b_a")

# Diferencia simétrica
diff_simetrica = symdiff(set_a, set_b)
println("Diferencia simétrica: $diff_simetrica")

# Verificar subconjuntos
set_c = Set([1, 2])
es_subconjunto = issubset(set_c, set_a)
println("¿C es subconjunto de A?: $es_subconjunto")

# Crear set desde cadena
letras = Set("programacion")
println("Letras únicas en 'programacion': $letras")

# Convertir set a vector
vector_numeros = collect(numeros_set)
println("Set convertido a vector: $vector_numeros")

# Set de tipos mixtos
mixto_set = Set([1, "dos", 3.0, true])
println("Set mixto: $mixto_set")

# Ejercicios para practicar:
# 1. Encuentra letras comunes entre dos palabras
# 2. Elimina duplicados de una lista
# 3. Verifica si dos listas tienen elementos en común
