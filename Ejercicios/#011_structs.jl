# Ejercicio 11: Structs en Julia
# Aprende a crear y usar estructuras de datos personalizadas

# Struct básico
struct Persona
    nombre::String
    edad::Int
    email::String
end

# Crear instancias del struct
persona1 = Persona("Ana García", 25, "ana@email.com")
persona2 = Persona("Carlos López", 30, "carlos@email.com")

println("Persona 1: $(persona1.nombre), $(persona1.edad) años")
println("Persona 2: $(persona2.nombre), $(persona2.edad) años")

# Struct mutable
mutable struct CuentaBancaria
    titular::String
    saldo::Float64
    numero_cuenta::String
end

# Crear cuenta y modificar saldo
cuenta = CuentaBancaria("María Rodríguez", 1000.0, "12345")
println("Saldo inicial: $(cuenta.saldo)")

# Modificar campos (solo en structs mutables)
cuenta.saldo += 500.0
println("Saldo después de depósito: $(cuenta.saldo)")

# Struct con constructor personalizado
struct Punto
    x::Float64
    y::Float64
    
    # Constructor interno
    function Punto(x, y)
        if x < 0 || y < 0
            error("Las coordenadas deben ser positivas")
        end
        new(x, y)
    end
end

# Uso del constructor
punto1 = Punto(3.0, 4.0)
println("Punto: ($(punto1.x), $(punto1.y))")

# Constructor externo
function Punto(r::Float64, θ::Float64, polar::Bool)
    if polar
        x = r * cos(θ)
        y = r * sin(θ)
        return Punto(x, y)
    else
        return Punto(r, θ)
    end
end

# Crear punto desde coordenadas polares
punto_polar = Punto(5.0, π/4, true)
println("Punto polar: ($(punto_polar.x), $(punto_polar.y))")

# Struct con valores por defecto
struct Producto
    nombre::String
    precio::Float64
    categoria::String
    disponible::Bool
    
    # Constructor con valores por defecto
    Producto(nombre, precio) = new(nombre, precio, "General", true)
    Producto(nombre, precio, categoria) = new(nombre, precio, categoria, true)
end

producto1 = Producto("Laptop", 999.99)
producto2 = Producto("Mouse", 25.50, "Accesorios")
println("$(producto1.nombre): \$$(producto1.precio)")
println("$(producto2.nombre): \$$(producto2.precio) - $(producto2.categoria)")

# Struct paramétrico
struct Vector2D{T}
    x::T
    y::T
end

# Vectores con diferentes tipos
vector_int = Vector2D{Int}(3, 4)
vector_float = Vector2D{Float64}(3.5, 4.2)
println("Vector entero: ($(vector_int.x), $(vector_int.y))")
println("Vector float: ($(vector_float.x), $(vector_float.y))")

# Métodos para structs
function distancia_origen(p::Punto)
    return sqrt(p.x^2 + p.y^2)
end

function mostrar_info(p::Persona)
    println("📧 $(p.nombre) ($(p.edad) años) - $(p.email)")
end

# Usar métodos
dist = distancia_origen(punto1)
println("Distancia al origen: $dist")
mostrar_info(persona1)

# Struct anidado
struct Direccion
    calle::String
    ciudad::String
    codigo_postal::String
end

struct PersonaCompleta
    info_personal::Persona
    direccion::Direccion
    telefono::String
end

# Crear persona completa
direccion = Direccion("Calle Mayor 123", "Madrid", "28001")
persona_info = Persona("Luis Martín", 28, "luis@email.com")
persona_completa = PersonaCompleta(persona_info, direccion, "600-123-456")

println("Nombre: $(persona_completa.info_personal.nombre)")
println("Ciudad: $(persona_completa.direccion.ciudad)")

# Struct con métodos especiales
struct Temperatura
    celsius::Float64
    
    function Temperatura(celsius)
        new(celsius)
    end
end

# Métodos de conversión
kelvin(t::Temperatura) = t.celsius + 273.15
fahrenheit(t::Temperatura) = t.celsius * 9/5 + 32

temp = Temperatura(25.0)
println("$(temp.celsius)°C = $(kelvin(temp))K = $(fahrenheit(temp))°F")

# Struct inmutable vs mutable
struct InmutableContador
    valor::Int
end

mutable struct MutableContador
    valor::Int
end

# El inmutable no se puede modificar
inmutable = InmutableContador(5)
# inmutable.valor = 10  # Esto daría error

# El mutable sí se puede modificar
mutable_contador = MutableContador(5)
mutable_contador.valor = 10
println("Contador mutable: $(mutable_contador.valor)")

# Ejercicios para practicar:
# 1. Crea un struct para representar un libro con título, autor y páginas
# 2. Implementa un struct para una cuenta de banco con métodos de depósito y retiro
# 3. Diseña un struct para representar un estudiante con sus calificaciones
