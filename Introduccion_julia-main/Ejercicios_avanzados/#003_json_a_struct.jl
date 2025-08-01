# Ejercicio Avanzado 3: JSON a Struct
# Convierte datos JSON en estructuras Julia tipadas

using JSON3

# Tipos base para conversión
abstract type JsonConvertible end

# Metadatos para campos
struct FieldMetadata
    required::Bool
    default_value::Any
    validator::Union{Function, Nothing}
    description::String
    
    FieldMetadata(; required=true, default_value=nothing, validator=nothing, description="") = 
        new(required, default_value, validator, description)
end

# Registro de tipos para conversión automática
const TYPE_REGISTRY = Dict{String, Type}()

# Macros para definir structs convertibles
macro json_struct(name, fields...)
    # Extraer información de campos
    field_defs = []
    field_metadata = Dict{Symbol, FieldMetadata}()
    
    for field in fields
        if isa(field, Expr) && field.head == :(::)
            # Campo con tipo: name::Type
            field_name = field.args[1]
            field_type = field.args[2]
            push!(field_defs, :($field_name::$field_type))
            field_metadata[field_name] = FieldMetadata()
        elseif isa(field, Expr) && field.head == :call && field.args[1] == :field
            # Campo con metadatos: field(name::Type, metadata...)
            field_spec = field.args[2]
            field_name = field_spec.args[1]
            field_type = field_spec.args[2]
            
            # Procesar metadatos
            metadata_args = field.args[3:end]
            metadata_dict = Dict{Symbol, Any}()
            for arg in metadata_args
                if isa(arg, Expr) && arg.head == :(=)
                    metadata_dict[arg.args[1]] = arg.args[2]
                end
            end
            
            push!(field_defs, :($field_name::$field_type))
            field_metadata[field_name] = FieldMetadata(;metadata_dict...)
        end
    end
    
    # Generar definición del struct
    struct_def = quote
        struct $name <: JsonConvertible
            $(field_defs...)
        end
    end
    
    # Registrar tipo
    register_expr = quote
        TYPE_REGISTRY[string($name)] = $name
        const $(Symbol(name, "_METADATA")) = $field_metadata
    end
    
    return quote
        $struct_def
        $register_expr
    end
end

# Funciones de conversión
function from_json(::Type{T}, json_data::Dict) where T <: JsonConvertible
    """Convierte datos JSON a struct tipado"""
    field_names = fieldnames(T)
    field_types = fieldtypes(T)
    args = []
    
    metadata = get(Main, Symbol(T, "_METADATA"), Dict{Symbol, FieldMetadata}())
    
    for (i, (field_name, field_type)) in enumerate(zip(field_names, field_types))
        json_key = string(field_name)
        field_meta = get(metadata, field_name, FieldMetadata())
        
        if haskey(json_data, json_key)
            # Campo presente en JSON
            value = json_data[json_key]
            converted_value = convert_value(field_type, value)
            
            # Validar si hay validador
            if field_meta.validator !== nothing
                if !field_meta.validator(converted_value)
                    throw(ArgumentError("Validation failed for field $field_name"))
                end
            end
            
            push!(args, converted_value)
        else
            # Campo no presente
            if field_meta.required
                throw(ArgumentError("Required field $field_name is missing"))
            else
                push!(args, field_meta.default_value)
            end
        end
    end
    
    return T(args...)
end

function convert_value(::Type{T}, value) where T
    """Convierte valor JSON al tipo apropiado"""
    if T <: String
        return string(value)
    elseif T <: Number
        return T(value)
    elseif T <: Bool
        return Bool(value)
    elseif T <: Vector
        element_type = eltype(T)
        return T([convert_value(element_type, v) for v in value])
    elseif T <: Dict
        return Dict(value)
    elseif T <: JsonConvertible
        return from_json(T, value)
    else
        return value
    end
end

function to_json(obj::JsonConvertible)
    """Convierte struct a diccionario JSON"""
    result = Dict{String, Any}()
    
    for field_name in fieldnames(typeof(obj))
        value = getfield(obj, field_name)
        json_key = string(field_name)
        result[json_key] = serialize_value(value)
    end
    
    return result
end

function serialize_value(value)
    """Serializa valor para JSON"""
    if isa(value, JsonConvertible)
        return to_json(value)
    elseif isa(value, Vector) && !isempty(value) && isa(value[1], JsonConvertible)
        return [to_json(v) for v in value]
    else
        return value
    end
end

# Validadores comunes
positive_number(x) = x > 0
valid_email(s) = occursin(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$", s)
non_empty_string(s) = length(strip(s)) > 0

# Ejemplos de uso
@json_struct Person begin
    field(name::String, required=true, validator=non_empty_string, description="Full name")
    field(age::Int, required=true, validator=positive_number, description="Age in years")
    field(email::String, required=false, default_value="", validator=valid_email, description="Email address")
    field(active::Bool, required=false, default_value=true, description="Account status")
end

@json_struct Address begin
    field(street::String, required=true, description="Street address")
    field(city::String, required=true, description="City name")
    field(postal_code::String, required=true, description="Postal code")
    field(country::String, required=false, default_value="Unknown", description="Country")
end

@json_struct Company begin
    field(name::String, required=true, description="Company name")
    field(employees::Vector{Person}, required=false, default_value=Person[], description="Employee list")
    field(address::Address, required=true, description="Company address")
    field(founded::Int, required=false, default_value=2000, description="Year founded")
end

# Sistema de esquemas
struct JsonSchema
    name::String
    description::String
    properties::Dict{String, Dict{String, Any}}
    required_fields::Vector{String}
end

function generate_schema(::Type{T}) where T <: JsonConvertible
    """Genera esquema JSON para un tipo"""
    metadata = get(Main, Symbol(T, "_METADATA"), Dict{Symbol, FieldMetadata}())
    
    properties = Dict{String, Dict{String, Any}}()
    required_fields = String[]
    
    for (field_name, field_type) in zip(fieldnames(T), fieldtypes(T))
        field_meta = get(metadata, field_name, FieldMetadata())
        json_key = string(field_name)
        
        prop_info = Dict{String, Any}(
            "type" => json_type_name(field_type),
            "description" => field_meta.description
        )
        
        if field_meta.default_value !== nothing
            prop_info["default"] = field_meta.default_value
        end
        
        properties[json_key] = prop_info
        
        if field_meta.required
            push!(required_fields, json_key)
        end
    end
    
    return JsonSchema(
        string(T),
        "Schema for $(T)",
        properties,
        required_fields
    )
end

function json_type_name(::Type{T}) where T
    if T <: String
        return "string"
    elseif T <: Integer
        return "integer"
    elseif T <: AbstractFloat
        return "number"
    elseif T <: Bool
        return "boolean"
    elseif T <: Vector
        return "array"
    elseif T <: Dict
        return "object"
    else
        return "object"
    end
end

# Validación de JSON contra esquema
function validate_json(json_data::Dict, schema::JsonSchema)
    """Valida datos JSON contra esquema"""
    errors = String[]
    
    # Verificar campos requeridos
    for required_field in schema.required_fields
        if !haskey(json_data, required_field)
            push!(errors, "Missing required field: $required_field")
        end
    end
    
    # Verificar tipos de campos presentes
    for (field_name, value) in json_data
        if haskey(schema.properties, field_name)
            expected_type = schema.properties[field_name]["type"]
            actual_type = get_json_type(value)
            
            if actual_type != expected_type && expected_type != "object"
                push!(errors, "Field $field_name: expected $expected_type, got $actual_type")
            end
        end
    end
    
    return isempty(errors), errors
end

function get_json_type(value)
    """Determina el tipo JSON de un valor"""
    if isa(value, String)
        return "string"
    elseif isa(value, Integer)
        return "integer"
    elseif isa(value, AbstractFloat)
        return "number"
    elseif isa(value, Bool)
        return "boolean"
    elseif isa(value, Vector)
        return "array"
    elseif isa(value, Dict)
        return "object"
    else
        return "unknown"
    end
end

# Funciones de utilidad
function load_from_json_file(::Type{T}, filename::String) where T <: JsonConvertible
    """Carga struct desde archivo JSON"""
    json_string = read(filename, String)
    json_data = JSON3.read(json_string, Dict)
    return from_json(T, json_data)
end

function save_to_json_file(obj::JsonConvertible, filename::String)
    """Guarda struct a archivo JSON"""
    json_data = to_json(obj)
    json_string = JSON3.write(json_data)
    write(filename, json_string)
end

function pretty_print_json(obj::JsonConvertible)
    """Imprime JSON de forma legible"""
    json_data = to_json(obj)
    json_string = JSON3.write(json_data)
    
    # Formateo simple
    formatted = replace(json_string, "," => ",\n  ")
    formatted = replace(formatted, "{" => "{\n  ")
    formatted = replace(formatted, "}" => "\n}")
    formatted = replace(formatted, "[" => "[\n    ")
    formatted = replace(formatted, "]" => "\n  ]")
    
    println(formatted)
end

# Demostración y testing
function demo_json_conversion()
    """Demostración completa del sistema JSON"""
    println("=== DEMO CONVERSIÓN JSON ===\n")
    
    # Crear datos de ejemplo
    address = Address("123 Main St", "Anytown", "12345", "USA")
    
    person1 = Person("John Doe", 30, "john@example.com", true)
    person2 = Person("Jane Smith", 25, "jane@example.com", true)
    
    company = Company("Tech Corp", [person1, person2], address, 2010)
    
    println("🏢 Estructura original:")
    println("Company: $(company.name)")
    println("Employees: $(length(company.employees))")
    println("Address: $(company.address.city), $(company.address.country)")
    
    # Convertir a JSON
    println("\n📝 Conversión a JSON:")
    json_data = to_json(company)
    pretty_print_json(company)
    
    # Generar esquema
    println("\n📋 Esquema generado:")
    schema = generate_schema(Company)
    println("Nombre: $(schema.name)")
    println("Campos requeridos: $(join(schema.required_fields, ", "))")
    println("Propiedades:")
    for (prop, info) in schema.properties
        println("  $prop: $(info["type"]) - $(info["description"])")
    end
    
    # Validar JSON
    println("\n✅ Validación de JSON:")
    is_valid, errors = validate_json(json_data, schema)
    if is_valid
        println("JSON válido ✓")
    else
        println("Errores encontrados:")
        for error in errors
            println("  ❌ $error")
        end
    end
    
    # Reconstruir desde JSON
    println("\n🔄 Reconstrucción desde JSON:")
    company_restored = from_json(Company, json_data)
    println("Company restaurada: $(company_restored.name)")
    println("Empleados restaurados: $(length(company_restored.employees))")
    
    # Verificar integridad
    integrity_check = (
        company.name == company_restored.name &&
        length(company.employees) == length(company_restored.employees) &&
        company.address.city == company_restored.address.city
    )
    
    println("Integridad de datos: $(integrity_check ? "✓" : "❌")")
    
    # Test de validación con datos inválidos
    println("\n🧪 Test con datos inválidos:")
    invalid_json = Dict(
        "name" => "",  # Validación fallará
        "age" => -5,   # Validación fallará
        "email" => "invalid-email",  # Validación fallará
        "active" => true
    )
    
    try
        invalid_person = from_json(Person, invalid_json)
        println("❌ Debería haber fallado la validación")
    catch e
        println("✅ Validación funcionó correctamente: $e")
    end
end

# Ejecutar demostración
demo_json_conversion()

println("\n¡Sistema de conversión JSON a Struct implementado!")
