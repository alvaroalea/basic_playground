#Burger Time

Mi participacion en el concurso de basic puro de 2003 de bytemaniacos: https://bytemaniacos.com/web/?page_id=3520
Podeis ver una sincera review aqui: https://www.youtube.com/watch?v=b19oPF99i2Y&t=1663s (minuto 22:30)

El original se programo directamente en un spectrum, el archivo .bas de este repositorio es la version ASCII editable en un ordenador moderno, se puede convertir en un .TAP para cargar en en un spectrum con el programa de Juan-Antonio Fernandez-Madrigal, zxbasicus que puedes encontrar en esta web:  https://jafma.net/software/zxbasicus/

##Detalles Tecnicos

A partir de la direccion de memoria 50000, tengo un bloque de 32x20 bytes que es basicamente el mapa de tiles, y utilizo para saber si el personaje se puede mover, por que hay una escalera, o plataforma.

A partir de la direccion 51000 hay otro mapa de bytes para la posicion de los trozos de hamburgesa.

La AI de los enemigos es asi: el amarillo intentara siempre moverse a una casilla que lo acerque a ti, el verde se mueve al azar.

Lo que se intento con este programa es que las hamburgesas se fueran cayendo mientras el jugador y resto de enemigos tambien lo hacia, sin interrumpir el juego, el resultado fue un juego muy lento y que los enemigos no son capaces de atraparte si te mueves.

##Versiones

La version 2.3 es un intento (sin resultados apreciables) de optimizar el basic para hacerlo mas rapido.
La version 2.4 es el WIP para compilarlo con el compilador de basic de boriel https://zxbasic.readthedocs.io/en/docs/
