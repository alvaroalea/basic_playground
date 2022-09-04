   REM (C) 2003 Alvaro Alea Fenandez, ALEAsoft 
   REM Distribuido bajo licencia GPL Version 2 
   REM Dedicado a Covadonga

   DIM r as float
   DIM punt as integer
   DIM hipunt as integer
   DIM vidas as ubyte
   DIM hpend as ubyte
   DIM hlistas as ubyte
   DIM hamb as ubyte
   DIM nivel as ubyte
   DIM py as ubyte
   DIM px as ubyte
   DIM my as ubyte
   DIM mx as ubyte
   DIM cy as ubyte
   DIM cx as ubyte
   DIM py1 as ubyte
   DIM px1 as ubyte
   DIM my1 as ubyte
   DIM mx1 as ubyte
   DIM cy1 as ubyte
   DIM cx1 as ubyte
   DIM a as ubyte
   DIM b as integer
   DIM c as ubyte
   DIM d as integer
   DIM d1 as ubyte
   DIM f as integer
   DIM n as ubyte
   DIM t as ubyte
   DIM x as ubyte
   DIM y as ubyte
   DIM dif as ubyte
   DIM dh as integer
   DIM nc as integer
   DIM frame as long
   DIM pframe as long
   DIM mapa1(32,20) as ubyte

   RANDOMIZE   
   LET nc = 8
   LET hipunt = 0   
   GOSUB 9610 : REM definimos los UDG 
   GOTO 850   : REM y vamos al MENU PRINCIPAL.

   REM DATA FORMAT: elemento (vertical si >=10, si =0 fin pintado), numero de repeticiones, x, y

20 DATA  1,26,3,4,  1,26,3,8,   1,11,3,12, 1,11,18,12,  1,26,3,16  
   DATA 10,12,5,4, 10,12,27,4, 10,8,12,4, 10,4,19,12 
   DATA  2,3,8,19,  2,3,22,19, 2,3,22,4,  2,3,8,16, 2,3,8,12, 2,3,8,8, 2,3,22,16, 2,3,22,12, 2,3,22,8, 0 
   DATA  17,8,8,8,12,8,16, 17,22,4,22,8,22,12,0  
   DATA  15,28,15,3,15,15

21 DATA 1,25,2,4, 1,20,2,8, 1,5,24,8, 1,27,2,12, 1,16,2,16 
   DATA 10,4,3,4, 10,4,7,8, 10,4,3,12, 10,12,10,4, 10,12,16,4, 10,4,25,4, 10,4,27,8 
   DATA 2,3,12,4, 2,3,12,8, 2,3,12,12, 2,3,12,16, 2,3,18,4, 2,3,18,8, 2,3,18,12, 0 
   DATA  17,12,4,12,8,12,12, 13,18,4,18,8,18,12, 0  
   DATA  11,28,15,3,16,15

22 DATA  1,26,3,4,  1,26,3,8,  1,11,3,12,  1,11,18,12,  1,26,3,16
   DATA 10,12,5,4,  10,12,27,4,  10,8,12,4, 10,4,19,12 
   DATA 2,3,8,19, 2,3,22,19, 2,3,22,4, 2,3,8,16, 2,3,8,12, 2,3,8,8, 2,3,22,16, 2,3,22,12, 2,3,22,8, 0
   DATA 17,8,8,8,12,8,16, 17,22,4,22,8,22,12,0
   DATA 15,28,15,3,15,15

23 DATA 1,25,2,4, 1,20,2,8, 1,5,24,8, 1,27,2,12, 1,16,2,16
   DATA 10,4,3,4, 10,4,7,8, 10,4,3,12, 10,12,10,4, 10,12,16,4, 10,4,25,4, 10,4,27,8
   DATA 2,3,12,4, 2,3,12,8, 2,3,12,12, 2,3,12,16, 2,3,18,4, 2,3,18,8, 2,3,18,12, 0
   DATA 17,12,4,12,8,12,12, 13,18,4,18,8,18,12, 0
   DATA 11,28,15,3,16,15

24 DATA  1,26,3,4,  1,26,3,8,  1,11,3,12,  1,11,18,12,  1,26,3,16  
   DATA 10,12,5,4,  10,12,27,4,  10,8,12,4, 10,4,19,12
   DATA  2,3,8,19, 2,3,22,19, 2,3,22,4, 2,3,8,16, 2,3,8,12, 2,3,8,8, 2,3,22,16, 2,3,22,12, 2,3,22,8, 0
   DATA  17,8,8,8,12,8,16, 17,22,4,22,8,22,12,0
   DATA  15,28,15,3,15,15

25 DATA 1,25,2,4, 1,20,2,8, 1,5,24,8, 1,27,2,12, 1,16,2,16
   DATA 10,4,3,4, 10,4,7,8, 10,4,3,12, 10,12,10,4, 10,12,16,4, 10,4,25,4, 10,4,27,8
   DATA 2,3,12,4, 2,3,12,8, 2,3,12,12, 2,3,12,16, 2,3,18,4, 2,3,18,8, 2,3,18,12, 0
   DATA 17,12,4,12,8,12,12, 13,18,4,18,8,18,12, 0
   DATA 11,28,15,3,16,15

    REM 30 imprimir escenario e incializar variables
30  CLS  :  PRINT  AT 0 , 0 ; "DIBUJANDO MAPA, ESPERE POR FAVOR"
    FOR a = 0 to 31
      FOR b = 0 to 19 
        LET mapa1(a,b)=0
      next b
    next a 
    if nivel = 0 then restore 20 : goto 90
    if nivel = 1 then restore 21 : goto 90
    if nivel = 2 then restore 22 : goto 90
    if nivel = 3 then restore 23 : goto 90
    if nivel = 4 then restore 24 : goto 90
    if nivel = 5 then restore 25 : goto 90
90  READ a : IF a = 0 THEN  GOTO 210
      IF a = 1 THEN  LET p$ = "\H" :  INK 3
      IF a = 2 THEN  LET p$ = "_" :  INK 7
      IF a = 10 THEN  LET p$ = "\G" :  INK 5
      READ n :  READ x :  READ y
      FOR c = 1 TO n
        PRINT  AT y , x ; p$
        LET mapa1(x,y)=a
        IF a < 10 THEN  LET x = x + 1
        IF a >= 10 THEN  LET y = y + 1 
      NEXT c
    GOTO 90
210 GOSUB 1110 : REM Imprime las hamburgesas
    LET py1 = 15 :  LET px1 = 28 :  GOSUB 640 : REM Inicializa e imprime el bicho P (medio)
    LET my1 = 15 :  LET mx1 =  3 :  GOSUB 570 : REM Inicializa e imprime el bicho M (medio)
    LET cx1 = 15 :  LET cy1 = 15 :  GOSUB 810 : REM Inicializa e imprime el Jugador (medio)
    GOSUB 670 : REM imprimir vidas
    GOSUB 930 : REM imprimir marcador
    LET frame = PEEK 23672 + 256*PEEK 23673 + 65536*PEEK 23674
    LET pframe = frame

    REM 270 - INICIO BUCLE JUEGO
270 LET frame = PEEK 23672 + 256*PEEK 23673 + 65536*PEEK 23674
    IF frame < (pframe + 10) THEN GOTO 270
    LET pframe = frame
    LET key$ =  INKEY$ 
    IF key$ = "o" AND  mapa1(cx-1,cy+1) <> 0 THEN  LET cx1 = cx - 1 :  GOTO 330
    IF key$ = "p" AND  mapa1(cx+1,cy+1) <> 0 THEN  LET cx1 = cx + 1 :  GOTO 330
    IF key$ = "a" AND  mapa1(cx  ,cy+1) = 10 THEN  LET cy1 = cy + 1 :  GOTO 330
    IF key$ = "q" AND  mapa1(cx  ,cy  ) = 10 THEN  LET cy1 = cy - 1 :  GOTO 330
    IF key$ = "t" THEN  GOTO 730
330 IF cx <> cx1 OR cy <> cy1 THEN  GOSUB 770 : REM si se movio imprime al jugador
    IF hpend > 0 THEN  GOSUB 1400 : REM si hamb. cayendo, actualiza
    IF hlistas = 6 THEN  GOTO 1560 : REM todas abajo fin nivel.

    REM P se mueve al azar
380 LET r =  RND 
    REM IF r < 0.25 AND  PEEK  ( @mapa +  ( 32 *  ( py + 1 )  )  + px - 1 ) <> 0 THEN  LET px1 = px - 1 :  GOTO 440
    REM IF r < 0.50 AND  PEEK  ( @mapa +  ( 32 *  ( py + 1 )  )  + px + 1 ) <> 0 THEN  LET px1 = px + 1 :  GOTO 440
    REM IF r < 0.75 AND  PEEK  ( @mapa +  ( 32 *  ( py + 1 )  )  + px )  = 10 THEN  LET py1 = py + 1 :  GOTO 440
    REM IF  PEEK  ( @mapa +  ( 32 *  ( py )  )  + px )  = 10 THEN  LET py1 = py - 1 :  GOTO 440

    IF r < 0.25 AND mapa1(px-1,py+1)<>0 THEN  LET px1 = px - 1 :  GOTO 440
    IF r < 0.50 AND mapa1(px+1,py+1)<>0 THEN  LET px1 = px + 1 :  GOTO 440
    IF r < 0.75 AND mapa1(px  ,py+1)=10 THEN  LET py1 = py + 1 :  GOTO 440
    IF mapa1(px,py)=10 THEN  LET py1 = py - 1 :  GOTO 440

    IF px1 = px AND py1 = py THEN  GOTO 380
440 GOSUB 600 : REM Imprimir bicho P
    IF cx = px AND cy = py THEN  GOTO 1030 : REM muerte por P
   
    REM M no siempre se mueve, pero si lo hace, persigue al jugador
450 IF  RND  < 0.15 THEN  GOTO 270
    IF my > cy AND  mapa1(mx,my)  = 10 THEN  LET my1 = my - 1 :  GOTO 510
    IF my < cy AND  mapa1(mx,my+1)  = 10 THEN  LET my1 = my + 1 :  GOTO 510
    IF cx < mx AND  mapa1(mx-1,my+1)  <> 0 THEN  LET mx1 = mx - 1 :  GOTO 510
    IF  mapa1(mx+1,my+1)  <> 0 THEN  LET mx1 = mx + 1 :  GOTO 510
    LET mx1 = mx1 - 1
510 GOSUB 530 : REM Imprimir bicho M
    IF cx = mx AND cy = my THEN  GOTO 1030 : REM muerte por M

    GOTO 270 : REM inicio bucle juego.

    REM 530 - RUTINA IMPRIMIR el bicho M
530 IF  mapa1(mx,my-1) = 10 THEN  PRINT  INK 5 ;  AT my - 1 , mx ; "\G" :  GOTO 550
    PRINT  AT my - 1 , mx ; " "
550 IF  mapa1(mx,my)   = 10 THEN  PRINT  INK 5 ;  AT my , mx ; "\G" :  GOTO 570
    PRINT  AT my , mx ; " "
570 LET my = my1 :  LET mx = mx1
    PRINT  INK 6 ;  AT my - 1 , mx ; "\K" ;  AT my , mx ; "\L"
590 RETURN

    REM 600 - RUTINA IMPRIMIR el bicho P 
600 IF  mapa1(px,py-1) = 10 THEN  PRINT  INK 5 ;  AT py - 1 , px ; "\G" :  GOTO 620
    PRINT  AT py - 1 , px ; " "
620 IF  mapa1(px,py-1) = 10 THEN  PRINT  INK 5 ;  AT py , px ; "\G" :  GOTO 640
    PRINT  AT py , px ; " "
640 LET py = py1 :  LET px = px1
    PRINT  INK 4 ;  AT py - 1 , px ; "\M" ;  AT py , px ; "\N"
660 RETURN

    REM 770 - RUTINA IMPRIMIR al jugador
770 IF  mapa1(cx,cy) = 10 THEN  PRINT  INK 5 ;  AT cy , cx ; "\G" :  GOTO 790
    PRINT  AT cy , cx ; " "
790 IF  mapa1(cx,cy-1) = 10 THEN  PRINT  INK 5 ;  AT cy - 1 , cx ; "\G" :  GOTO 810
    PRINT  AT cy - 1 , cx ; " "
810 PRINT  INK 7 ;  AT cy1 - 1 , cx1 ; "\I" ;  AT cy1 , cx1 ; "\J"
    LET cx = cx1 :  LET cy = cy1
    IF mapa1(cx,cy+1) = 2 THEN  GOSUB 1260
    RETURN 

    REM 730 - RUTINA DE GAME OVER 
730 PRINT  INK 7 ;  AT 9 , 10 ;  FLASH 1 ; "           " ;  AT 10 , 10 ; " GAME OVER " ;  AT 11 , 10 ; "           "
    IF hipunt < punt THEN  LET hipunt = punt
750 IF  INKEY$  <> "" THEN  GOTO 750
    PAUSE 1 :  PAUSE 0

    REM 850 - MENU PRINCIPAL
850 BORDER 1 :  INK 7 :  PAPER 0 :  BRIGHT 1 :  FLASH 0 :  CLS 
    PRINT  AT 1 , 10 ; INK 3 ; "Super" 
    PRINT  AT 2 , 12 ; "BURGER" ;  AT 3 , 13 ; "TIME" ;  
    PRINT  AT 3 , 26 ; "\I" ;  AT 4 , 26 ; "\J"
    PRINT  AT 2 , 5 ;  INK 2 ; "\A\B\C" ;  AT 4 , 5 ; "\A\B\C" ;  AT 2 , 21 ; "\A\B\C" ;  AT 4 , 21 ; "\A\B\C" 
    PRINT  AT 3 , 5 ;INK 4 ; "\D\E\F" ;  AT 3 , 21 ; "\D\E\F" ;  
    PRINT  AT 5 , 0 ; INK 3 ; "\H\H\H\H\H\H\H\H\H\H\H\H\H\H\H\H\H\H\H\H\H\H\H\H\H\H\H\H\H\H\H\H"
    PRINT  AT 8 , 2 ; "Movimientos: O,P,Q,A"
    PRINT  AT 10 , 2 ; "Instrucciones: Pasa por"
    PRINT  AT 11 , 2 ; "encima de los ingredientes      de las hamburgesas mientras"         
    PRINT  AT 13 , 2 ; "evitas al pimiento y la         mancha de mostaza, El nivel"
    PRINT  AT 15 , 2 ; "acaba cuando tengas todas       las hamburgesas listas."
    PRINT  AT 18 , 1 ; FLASH 1 ; " PULSE UNA TECLA PARA EMPEZAR " ;
    PRINT  AT 21 , 2 ; "\* 2003 Alvaro Alea - " ;  INK 2 ; "A" ;  INK 6 ; "L" ;  INK 4 ; "E" ;  INK 1 ; "A" ;  INK 3 ; "soft"
    PAUSE 0
    LET hlistas = 0
    LET hpend = 0
    LET punt = 0
    LET vidas = 3
    LET nivel = 0
    GOTO 30

    REM 930 - RUTINA DE IMPRIMIR MARCADOR
930 INK 7 :  PRINT  AT 0 , 0 ; "BURGER TIME SCORE:" ; 
    IF punt < 1000 THEN  PRINT "0" ; 
    IF punt < 100 THEN  PRINT "0" ; 
    IF punt < 10 THEN  PRINT "0" ; 
    PRINT punt ; " HISC:" ; 
    IF hipunt < 1000 THEN  PRINT "0" ; 
    IF hipunt < 100 THEN  PRINT "0" ; 
    IF hipunt < 10 THEN  PRINT "0" ; 
    PRINT hipunt
    RETURN

     REM 1030 - RUTINA DE VIDA MENOS 
1030 LET vidas = vidas - 1
     BORDER 2 :  BEEP 1 , 0 :  BORDER 1
     IF vidas = 0 THEN  GOTO 730 : REM GOTO RUTINA GAME OVER
     GOSUB 670
     LET px1 = 28 :  LET py1 = 15 :  GOSUB 600
     LET mx1 = 3 :  LET my1 = 15 :  GOSUB 530
     LET cx1 = 15 :  LET cy1 = 15 :  GOSUB 810
     GOTO 270

    REM 670 - RUTINA IMPRIMIR VIDAS 
670 LET a = 20 -  ( 3 * vidas ) 
    FOR c = 5 TO 20 STEP 3
    PRINT  INK 7 ;  AT c , 0 ; " " ;  AT c + 1 , 0 ; " "
    IF c > a THEN  PRINT  INK 7 ;  AT c , 0 ; "\I" ;  AT c + 1 , 0 ; "\J"
    NEXT c
    RETURN

     REM 1110 - RUTINA IMPRESION HAMBURGESAS
1110 LET hamb = 0 :  LET dh = @hmapa
1120 READ t
1130 IF t = 0 THEN  GOTO 1240
1140 READ x , y
1150 POKE dh , x :  POKE dh + 1 , y :  POKE dh + 2 , 0 :  POKE dh + 3 , 0 :  POKE dh + 4 , 0 :  POKE dh + 5 , 2 :  POKE dh + 6 , 144 :  POKE dh + 7 , t :  LET dh = dh + nc
1160 PRINT  INK 2 ;  AT y , x ; "\A\B\C"
1170 READ x , y
1180 POKE dh , x :  POKE dh + 1 , y :  POKE dh + 2 , 0 :  POKE dh + 3 , 0 :  POKE dh + 4 , 0 :  POKE dh + 5 , 4 :  POKE dh + 6 , 147 :  POKE dh + 7 , t + 1 :  LET dh = dh + nc
1190 PRINT  INK 4 ;  AT y , x ; "\D\E\F"
1200 READ x , y
1210 POKE dh , x :  POKE dh + 1 , y :  POKE dh + 2 , 0 :  POKE dh + 3 , 0 :  POKE dh + 4 , 0 :  POKE dh + 5 , 2 :  POKE dh + 6 , 144 :  POKE dh + 7 , t + 2 :  LET dh = dh + nc
1220 PRINT  INK 2 ;  AT y , x ; "\A\B\C"
1230 LET hamb = hamb + 1 :  GOTO 1120
1240 POKE dh , 0 :  POKE dh + 1 , 0
1250 RETURN

1260 LET d = @hmapa
1270 IF  PEEK  ( d + 1 )  = 0 THEN  RETURN 
     IF  PEEK  ( d + 1 )  <>  ( cy + 1 )  THEN  LET d = d + nc :  GOTO 1270
     IF  PEEK d > cx THEN  LET d = d + nc :  GOTO 1270
     LET dif = cx -  PEEK d :  IF dif > 2 THEN  LET d = d + nc :  GOTO 1270
     POKE d + 2 + dif , 1
     PRINT  AT  PEEK  ( d + 1 )  ,  (  PEEK d )  + dif ;  INK  PEEK  ( d + 5 )  ;  BRIGHT 0 ;  CHR$  ( dif +  PEEK  ( d + 6 )  ) 
     LET punt = punt + 1 :  GOSUB 930
     IF  PEEK  ( d + 2 )  = 0 OR  PEEK  ( d + 3 )  = 0 OR  PEEK  ( d + 4 )  = 0 THEN  RETURN 
     PRINT  AT  PEEK  ( d + 1 )  ,  PEEK d ;  INK 7 ; "___" ;  INK  PEEK  ( d + 5 )  ;  AT  PEEK  ( d + 1 )  + 1 ,  PEEK d ;  CHR$  PEEK  ( d + 6 )  ;  CHR$  ( 1 +  PEEK  ( d + 6 )  )  ;  CHR$  ( 2 +  PEEK  ( d + 6 )  ) 
     LET punt = punt + 4
     GOSUB 930
     POKE d + 1 ,  PEEK  ( d + 1 )  + 1 :  POKE d + 2 , 2
     LET hpend = hpend + 1
     RETURN 

     REM 1400 - Si hay hamburgesas cayendo, hace animacion.
1400 LET d = @hmapa
1410 IF  PEEK d = 0 THEN  RETURN 
1420 IF  PEEK  ( d + 2 )  <> 2 THEN  LET d = d + nc :  GOTO 1410
1430 IF  PEEK  ( d + 1 )  =  PEEK  ( d + 7 )  THEN  POKE d + 2 , 0 :  LET hpend = hpend - 1 :  LET hlistas = hlistas + 1 :  LET d = d + nc :  LET punt = punt + 25 :  GOSUB 930 :  GOTO 1410 : REM actualiza marcador y nivel completo
1440 PRINT  AT  PEEK  ( d + 1 )  ,  PEEK d ; "   "
1450 POKE d + 1 ,  PEEK  ( d + 1 )  + 1
1460 LET d1 =  PEEK  ( d + 1 ) 
1470 PRINT  AT  PEEK  ( d + 1 )  ,  PEEK d ;  INK  PEEK  ( d + 5 )  ;  CHR$  PEEK  ( d + 6 )  ;  CHR$  ( 1 +  PEEK  ( d + 6 )  )  ;  CHR$  ( 2 +  PEEK  ( d + 6 )  ) 
1480 IF  INT  ( d1 / 4 )  * 4 <> d1 THEN  LET d = d + nc :  GOTO 1410
1490 LET hpend = hpend - 1 :  POKE d + 2 , 0 :  POKE d + 3 , 0 :  POKE d + 4 , 0
1500 LET f = @hmapa
1510 IF  PEEK f = 0 THEN  GOTO 1550
1520 IF d = f OR  PEEK f <>  PEEK d OR  PEEK  ( f + 1 )  <>  PEEK  ( d + 1 )  THEN  LET f = f + nc :  GOTO 1510
1530 POKE f + 1 ,  PEEK  ( f + 1 )  + 1 :  POKE f + 2 , 2 :  POKE f + 3 , 0 :  POKE f + 4 , 0 :  LET hpend = hpend + 1
1540 PRINT  AT  PEEK  ( f + 1 )  ,  PEEK f ;  INK  PEEK  ( f + 5 )  ;  CHR$  PEEK  ( f + 6 )  ;  CHR$  ( 1 +  PEEK  ( f + 6 )  )  ;  CHR$  ( 2 +  PEEK  ( f + 6 )  ) 
1550 LET d = d + nc :  GOTO 1410

     REM 1560 - NIVEL COMPLETO
1560 PRINT  INK 7 ;  AT 9 , 6 ;  FLASH 1 ; "                  " ;  AT 10 , 6 ; " NIVEL COMPLETADO " ;  AT 11 , 6 ; "                  "
     BEEP 1 , 10
     PAUSE 0
1580 IF  INKEY$  <> "" THEN  GOTO 1580
     PAUSE 1 :  PAUSE 0
     LET hlistas = 0 
     LET hpend = 0
     LET nivel = nivel +1
     IF nivel >=6 then let nivel = 0   
     GOTO 30 : REM volvemos a dibujar el escenario desde 0.

     REM 9610 - RUTINA DE GENERACION DE UDG
9610 RESTORE 9640 
     FOR b = 0 TO (14 * 8) - 1 :  READ a :  POKE  USR "A" + b , a :  NEXT b
     RETURN 
9640 DATA 31 , 127 , 255 , 239 , 255 , 253 , 127 , 31 ,   255 , 255 , 183 , 255 , 254 , 247 , 255 , 255 
     DATA 248 , 254 , 223 , 251 , 255 , 239 , 254 , 248,  62 , 65 , 144 , 140 , 131 , 170 , 88 , 7  
     DATA 251 , 4 , 0 , 139 , 36 , 48 , 40 , 231 , 158 ,  98 , 1 , 137 , 70 , 129 , 65 , 190
     DATA 66 , 126 , 66 , 66 , 66 , 126 , 66 , 66 , 255 , 133 , 133 , 133 , 255 , 145 , 145 , 255
     DATA 126 , 255 , 255 , 66 , 60 , 60 , 36 , 66 , 66 , 60 , 255 , 60 , 60 , 60 , 66 , 66
     DATA 0 , 60 , 126 , 255 , 215 , 255 , 255 , 255 ,    207 , 199 , 199 , 199 , 231 , 126 , 124 , 90
     DATA 96 , 44 , 118 , 178 , 72 , 150 , 129 , 193 ,    230 , 116 , 252 , 252 , 120 , 120 , 132 , 132

9980 REM CLEAR 49999 : RANDOMIZE  :  LET nc = 8 :  LET hipunt = 0 :  GOSUB 9610 :  GOTO 850 : REM UDG y luego MENU PRINCIPAL.
9990 REM CLEAR  :  SAVE "BURGER" LINE 9980

hmapa: 
     asm
     defs 17,0
     end asm
	
