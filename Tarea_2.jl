#------------------------- EJERCICIO 1 -------------------------
# Serie geométrica. Escribe una función que, dados un valor real x y un entero n, 
# calcule el valor de la serie geométrica definida por:
# gn(x) = 1 + x + x2 + ... + xn
# function gserie(x::Float64, n::Int)::Float64
function gserie(x::Float64, n::Int)::Float64
    suma = 0.0
    for i in 0:n
        suma += x^i
    end
    return suma
end
println(gserie(1.0,3)) 

#O bien, basado en la formula de una serie geometrica finita
function gserie(x::Float64, n::Int)::Float64
    if n < 0
       println("No debe ser un valor n negativo")
       return 0.0
    end
    if x == 1.0
        return Float64(n + 1)
    end
    return (1 - x^(n + 1)) / (1 - x)
end
println(gserie(2.0,3))  
println(gserie(1.0,3))
# ---------------------- EJERCICIO 2 -------------------------
#Verificar traslape de rangos. Implementa una función que determine si dos 
# intervalos numéricos [a,b] y [c,d] se traslapan. 
# function verificar_traslape(a::Float64, b::Float64, c::Float64, d::Float64)::Bool
function verificar_traslape(a::Float64, b::Float64, c::Float64, d::Float64):: Bool
    if a <= d && c <= b
        return true
    else 
        return false
    end
end
println(verificar_traslape(1.0,5.0,5.0,10.0))
#------------------------- EJERCICIO 3 -------------------------
#Numeros con múltiplos o digito 7. Dado un rango [a,b], imprime todos los 
# numeros que sean multiplos de 7 o contengan el digito 7, y muestra el conteo total.

function multiplos_o_digito_de_siete(a::Int, b::Int)::Int
    contador = 0 
    for i in a:b
        if (i % 7 == 0 ) || ('7' in string(i))
            println(i)
            contador += 1
        end
    end
    println("Conteo:",contador)
    return contador
end

multiplos_o_digito_de_siete(1,80)
#------------------------- EJERCICIO 4 -------------------------
# Normalización multi-criterio (min-max). Dadas las listas R y E, normaliza
# los valores usando el método min-max, que ajusta todos los valores al rango [0,1]
# mediante las formulas

using Statistics

function normalizar_min_max(R::Vector, E::Vector)
    R_norm = Float64[]
    min_r = minimum(R)
    max_r = maximum(R)
    # 2. Revisamos si todos los números son iguales.
    if max_r == min_r
        # 3. Si lo son, llenamos la lista con ceros.
        for _ in R # El guion bajo (_) significa que no nos importa el valor, solo repetir la acción.
            push!(R_norm, 0.0)
        end
    else
        # 4. Si no, recorremos la lista original número por número.
        for r_i in R
            # Calculamos el nuevo valor
            valor_normalizado = (r_i - min_r) / (max_r - min_r)
            # Y lo agregamos a nuestra lista de resultados
            push!(R_norm, valor_normalizado)
        end
    end
    # --- Hacemos exactamente lo mismo para E ---
    E_norm = Float64[]
    min_e = minimum(E)
    max_e = maximum(E)

    if max_e == min_e
        for _ in E
            push!(E_norm, 0.0)
        end
    else
        for e_i in E
            valor_normalizado = (e_i - min_e) / (max_e - min_e)
            push!(E_norm, valor_normalizado)
        end
    end
    return (R_norm, E_norm)
end

# --- Ejemplo de Uso (esta parte no cambia) ---
R = [10, 20, 30, 40, 50]
E = [300, 150, 450, 200, 500]

println("Lista R original: ", R)
println("Lista E original: ", E, "\n")

R_normalizada, E_normalizada = normalizar_min_max(R, E)

println("Lista R normalizada [0, 1]: ", R_normalizada)
println("Lista E normalizada [0, 1]: ", E_normalizada)

#------------------------- EJERCICIO 5 -------------------------
#Visualización de arreglo como imagen binaria. En este ejercicio se explorará 
# la conversión de un arreglo unidimensional en uno bidimensional y su representación
# visual
#Instrucciones:
# (a) Crea un arreglo unidimensional con valores binarios (0 y 1), por ejemplo:
# A = [1,0,1,1,0,0,1,0,1]
# (b) Transforma el arreglo A en una matriz bidimensional utilizando la función
# reshape. Ejemplo:
# M = reshape(A, 3, 3)
#(c) Utiliza una librería como Plots.jl o Images.jl para mostrar la matriz como
# una imagen binaria
# (d) Prueba con diferentes dimensiones y patrones para observar los cambios en la
# visialización
# Ejemplo de código sugerido:
# using Plots
# A = [1,0,1,1,0,0,1,0,1]
# M = reshape(A, 3, 3)
# heatmap(M, color = greys, axis = false, legend = false)
using Plots

function visualizar_matriz_binaria(vector::Vector, filas::Int, columnas::Int; titulo::String)
    if length(vector) != filas * columnas
        println("El número de elementos en el vector ($(length(vector))) no coincide con las dimensiones de la matriz ($filas x $columnas = $(filas * columnas)).")
    end
    matriz = reshape(vector, filas, columnas)
    p = heatmap(matriz, color = :greys, aspect_ratio = 1,axis = false, legend = false,title = titulo)
    return p
end

A1 = [1, 0, 1, 1, 0, 0, 1, 0, 1]
visualizar_matriz_binaria(A1, 3, 3, titulo="Patrón 3x3")
#------------------------- EJERCICIO 6 -------------------------
# Filtrado de una imagen con ruido. A partir del ejercicio anterior, este 
# problema busca introducir el concepto de filtrado en imágenes digitales. 
# Se agregará ruido a la matriz binaria y luego se aplicará un filtro básico 
# para suavizar la imagen.
# Instrucciones:
# (a) Parte de una matriz binaria M (como la creada en el ejercicio 5) y agregale ruido 
# aleatorio. Ejemplo de generación de ruido:
# using Random
# M_ruido = M .+ rand([-1, 0 , 1], size(M))
# M_ruido = clamp.(M_ruido, 0, 1) # Asegurar que los valores queden en 

# (b) Aplica un filtro de suavizado (promedio de vecinos) para reducir el ruido.
# El filtro puede expresarse matematicamente como:
# Aqui va una formula
# donde F(i,j) representa el valor filtrado en la posición(i,j) y el promedio se 
# calcula sobre la vecindad 3 x 3 centrada en (i,j).
# (c) Visualiza los resultados antes y después del filtrado utilizando heatmap, para 
# comparar el efecto del ruido y del suavizado.
# Objetivo: Comprendder como los filtros básicos reducen el ruido visual y permiten
# obtener una representación más limpia de los datos
using Plots
using Random
function generar_demo_filtro()
    # =================================================================
    # PASO 1: CREAR IMAGEN ORIGINAL Y AÑADIR RUIDO
    # =================================================================

    # Letra A (5x5) - Diseño corregido
    A = [1 0 0 0 1;      # Fila de abajo
         1 0 0 0 1;
         1 1 1 1 1;      # Fila del medio
         0 1 0 1 0;
         0 0 1 0 0]      # Fila de arriba

    # Letra N (5x5) - Diseño corregido
    N = [1 0 0 0 1;      # Fila de abajo
         1 0 0 1 1;
         1 0 1 0 1;      # Fila del medio
         1 1 0 0 1;
         1 0 0 0 1]      # Fila de arriba

    # Espacio
    espacio = zeros(Int, 5, 2)

    # --- Unimos las letras para formar la palabra "ANA" ---
    M = hcat(A, espacio, N, espacio, A)

    # --- Añadimos ruido ---
    Random.seed!(1234) # Para reproducibilidad
    ruido = rand([-1, 0, 1], size(M))
    M_ruido = M .+ ruido
    M_ruido = clamp.(M_ruido, 0, 1)
    # =================================================================
    # PASO 2: APLICAR EL FILTRO
    # =================================================================

    (filas, columnas) = size(M_ruido)
    F_suavizada = zeros(Float64, filas, columnas)

    for i in 2:(filas - 1)
        for j in 2:(columnas - 1)
            suma_vecinos = sum(M_ruido[i-1:i+1, j-1:j+1])
            F_suavizada[i, j] = suma_vecinos / 9.0
        end
    end
    # =================================================================
    # PASO 3: VISUALIZAR LOS RESULTADOS
    # =================================================================

    p1 = heatmap(M, color = cgrad(:greys, rev=true), title="Original ANA", aspect_ratio=1, axis=false, legend=false)
    p2 = heatmap(M_ruido, color = cgrad(:greys, rev=true), title="Con Ruido", aspect_ratio=1, axis=false, legend=false)
    p3 = heatmap(F_suavizada, color=:greys, title="Filtrada (Suavizada)", aspect_ratio=1, axis=false, legend=false)

    # Creamos el plot final
    plot_final = plot(p1, p2, p3, layout = (1, 3), size = (1200, 300))
    
    # Devolvemos el plot (en entornos como VSCode o Pluto, esto lo mostrará)
    return plot_final
end
# --- Llamamos a la función para ejecutar todo el proceso ---
generar_demo_filtro()