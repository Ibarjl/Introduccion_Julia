# Ejercicio Avanzado 1: Calculadora de Matrices
# Implementa operaciones matriciales completas con validaciones

using LinearAlgebra
using Printf

# Struct para representar una matriz con metadatos
struct MatrizExtendida
    datos::Matrix{Float64}
    nombre::String
    descripcion::String
    
    function MatrizExtendida(datos::Matrix{Float64}, nombre::String="", descripcion::String="")
        new(datos, nombre, descripcion)
    end
end

# Funciones de creación de matrices
function crear_matriz_ceros(filas, columnas)
    """Crea una matriz de ceros"""
    return MatrizExtendida(zeros(filas, columnas), "Matriz de Ceros", "Matriz $filas×$columnas de ceros")
end

function crear_matriz_unos(filas, columnas)
    """Crea una matriz de unos"""
    return MatrizExtendida(ones(filas, columnas), "Matriz de Unos", "Matriz $filas×$columnas de unos")
end

function crear_matriz_identidad(n)
    """Crea una matriz identidad n×n"""
    return MatrizExtendida(Matrix{Float64}(I, n, n), "Matriz Identidad", "Matriz identidad $n×$n")
end

function crear_matriz_aleatoria(filas, columnas, min_val=-10, max_val=10)
    """Crea una matriz con valores aleatorios"""
    datos = rand(filas, columnas) * (max_val - min_val) .+ min_val
    return MatrizExtendida(datos, "Matriz Aleatoria", "Matriz $filas×$columnas aleatoria")
end

function crear_matriz_diagonal(diagonal)
    """Crea una matriz diagonal"""
    n = length(diagonal)
    matriz = zeros(n, n)
    for i in 1:n
        matriz[i, i] = diagonal[i]
    end
    return MatrizExtendida(matriz, "Matriz Diagonal", "Matriz diagonal $n×$n")
end

# Operaciones básicas
function sumar_matrices(A::MatrizExtendida, B::MatrizExtendida)
    """Suma dos matrices"""
    if size(A.datos) != size(B.datos)
        error("Las matrices deben tener las mismas dimensiones para sumar")
    end
    
    resultado = A.datos + B.datos
    return MatrizExtendida(resultado, "Suma", "$(A.nombre) + $(B.nombre)")
end

function restar_matrices(A::MatrizExtendida, B::MatrizExtendida)
    """Resta dos matrices"""
    if size(A.datos) != size(B.datos)
        error("Las matrices deben tener las mismas dimensiones para restar")
    end
    
    resultado = A.datos - B.datos
    return MatrizExtendida(resultado, "Resta", "$(A.nombre) - $(B.nombre)")
end

function multiplicar_matrices(A::MatrizExtendida, B::MatrizExtendida)
    """Multiplica dos matrices"""
    if size(A.datos, 2) != size(B.datos, 1)
        error("El número de columnas de A debe igual al número de filas de B")
    end
    
    resultado = A.datos * B.datos
    return MatrizExtendida(resultado, "Producto", "$(A.nombre) × $(B.nombre)")
end

function multiplicar_escalar(A::MatrizExtendida, escalar::Float64)
    """Multiplica una matriz por un escalar"""
    resultado = A.datos * escalar
    return MatrizExtendida(resultado, "Producto Escalar", "$(A.nombre) × $escalar")
end

function transponer_matriz(A::MatrizExtendida)
    """Transpone una matriz"""
    resultado = transpose(A.datos)
    return MatrizExtendida(resultado, "Transpuesta", "$(A.nombre)ᵀ")
end

# Operaciones avanzadas
function calcular_determinante(A::MatrizExtendida)
    """Calcula el determinante de una matriz cuadrada"""
    filas, columnas = size(A.datos)
    if filas != columnas
        error("El determinante solo se puede calcular para matrices cuadradas")
    end
    
    return det(A.datos)
end

function calcular_inversa(A::MatrizExtendida)
    """Calcula la inversa de una matriz"""
    filas, columnas = size(A.datos)
    if filas != columnas
        error("Solo las matrices cuadradas pueden tener inversa")
    end
    
    det_A = det(A.datos)
    if abs(det_A) < 1e-10
        error("La matriz es singular (determinante ≈ 0), no tiene inversa")
    end
    
    resultado = inv(A.datos)
    return MatrizExtendida(resultado, "Inversa", "$(A.nombre)⁻¹")
end

function calcular_rango(A::MatrizExtendida)
    """Calcula el rango de una matriz"""
    return rank(A.datos)
end

function calcular_traza(A::MatrizExtendida)
    """Calcula la traza de una matriz cuadrada"""
    filas, columnas = size(A.datos)
    if filas != columnas
        error("La traza solo se puede calcular para matrices cuadradas")
    end
    
    return tr(A.datos)
end

function calcular_norma(A::MatrizExtendida, tipo="frobenius")
    """Calcula diferentes normas de la matriz"""
    if tipo == "frobenius"
        return norm(A.datos)
    elseif tipo == "infinito"
        return norm(A.datos, Inf)
    elseif tipo == "1"
        return norm(A.datos, 1)
    else
        error("Tipo de norma no reconocido")
    end
end

# Descomposiciones
function descomposicion_lu(A::MatrizExtendida)
    """Realiza descomposición LU"""
    if size(A.datos, 1) != size(A.datos, 2)
        error("La descomposición LU requiere una matriz cuadrada")
    end
    
    try
        factorizacion = lu(A.datos)
        L = MatrizExtendida(Matrix(factorizacion.L), "L", "Matriz triangular inferior")
        U = MatrizExtendida(Matrix(factorizacion.U), "U", "Matriz triangular superior")
        P = MatrizExtendida(Matrix(factorizacion.P), "P", "Matriz de permutación")
        
        return (L=L, U=U, P=P)
    catch e
        error("No se pudo realizar la descomposición LU: $e")
    end
end

function descomposicion_qr(A::MatrizExtendida)
    """Realiza descomposición QR"""
    try
        factorizacion = qr(A.datos)
        Q = MatrizExtendida(Matrix(factorizacion.Q), "Q", "Matriz ortogonal")
        R = MatrizExtendida(Matrix(factorizacion.R), "R", "Matriz triangular superior")
        
        return (Q=Q, R=R)
    catch e
        error("No se pudo realizar la descomposición QR: $e")
    end
end

function descomposicion_svd(A::MatrizExtendida)
    """Realiza descomposición en valores singulares (SVD)"""
    try
        factorizacion = svd(A.datos)
        U = MatrizExtendida(factorizacion.U, "U", "Matriz de vectores singulares izquierdos")
        S = MatrizExtendida(diagm(factorizacion.S), "Σ", "Matriz diagonal de valores singulares")
        V = MatrizExtendida(factorizacion.Vt, "Vᵀ", "Matriz transpuesta de vectores singulares derechos")
        
        return (U=U, S=S, Vt=V, valores_singulares=factorizacion.S)
    catch e
        error("No se pudo realizar la descomposición SVD: $e")
    end
end

# Eigenvalores y eigenvectores
function calcular_eigenvalores(A::MatrizExtendida)
    """Calcula eigenvalores de una matriz"""
    if size(A.datos, 1) != size(A.datos, 2)
        error("Los eigenvalores solo se calculan para matrices cuadradas")
    end
    
    try
        eigenvals = eigvals(A.datos)
        return eigenvals
    catch e
        error("No se pudieron calcular los eigenvalores: $e")
    end
end

function calcular_eigenvectores(A::MatrizExtendida)
    """Calcula eigenvalores y eigenvectores de una matriz"""
    if size(A.datos, 1) != size(A.datos, 2)
        error("Los eigenvectores solo se calculan para matrices cuadradas")
    end
    
    try
        factorizacion = eigen(A.datos)
        eigenvals = factorizacion.values
        eigenvecs = MatrizExtendida(factorizacion.vectors, "Eigenvectores", "Matriz de eigenvectores")
        
        return (valores=eigenvals, vectores=eigenvecs)
    catch e
        error("No se pudieron calcular los eigenvectores: $e")
    end
end

# Sistemas de ecuaciones
function resolver_sistema_lineal(A::MatrizExtendida, b::Vector{Float64})
    """Resuelve el sistema Ax = b"""
    if size(A.datos, 1) != length(b)
        error("Las dimensiones de A y b no son compatibles")
    end
    
    try
        if size(A.datos, 1) == size(A.datos, 2)
            # Sistema cuadrado
            solucion = A.datos \ b
        else
            # Sistema sobredeterminado - mínimos cuadrados
            solucion = A.datos \ b
        end
        
        return solucion
    catch e
        error("No se pudo resolver el sistema: $e")
    end
end

# Funciones de utilidad
function mostrar_matriz(A::MatrizExtendida, precision=2)
    """Muestra una matriz de forma formateada"""
    println("\n$(A.nombre)")
    if !isempty(A.descripcion)
        println("$(A.descripcion)")
    end
    println("Dimensiones: $(size(A.datos, 1))×$(size(A.datos, 2))")
    println("-" ^ 40)
    
    filas, columnas = size(A.datos)
    
    # Mostrar solo parte de la matriz si es muy grande
    max_mostrar = 8
    
    filas_mostrar = min(filas, max_mostrar)
    columnas_mostrar = min(columnas, max_mostrar)
    
    for i in 1:filas_mostrar
        fila_str = ""
        for j in 1:columnas_mostrar
            valor = A.datos[i, j]
            valor_str = @sprintf("%*.$(precision)f", 8, valor)
            fila_str *= valor_str * " "
        end
        
        if columnas > max_mostrar
            fila_str *= "..."
        end
        
        println(fila_str)
    end
    
    if filas > max_mostrar
        println("...")
    end
    
    println()
end

function propiedades_matriz(A::MatrizExtendida)
    """Analiza y muestra propiedades de una matriz"""
    filas, columnas = size(A.datos)
    
    println("\n🔍 ANÁLISIS DE PROPIEDADES - $(A.nombre)")
    println("=" ^ 50)
    println("📏 Dimensiones: $filas × $columnas")
    println("📊 Rango: $(calcular_rango(A))")
    println("📐 Norma Frobenius: $(round(calcular_norma(A, "frobenius"), digits=4))")
    
    if filas == columnas
        println("\n🔢 PROPIEDADES DE MATRIZ CUADRADA:")
        det_val = calcular_determinante(A)
        println("🎯 Determinante: $(round(det_val, digits=6))")
        println("🔄 Traza: $(round(calcular_traza(A), digits=4))")
        
        # Verificar propiedades especiales
        es_simetrica = isapprox(A.datos, A.datos')
        es_antisimetrica = isapprox(A.datos, -A.datos')
        es_ortogonal = isapprox(A.datos * A.datos', I)
        es_singular = abs(det_val) < 1e-10
        
        println("✅ Es simétrica: $es_simetrica")
        println("🔄 Es antisimétrica: $es_antisimetrica")
        println("📐 Es ortogonal: $es_ortogonal")
        println("⚠️  Es singular: $es_singular")
        
        if !es_singular
            println("🔢 Número de condición: $(round(cond(A.datos), digits=4))")
        end
    end
end

function menu_calculadora_matrices()
    """Menú interactivo de la calculadora de matrices"""
    
    # Almacén de matrices
    matrices = Dict{String, MatrizExtendida}()
    
    println("🧮 CALCULADORA AVANZADA DE MATRICES")
    println("=" ^ 50)
    
    while true
        println("\n📋 MENÚ PRINCIPAL:")
        println("1. 🆕 Crear matriz")
        println("2. 👁️  Ver matrices almacenadas")
        println("3. ➕ Operaciones básicas")
        println("4. 🔬 Operaciones avanzadas")
        println("5. 🧬 Descomposiciones")
        println("6. 🎯 Eigenvalores/Eigenvectores")
        println("7. 📏 Sistemas de ecuaciones")
        println("8. 🔍 Análisis de propiedades")
        println("9. 🗑️  Eliminar matriz")
        println("0. 🚪 Salir")
        print("Selecciona una opción: ")
        
        try
            opcion = parse(Int, readline())
            
            if opcion == 0
                println("¡Hasta luego! 👋")
                break
                
            elseif opcion == 1
                crear_matriz_interactiva!(matrices)
                
            elseif opcion == 2
                listar_matrices(matrices)
                
            elseif opcion == 3
                operaciones_basicas_menu(matrices)
                
            elseif opcion == 4
                operaciones_avanzadas_menu(matrices)
                
            elseif opcion == 5
                descomposiciones_menu(matrices)
                
            elseif opcion == 6
                eigenvalores_menu(matrices)
                
            elseif opcion == 7
                sistemas_ecuaciones_menu(matrices)
                
            elseif opcion == 8
                analisis_propiedades_menu(matrices)
                
            elseif opcion == 9
                eliminar_matriz_menu(matrices)
                
            else
                println("❌ Opción no válida")
            end
            
        catch e
            println("❌ Error: $e")
        end
        
        println("\nPresiona Enter para continuar...")
        readline()
    end
end

function crear_matriz_interactiva!(matrices)
    """Crea matrices de forma interactiva"""
    println("\n🆕 CREAR NUEVA MATRIZ")
    println("1. Matriz manual")
    println("2. Matriz de ceros")
    println("3. Matriz de unos")
    println("4. Matriz identidad")
    println("5. Matriz aleatoria")
    println("6. Matriz diagonal")
    print("Tipo de matriz: ")
    
    tipo = parse(Int, readline())
    print("Nombre para la matriz: ")
    nombre = strip(readline())
    
    if haskey(matrices, nombre)
        print("Ya existe una matriz con ese nombre. ¿Sobrescribir? (s/n): ")
        if lowercase(strip(readline())) != "s"
            return
        end
    end
    
    if tipo == 1
        # Matriz manual
        print("Número de filas: ")
        filas = parse(Int, readline())
        print("Número de columnas: ")
        columnas = parse(Int, readline())
        
        println("Ingresa los elementos fila por fila, separados por espacios:")
        datos = zeros(filas, columnas)
        
        for i in 1:filas
            print("Fila $i: ")
            elementos = [parse(Float64, x) for x in split(readline())]
            if length(elementos) != columnas
                error("Número incorrecto de elementos en la fila $i")
            end
            datos[i, :] = elementos
        end
        
        matrices[nombre] = MatrizExtendida(datos, nombre, "Matriz creada manualmente")
        
    elseif tipo == 2
        print("Número de filas: ")
        filas = parse(Int, readline())
        print("Número de columnas: ")
        columnas = parse(Int, readline())
        matrices[nombre] = crear_matriz_ceros(filas, columnas)
        matrices[nombre] = MatrizExtendida(matrices[nombre].datos, nombre, matrices[nombre].descripcion)
        
    elseif tipo == 3
        print("Número de filas: ")
        filas = parse(Int, readline())
        print("Número de columnas: ")
        columnas = parse(Int, readline())
        matrices[nombre] = crear_matriz_unos(filas, columnas)
        matrices[nombre] = MatrizExtendida(matrices[nombre].datos, nombre, matrices[nombre].descripcion)
        
    elseif tipo == 4
        print("Tamaño (n×n): ")
        n = parse(Int, readline())
        matrices[nombre] = crear_matriz_identidad(n)
        matrices[nombre] = MatrizExtendida(matrices[nombre].datos, nombre, matrices[nombre].descripcion)
        
    elseif tipo == 5
        print("Número de filas: ")
        filas = parse(Int, readline())
        print("Número de columnas: ")
        columnas = parse(Int, readline())
        matrices[nombre] = crear_matriz_aleatoria(filas, columnas)
        matrices[nombre] = MatrizExtendida(matrices[nombre].datos, nombre, matrices[nombre].descripcion)
        
    elseif tipo == 6
        print("Elementos diagonales separados por espacios: ")
        diagonal = [parse(Float64, x) for x in split(readline())]
        matrices[nombre] = crear_matriz_diagonal(diagonal)
        matrices[nombre] = MatrizExtendida(matrices[nombre].datos, nombre, matrices[nombre].descripcion)
    end
    
    println("✅ Matriz '$nombre' creada exitosamente")
    mostrar_matriz(matrices[nombre])
end

function listar_matrices(matrices)
    """Lista todas las matrices almacenadas"""
    if isempty(matrices)
        println("📭 No hay matrices almacenadas")
        return
    end
    
    println("\n📋 MATRICES ALMACENADAS:")
    for (nombre, matriz) in matrices
        filas, columnas = size(matriz.datos)
        println("  🔢 $nombre: $filas×$columnas - $(matriz.descripcion)")
    end
end

function operaciones_basicas_menu(matrices)
    """Menú de operaciones básicas"""
    if length(matrices) < 2
        println("❌ Necesitas al menos 2 matrices para operaciones básicas")
        return
    end
    
    println("\n➕ OPERACIONES BÁSICAS")
    println("1. Suma")
    println("2. Resta")  
    println("3. Multiplicación")
    println("4. Multiplicación por escalar")
    println("5. Transposición")
    print("Operación: ")
    
    operacion = parse(Int, readline())
    
    if operacion <= 3
        # Operaciones binarias
        listar_matrices(matrices)
        print("Primera matriz: ")
        nombre1 = strip(readline())
        print("Segunda matriz: ")
        nombre2 = strip(readline())
        
        if !haskey(matrices, nombre1) || !haskey(matrices, nombre2)
            println("❌ Una o ambas matrices no existen")
            return
        end
        
        try
            if operacion == 1
                resultado = sumar_matrices(matrices[nombre1], matrices[nombre2])
            elseif operacion == 2
                resultado = restar_matrices(matrices[nombre1], matrices[nombre2])
            else
                resultado = multiplicar_matrices(matrices[nombre1], matrices[nombre2])
            end
            
            println("✅ Operación realizada exitosamente")
            mostrar_matriz(resultado)
            
            print("¿Guardar resultado? (s/n): ")
            if lowercase(strip(readline())) == "s"
                print("Nombre para el resultado: ")
                nombre_resultado = strip(readline())
                matrices[nombre_resultado] = MatrizExtendida(resultado.datos, nombre_resultado, resultado.descripcion)
            end
            
        catch e
            println("❌ Error en la operación: $e")
        end
        
    elseif operacion == 4
        # Multiplicación por escalar
        listar_matrices(matrices)
        print("Matriz: ")
        nombre = strip(readline())
        print("Escalar: ")
        escalar = parse(Float64, readline())
        
        if haskey(matrices, nombre)
            resultado = multiplicar_escalar(matrices[nombre], escalar)
            mostrar_matriz(resultado)
        else
            println("❌ La matriz no existe")
        end
        
    elseif operacion == 5
        # Transposición
        listar_matrices(matrices)
        print("Matriz: ")
        nombre = strip(readline())
        
        if haskey(matrices, nombre)
            resultado = transponer_matriz(matrices[nombre])
            mostrar_matriz(resultado)
        else
            println("❌ La matriz no existe")
        end
    end
end

function operaciones_avanzadas_menu(matrices)
    """Menú de operaciones avanzadas"""
    if isempty(matrices)
        println("❌ No hay matrices almacenadas")
        return
    end
    
    println("\n🔬 OPERACIONES AVANZADAS")
    println("1. Determinante")
    println("2. Inversa")
    println("3. Rango")
    println("4. Traza")
    println("5. Normas")
    print("Operación: ")
    
    operacion = parse(Int, readline())
    
    listar_matrices(matrices)
    print("Matriz: ")
    nombre = strip(readline())
    
    if !haskey(matrices, nombre)
        println("❌ La matriz no existe")
        return
    end
    
    matriz = matrices[nombre]
    
    try
        if operacion == 1
            det_val = calcular_determinante(matriz)
            println("🎯 Determinante de $(matriz.nombre): $det_val")
            
        elseif operacion == 2
            inversa = calcular_inversa(matriz)
            println("✅ Inversa calculada exitosamente")
            mostrar_matriz(inversa)
            
        elseif operacion == 3
            rango = calcular_rango(matriz)
            println("📊 Rango de $(matriz.nombre): $rango")
            
        elseif operacion == 4
            traza = calcular_traza(matriz)
            println("🔄 Traza de $(matriz.nombre): $traza")
            
        elseif operacion == 5
            println("📐 Normas de $(matriz.nombre):")
            println("  Frobenius: $(calcular_norma(matriz, "frobenius"))")
            println("  Infinito: $(calcular_norma(matriz, "infinito"))")
            println("  1-norma: $(calcular_norma(matriz, "1"))")
        end
        
    catch e
        println("❌ Error en la operación: $e")
    end
end

function descomposiciones_menu(matrices)
    """Menú de descomposiciones"""
    if isempty(matrices)
        println("❌ No hay matrices almacenadas")
        return
    end
    
    println("\n🧬 DESCOMPOSICIONES")
    println("1. LU")
    println("2. QR")
    println("3. SVD")
    print("Descomposición: ")
    
    operacion = parse(Int, readline())
    
    listar_matrices(matrices)
    print("Matriz: ")
    nombre = strip(readline())
    
    if !haskey(matrices, nombre)
        println("❌ La matriz no existe")
        return
    end
    
    matriz = matrices[nombre]
    
    try
        if operacion == 1
            resultado = descomposicion_lu(matriz)
            println("✅ Descomposición LU realizada:")
            mostrar_matriz(resultado.P)
            mostrar_matriz(resultado.L)
            mostrar_matriz(resultado.U)
            
        elseif operacion == 2
            resultado = descomposicion_qr(matriz)
            println("✅ Descomposición QR realizada:")
            mostrar_matriz(resultado.Q)
            mostrar_matriz(resultado.R)
            
        elseif operacion == 3
            resultado = descomposicion_svd(matriz)
            println("✅ Descomposición SVD realizada:")
            println("🔢 Valores singulares: $(resultado.valores_singulares)")
            mostrar_matriz(resultado.U)
            mostrar_matriz(resultado.S)
            mostrar_matriz(resultado.Vt)
        end
        
    catch e
        println("❌ Error en la descomposición: $e")
    end
end

function eigenvalores_menu(matrices)
    """Menú de eigenvalores y eigenvectores"""
    if isempty(matrices)
        println("❌ No hay matrices almacenadas")
        return
    end
    
    listar_matrices(matrices)
    print("Matriz: ")
    nombre = strip(readline())
    
    if !haskey(matrices, nombre)
        println("❌ La matriz no existe")
        return
    end
    
    matriz = matrices[nombre]
    
    try
        resultado = calcular_eigenvectores(matriz)
        println("✅ Análisis espectral realizado:")
        println("🎯 Eigenvalores: $(resultado.valores)")
        mostrar_matriz(resultado.vectores)
        
    catch e
        println("❌ Error en el cálculo: $e")
    end
end

function sistemas_ecuaciones_menu(matrices)
    """Menú para resolver sistemas de ecuaciones"""
    if isempty(matrices)
        println("❌ No hay matrices almacenadas")
        return
    end
    
    listar_matrices(matrices)
    print("Matriz de coeficientes A: ")
    nombre_A = strip(readline())
    
    if !haskey(matrices, nombre_A)
        println("❌ La matriz no existe")
        return
    end
    
    print("Vector b (elementos separados por espacios): ")
    b = [parse(Float64, x) for x in split(readline())]
    
    try
        solucion = resolver_sistema_lineal(matrices[nombre_A], b)
        println("✅ Sistema resuelto:")
        println("🎯 Solución x: $solucion")
        
        # Verificar la solución
        residuo = matrices[nombre_A].datos * solucion - b
        error_residuo = norm(residuo)
        println("📏 Error residual: $error_residuo")
        
    catch e
        println("❌ Error al resolver el sistema: $e")
    end
end

function analisis_propiedades_menu(matrices)
    """Menú de análisis de propiedades"""
    if isempty(matrices)
        println("❌ No hay matrices almacenadas")
        return
    end
    
    listar_matrices(matrices)
    print("Matriz: ")
    nombre = strip(readline())
    
    if haskey(matrices, nombre)
        propiedades_matriz(matrices[nombre])
    else
        println("❌ La matriz no existe")
    end
end

function eliminar_matriz_menu(matrices)
    """Elimina una matriz del almacén"""
    if isempty(matrices)
        println("❌ No hay matrices almacenadas")
        return
    end
    
    listar_matrices(matrices)
    print("Matriz a eliminar: ")
    nombre = strip(readline())
    
    if haskey(matrices, nombre)
        delete!(matrices, nombre)
        println("✅ Matriz '$nombre' eliminada")
    else
        println("❌ La matriz no existe")
    end
end

function demo_calculadora_matrices()
    """Demostración de la calculadora"""
    println("=== DEMO CALCULADORA DE MATRICES ===\n")
    
    # Crear matrices de ejemplo
    A = MatrizExtendida([1.0 2.0; 3.0 4.0], "A", "Matriz ejemplo 2×2")
    B = MatrizExtendida([5.0 6.0; 7.0 8.0], "B", "Matriz ejemplo 2×2")
    
    println("📊 Matrices de ejemplo:")
    mostrar_matriz(A)
    mostrar_matriz(B)
    
    # Operaciones básicas
    println("➕ Suma A + B:")
    suma = sumar_matrices(A, B)
    mostrar_matriz(suma)
    
    println("✖️ Producto A × B:")
    producto = multiplicar_matrices(A, B)
    mostrar_matriz(producto)
    
    # Operaciones avanzadas
    println("🎯 Determinante de A: $(calcular_determinante(A))")
    println("🔄 Traza de A: $(calcular_traza(A))")
    
    # Análisis de propiedades
    propiedades_matriz(A)
    
    # Eigenvalores
    try
        eigen_resultado = calcular_eigenvectores(A)
        println("🎯 Eigenvalores de A: $(eigen_resultado.valores)")
    catch e
        println("❌ Error calculando eigenvalores: $e")
    end
end

# Ejecutar demo
demo_calculadora_matrices()

# Descomenta la siguiente línea para la calculadora interactiva
# menu_calculadora_matrices()

println("\n¡Calculadora de matrices implementada! Descomenta 'menu_calculadora_matrices()' para usarla.")
