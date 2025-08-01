# Ejercicio 13: Módulos en Julia
# Aprende a crear y usar módulos para organizar tu código

# Definir un módulo básico
module MiPrimerModulo
    # Exportar funciones que queremos hacer públicas
    export saludar, despedir
    
    # Función pública (exportada)
    function saludar(nombre)
        return "¡Hola $nombre desde MiPrimerModulo!"
    end
    
    # Función pública (exportada)
    function despedir(nombre)
        return "¡Adiós $nombre!"
    end
    
    # Función privada (no exportada)
    function funcion_interna()
        return "Esta es una función interna"
    end
    
    # Variable del módulo
    const VERSION_MODULO = "1.0.0"
end

# Usar el módulo
using .MiPrimerModulo

println(saludar("Julia"))
println(despedir("Mundo"))

# Acceder a elementos no exportados
println(MiPrimerModulo.funcion_interna())
println("Versión del módulo: $(MiPrimerModulo.VERSION_MODULO)")

# Módulo con submódulos
module Matematicas
    export sumar, restar
    
    function sumar(a, b)
        return a + b
    end
    
    function restar(a, b)
        return a - b
    end
    
    # Submódulo
    module Geometria
        export area_circulo, area_rectangulo
        
        function area_circulo(radio)
            return π * radio^2
        end
        
        function area_rectangulo(ancho, alto)
            return ancho * alto
        end
    end
    
    # Submódulo avanzado
    module Estadisticas
        export promedio, mediana
        
        function promedio(numeros)
            return sum(numeros) / length(numeros)
        end
        
        function mediana(numeros)
            sorted = sort(numeros)
            n = length(sorted)
            if n % 2 == 0
                return (sorted[n÷2] + sorted[n÷2 + 1]) / 2
            else
                return sorted[n÷2 + 1]
            end
        end
    end
end

# Usar módulos y submódulos
using .Matematicas
using .Matematicas.Geometria
using .Matematicas.Estadisticas

println("Suma: $(sumar(5, 3))")
println("Área del círculo: $(area_circulo(2))")
println("Promedio: $(promedio([1, 2, 3, 4, 5]))")

# Importar con alias
import .Matematicas as Mat
import .Matematicas.Geometria as Geo

println("Resta con alias: $(Mat.restar(10, 4))")
println("Área rectángulo con alias: $(Geo.area_rectangulo(3, 4))")

# Módulo con tipos personalizados
module Vehiculos
    export Coche, Bicicleta, acelerar, frenar
    
    # Tipo abstracto
    abstract type Vehiculo end
    
    # Tipos concretos
    struct Coche <: Vehiculo
        marca::String
        modelo::String
        velocidad::Float64
    end
    
    struct Bicicleta <: Vehiculo
        tipo::String
        velocidad::Float64
    end
    
    # Métodos para los tipos
    function acelerar(v::Coche, incremento)
        nueva_velocidad = v.velocidad + incremento
        return Coche(v.marca, v.modelo, nueva_velocidad)
    end
    
    function acelerar(v::Bicicleta, incremento)
        nueva_velocidad = v.velocidad + incremento
        return Bicicleta(v.tipo, nueva_velocidad)
    end
    
    function frenar(v::Vehiculo, decremento)
        nueva_velocidad = max(0, v.velocidad - decremento)
        if isa(v, Coche)
            return Coche(v.marca, v.modelo, nueva_velocidad)
        else
            return Bicicleta(v.tipo, nueva_velocidad)
        end
    end
    
    # Función para mostrar información
    function info_vehiculo(v::Vehiculo)
        if isa(v, Coche)
            return "Coche $(v.marca) $(v.modelo) - Velocidad: $(v.velocidad) km/h"
        else
            return "Bicicleta $(v.tipo) - Velocidad: $(v.velocidad) km/h"
        end
    end
end

using .Vehiculos

# Crear vehículos
mi_coche = Coche("Toyota", "Corolla", 60.0)
mi_bici = Bicicleta("Montaña", 15.0)

println(Vehiculos.info_vehiculo(mi_coche))
println(Vehiculos.info_vehiculo(mi_bici))

# Acelerar vehículos
mi_coche_rapido = acelerar(mi_coche, 20)
mi_bici_rapida = acelerar(mi_bici, 5)

println("Después de acelerar:")
println(Vehiculos.info_vehiculo(mi_coche_rapido))
println(Vehiculos.info_vehiculo(mi_bici_rapida))

# Módulo con configuración
module Configuracion
    # Configuración por defecto
    const CONFIG = Dict(
        "debug" => false,
        "puerto" => 8080,
        "host" => "localhost"
    )
    
    function get_config(clave)
        return get(CONFIG, clave, nothing)
    end
    
    function set_config!(clave, valor)
        CONFIG[clave] = valor
    end
    
    function mostrar_config()
        println("Configuración actual:")
        for (clave, valor) in CONFIG
            println("  $clave: $valor")
        end
    end
end

# Usar configuración
println("\n=== Configuración ===")
Configuracion.mostrar_config()
Configuracion.set_config!("debug", true)
Configuracion.set_config!("puerto", 3000)
println("\nDespués de cambios:")
Configuracion.mostrar_config()

# Módulo con constantes y enums simulados
module Estados
    export ACTIVO, INACTIVO, PENDIENTE, estado_a_string
    
    const ACTIVO = 1
    const INACTIVO = 2
    const PENDIENTE = 3
    
    function estado_a_string(estado)
        if estado == ACTIVO
            return "Activo"
        elseif estado == INACTIVO
            return "Inactivo"
        elseif estado == PENDIENTE
            return "Pendiente"
        else
            return "Desconocido"
        end
    end
end

using .Estados

println("\n=== Estados ===")
estado_actual = ACTIVO
println("Estado: $(estado_a_string(estado_actual))")

# Ejemplo de uso con include (simulado)
# Normalmente harías: include("mi_modulo.jl")
# Esto cargaría código desde un archivo externo

println("\n=== Información sobre módulos ===")
println("Nombres en Main: $(names(Main))")
println("Nombres en MiPrimerModulo: $(names(MiPrimerModulo))")

# Ejercicios para practicar:
# 1. Crea un módulo para operaciones con matrices
# 2. Diseña un módulo para manejo de fechas y tiempo
# 3. Implementa un módulo para validación de datos
