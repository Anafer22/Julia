#simulacion de recorrido de un robot en una cuadricula
#cada celda guarda coordenadas (x,y)

#crear matrizz 3x3 de tuplas (x,y)
posiciones = [(x,y) for x in 1:3, y in 1:3]

#ruta simulada del robot (diagonal principal)
ruta = [(i,i) for i in 1:3]

println("Posiciones posibles:")
println(posiciones)
println("'\nRecorrido del robot:")
for p in ruta
    println("Robot en posicion", p)
end