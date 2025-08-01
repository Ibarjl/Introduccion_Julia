# Ejercicio 5: Tuplas en Julia
# Aprende a trabajar con tuplas (estructuras inmutables)

# Declaración de tuplas
coordenadas = (3, 4)
persona = ("Ana", 25, "Ingeniera")
colores = ("rojo", "verde", "azul")

println("Coordenadas: $coordenadas")
println("Persona: $persona")
println("Colores: $colores")

# Acceso a elementos de tuplas
x = coordenadas[1]
y = coordenadas[2]
nombre = persona[1]
edad = persona[2]

println("Coordenada X: $x")
println("Coordenada Y: $y")
println("Nombre: $nombre")
println("Edad: $edad")

# Desempaquetado de tuplas
(coord_x, coord_y) = coordenadas
(nom, ed, prof) = persona

println("Desempaquetado - X: $coord_x, Y: $coord_y")
println("Desempaquetado - Nombre: $nom, Edad: $ed, Profesión: $prof")

# Propiedades de tuplas
longitud_persona = length(persona)
println("Longitud de tupla persona: $longitud_persona")

# Tuplas anidadas
punto_3d = ((1, 2), 3)
println("Punto 3D: $punto_3d")
plano_xy = punto_3d[1]
z = punto_3d[2]
println("Plano XY: $plano_xy, Z: $z")

# Tuplas con nombres (NamedTuple)
estudiante = (nombre="Carlos", edad=20, carrera="Física")
println("Estudiante: $estudiante")
println("Nombre del estudiante: $(estudiante.nombre)")
println("Carrera: $(estudiante.carrera)")

# Operaciones con tuplas
suma_coordenadas = coordenadas[1] + coordenadas[2]
println("Suma de coordenadas: $suma_coordenadas")

# Convertir tupla a vector
vector_colores = collect(colores)
println("Vector de colores: $vector_colores")

# Tupla vacía y de un elemento
tupla_vacia = ()
tupla_un_elemento = (42,)  # Nota la coma
println("Tupla vacía: $tupla_vacia")
println("Tupla de un elemento: $tupla_un_elemento")

# Comparación de tuplas
punto1 = (1, 2)
punto2 = (1, 2)
punto3 = (2, 1)

println("punto1 == punto2: $(punto1 == punto2)")
println("punto1 == punto3: $(punto1 == punto3)")

# Ejercicios para practicar:
# 1. Crea una tupla con información de un libro (título, autor, año)
# 2. Calcula la distancia entre dos puntos usando tuplas
# 3. Crea una función que devuelva múltiples valores usando tuplas
