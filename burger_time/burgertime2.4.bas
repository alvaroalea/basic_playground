10 REM \c 2003 Alvaro Alea Fenandez, ALEAsoft , Distribuido bajo licencia GPL Version 2        Dedicado a Covadonga

29 REM 30 imprimir escenario e incializar variables
30 CLS  :  PRINT  AT 0 , 0 ; "DIBUJANDO MAPA, ESPERE POR FAVOR"
39 REM DATA FORMAT: elemento (vertical si >=10, si =0 fin pintado), numero de repeticiones, x, y
40 DATA 1 , 26 , 3 , 4 , 1 , 26 , 3 , 8 , 1 , 11 , 3 , 12 , 1 , 11 , 18 , 12 , 1 , 26 , 3 , 16 , 10 , 12 , 5 , 4 , 10 , 12 , 27 , 4 , 10 , 8 , 12 , 4 , 10 , 4 , 19 , 12
50 DATA 2 , 3 , 8 , 19 , 2 , 3 , 22 , 19 , 2 , 3 , 22 , 4 , 2 , 3 , 8 , 16 , 2 , 3 , 8 , 12 , 2 , 3 , 8 , 8 , 2 , 3 , 22 , 16 , 2 , 3 , 22 , 12 , 2 , 3 , 22 , 8 , 0
60 DATA 17 , 8 , 8 , 8 , 12 , 8 , 16 , 17 , 22 , 4 , 22 , 8 , 22 , 12 , 0
70 FOR B = 0 TO 32 * 20 :  POKE 5E4 + B , 0 :  NEXT B
80 RESTORE 40
90 READ A
100 IF A = 0 THEN  GOTO 210
110 IF A = 1 THEN  LET p$ = "\udg(H)" :  INK 3
120 IF a = 2 THEN  LET p$ = "_" :  INK 7
130 IF a = 10 THEN  LET p$ = "\udg(G)" :  INK 5
140 READ n :  READ x :  READ y
150 FOR B = 1 TO n :  PRINT  AT Y , X ; p$
160 POKE 5E4 +  ( 32 * Y )  + X , A
170 IF A < 10 THEN  LET X = X + 1
180 IF A >= 10 THEN  LET Y = Y + 1 
190 NEXT B
200 GOTO 90
210 GOSUB 1110 : REM Imprime las hamburgesas
220 LET py1 = 15 :  LET px1 = 28 :  GOSUB 640 : REM Inicializa e imprime el bicho P (medio)
230 LET my1 = 15 :  LET mx1 = 3 :  GOSUB 570 : REM Inicializa e imprime el bicho M (medio)
240 LET cx1 = 15 :  LET cy1 = 15 :  GOSUB 810 : REM Inicializa e imprime el Jugador (medio)
250 GOSUB 670 : REM imprimir vidas
260 GOSUB 930 : REM imprimir marcador

269 REM 270 - INICIO BUCLE JUEGO
270 LET a$ =  INKEY$ 
280 IF a$ = "o" AND  PEEK  ( 5e4 +  ( 32 *  ( cy + 1 )  )  + cx - 1 )  <> 0 THEN  LET cx1 = cx - 1 :  GOTO 330
290 IF a$ = "p" AND  PEEK  ( 5e4 +  ( 32 *  ( cy + 1 )  )  + cx + 1 )  <> 0 THEN  LET cx1 = cx + 1 :  GOTO 330
300 IF a$ = "a" AND  PEEK  ( 5e4 +  ( 32 *  ( cy + 1 )  )  + cx )  = 10 THEN  LET cy1 = cy + 1 :  GOTO 330
310 IF a$ = "q" AND  PEEK  ( 5e4 +  ( 32 *  ( cy )  )  + cx )  = 10 THEN  LET cy1 = cy - 1 :  GOTO 330
320 IF a$ = "t" THEN  GOTO 730
330 IF cx <> cx1 OR cy <> cy1 THEN  GOSUB 770 : REM si se movio imprime al jugador
340 IF hpend > 0 THEN  GOSUB 1400 : REM si hamb. cayendo, actualiza
350 IF hlistas = 6 THEN  GOTO 1560 : REM todas abajo fin nivel.
360 IF cx = px AND cy = py THEN  GOTO 1030 : REM muerte por P
370 IF cx = mx AND cy = my THEN  GOTO 1030 : REM muerte por M

379 REM P se mueve al azar
380 LET r =  RND 
390 IF r < 0.25 AND  PEEK  ( 5e4 +  ( 32 *  ( py + 1 )  )  + px - 1 )  <> 0 THEN  LET px1 = px - 1 :  GOTO 440
400 IF r < 0.5 AND  PEEK  ( 5e4 +  ( 32 *  ( py + 1 )  )  + px + 1 )  <> 0 THEN  LET px1 = px + 1 :  GOTO 440
410 IF r < 0.75 AND  PEEK  ( 5e4 +  ( 32 *  ( py + 1 )  )  + px )  = 10 THEN  LET py1 = py + 1 :  GOTO 440
420 IF  PEEK  ( 5e4 +  ( 32 *  ( py )  )  + px )  = 10 THEN  LET py1 = py - 1 :  GOTO 440
430 IF px1 = px AND py1 = py THEN  GOTO 380
440 GOSUB 600 : REM Imprimir bicho P

449 REM M no siempre se mueve, pero si lo hace, persigue al jugador
450 IF  RND  < 0.15 THEN  GOTO 270
460 IF my > cy AND  PEEK  ( 5E4 +  ( 32 *  ( my )  )  + mx )  = 10 THEN  LET my1 = my - 1 :  GOTO 510
470 IF my < cy AND  PEEK  ( 5E4 +  ( 32 *  ( my + 1 )  )  + mx )  = 10 THEN  LET my1 = my + 1 :  GOTO 510
480 IF cx < mx AND  PEEK  ( 5E4 +  ( 32 *  ( my + 1 )  )  + mx - 1 )  <> 0 THEN  LET mx1 = mx - 1 :  GOTO 510
490 IF  PEEK  ( 5E4 +  ( 32 *  ( my + 1 )  )  + mx + 1 )  <> 0 THEN  LET mx1 = mx + 1 :  GOTO 510
500 LET mx1 = mx1 - 1
510 GOSUB 530 : REM Imprimir bicho M

520 GOTO 270 : REM inicio bucle juego.

529 REM 530 - RUTINA IMPRIMIR el bicho M
530 IF  PEEK  ( 5E4 +  ( 32 *  ( my - 1 )  )  + mx )  = 10 THEN  PRINT  INK 5 ;  AT my - 1 , mx ; "\udg(G)" :  GOTO 550
540 PRINT  AT my - 1 , mx ; " "
550 IF  PEEK  ( 5E4 +  ( 32 *  ( my )  )  + mx )  = 10 THEN  PRINT  INK 5 ;  AT my , mx ; "\udg(G)" :  GOTO 570
560 PRINT  AT my , mx ; " "
570 LET my = my1 :  LET mx = mx1
580 PRINT  INK 6 ;  AT my - 1 , mx ; "\udg(K)" ;  AT my , mx ; "\udg(L)"
590 RETURN

599 REM 600 - RUTINA IMPRIMIR el bicho P 
600 IF  PEEK  ( 50000 +  ( 32 *  ( py - 1 )  )  + px )  = 10 THEN  PRINT  INK 5 ;  AT py - 1 , px ; "\udg(G)" :  GOTO 620
610 PRINT  AT py - 1 , px ; " "
620 IF  PEEK  ( 50000 +  ( 32 *  ( py )  )  + px )  = 10 THEN  PRINT  INK 5 ;  AT py , px ; "\udg(G)" :  GOTO 640
630 PRINT  AT py , px ; " "
640 LET py = py1 :  LET px = px1
650 PRINT  INK 4 ;  AT py - 1 , px ; "\udg(M)" ;  AT py , px ; "\udg(N)"
660 RETURN

669 REM 670 - RUTINA IMPRIMIR VIDAS 
670 LET A = 20 -  ( 3 * VIDAS ) 
680 FOR B = 5 TO 20 STEP 3
690 PRINT  INK 7 ;  AT B , 0 ; " " ;  AT B + 1 , 0 ; " "
700 IF B > A THEN  PRINT  INK 7 ;  AT B , 0 ; "\udg(I)" ;  AT B + 1 , 0 ; "\udg(J)"
710 NEXT B
720 RETURN

729 REM 730 - RUTINA DE GAME OVER 
730 PRINT  INK 7 ;  AT 9 , 10 ;  FLASH 1 ; "           " ;  AT 10 , 10 ; " GAME OVER " ;  AT 11 , 10 ; "           "
740 IF hipunt < punt THEN  LET hipunt = punt
750 IF  INKEY$  <> "" THEN  GOTO 750
760 PAUSE 1 :  PAUSE 0 :  GOTO 850

769 REM 770 - RUTINA IMPRIMIR al jugador
770 IF  PEEK  ( 50000 +  ( 32 * cy )  + cx )  = 10 THEN  PRINT  INK 5 ;  AT cy , cx ; "\udg(G)" :  GOTO 790
780 PRINT  AT cy , cx ; " "
790 IF  PEEK  ( 50000 +  ( 32 *  ( cy - 1 )  )  + cx )  = 10 THEN  PRINT  INK 5 ;  AT cy - 1 , cx ; "\udg(G)" :  GOTO 810
800 PRINT  AT cy - 1 , cx ; " "
810 PRINT  INK 7 ;  AT cy1 - 1 , cx1 ; "\udg(I)" ;  AT cy1 , cx1 ; "\udg(J)"
820 LET cx = cx1 :  LET cy = cy1
830 IF  PEEK  ( 50000 +  ( 32 *  ( 1 + cy )  )  + cx )  = 2 THEN  GOSUB 1260
840 RETURN 

849 REM 850 - MENU PRINCIPAL
850 BORDER 1 :  INK 7 :  PAPER 0 :  BRIGHT 1 :  FLASH 0 :  CLS 
860 PRINT  AT 2 , 12 ; "BURGER" ;  AT 3 , 13 ; "TIME" ;  FLASH 1 ;  AT 18 , 1 ; " PULSE UNA TECLA PARA EMPEZAR " ;  FLASH 0 ;  AT 20 , 1 ; "\c 2003 Alvaro Alea - " ;  INK 2 ; "A" ;  INK 6 ; "L" ;  INK 4 ; "E" ;  INK 1 ; "A" ;  INK 3 ; "soft"
870 PRINT  AT 3 , 26 ; "\udg(I)" ;  AT 4 , 26 ; "\udg(J)"
880 PRINT  AT 2 , 5 ;  INK 2 ; "\udg(ABC)" ;  AT 4 , 5 ; "\udg(ABC)" ;  AT 2 , 21 ; "\udg(ABC)" ;  AT 4 , 21 ; "\udg(ABC)" ;  INK 4 ;  AT 3 , 5 ; "\udg(DEF)" ;  AT 3 , 21 ; "\udg(DEF)" ;  INK 3 ;  AT 5 , 0 ; "\udg(HHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHH)"
890 PRINT  AT 8 , 2 ; "Movimientos: O,P,Q,A"
900 PRINT  AT 10 , 2 ; "Instrucciones: Pasa por en-     cima de los ingredientes        de las hamburgesas mientras     evitas al pimiento y la man-    cha de mostaza, El nivel        acaba cuando tengas todas       las Hamburgesas listas."
910 PAUSE 0
920 LET hlistas = 0 :  LET hpend = 0 :  LET punt = 0 :  LET vidas = 3 :  GOTO 30

929 REM 930 - RUTINA DE IMPRIMIR MARCADOR
930 INK 7 :  PRINT  AT 0 , 0 ; "BURGER TIME SCORE:" ; 
940 IF punt < 1000 THEN  PRINT "0" ; 
950 IF punt < 100 THEN  PRINT "0" ; 
960 IF punt < 10 THEN  PRINT "0" ; 
970 PRINT punt ; " HISC:" ; 
980 IF hipunt < 1000 THEN  PRINT "0" ; 
990 IF hipunt < 100 THEN  PRINT "0" ; 
1000 IF hipunt < 10 THEN  PRINT "0" ; 
1010 PRINT hipunt
1020 RETURN

1029 REM 1030 - RUTINA DE VIDA MENOS 
1030 LET vidas = vidas - 1
1040 BORDER 2 :  BEEP 1 , 0 :  BORDER 1
1050 IF vidas = 0 THEN  GOTO 730 : REM GOTO RUTINA GAME OVER
1060 GOSUB 670
1070 LET px1 = 28 :  LET py1 = 15 :  GOSUB 600
1080 LET mx1 = 3 :  LET my1 = 15 :  GOSUB 530
1090 LET cx1 = 15 :  LET cy1 = 15 :  GOSUB 810
1100 GOTO 270

1109 REM 1110 - RUTINA IMPRESION HAMBURGESAS
1110 LET HAMB = 0 :  LET dh = 51e3
1120 READ t
1130 IF t = 0 THEN  GOTO 1240
1140 READ x , y
1150 POKE dh , x :  POKE dh + 1 , y :  POKE dh + 2 , 0 :  POKE dh + 3 , 0 :  POKE dh + 4 , 0 :  POKE dh + 5 , 2 :  POKE dh + 6 , 144 :  POKE dh + 7 , t :  LET dh = dh + nc
1160 PRINT  INK 2 ;  AT y , x ; "\udg(ABC)"
1170 READ x , y
1180 POKE dh , x :  POKE dh + 1 , y :  POKE dh + 2 , 0 :  POKE dh + 3 , 0 :  POKE dh + 4 , 0 :  POKE dh + 5 , 4 :  POKE dh + 6 , 147 :  POKE dh + 7 , t + 1 :  LET dh = dh + nc
1190 PRINT  INK 4 ;  AT y , x ; "\udg(DEF)"
1200 READ x , y
1210 POKE dh , x :  POKE dh + 1 , y :  POKE dh + 2 , 0 :  POKE dh + 3 , 0 :  POKE dh + 4 , 0 :  POKE dh + 5 , 2 :  POKE dh + 6 , 144 :  POKE dh + 7 , t + 2 :  LET dh = dh + nc
1220 PRINT  INK 2 ;  AT y , x ; "\udg(ABC)"
1230 LET hamb = hamb + 1 :  GOTO 1120
1240 POKE dh , 0 :  POKE dh + 1 , 0
1250 RETURN

1260 LET d = 51e3
1270 IF  PEEK  ( d + 1 )  = 0 THEN  RETURN 
1280 IF  PEEK  ( d + 1 )  <>  ( cy + 1 )  THEN  LET d = d + nc :  GOTO 1270
1290 IF  PEEK d > cx THEN  LET d = d + nc :  GOTO 1270
1300 LET dif = cx -  PEEK d :  IF dif > 2 THEN  LET d = d + nc :  GOTO 1270
1310 POKE d + 2 + dif , 1
1320 PRINT  AT  PEEK  ( d + 1 )  ,  (  PEEK d )  + dif ;  INK  PEEK  ( d + 5 )  ;  BRIGHT 0 ;  CHR$  ( dif +  PEEK  ( d + 6 )  ) 
1330 LET punt = punt + 1 :  GOSUB 930
1340 IF  PEEK  ( d + 2 )  = 0 OR  PEEK  ( d + 3 )  = 0 OR  PEEK  ( d + 4 )  = 0 THEN  RETURN 
1350 PRINT  AT  PEEK  ( d + 1 )  ,  PEEK d ;  INK 7 ; "___" ;  INK  PEEK  ( d + 5 )  ;  AT  PEEK  ( d + 1 )  + 1 ,  PEEK d ;  CHR$  PEEK  ( d + 6 )  ;  CHR$  ( 1 +  PEEK  ( d + 6 )  )  ;  CHR$  ( 2 +  PEEK  ( d + 6 )  ) 
1360 LET punt = punt + 4 :  GOSUB 930
1370 POKE d + 1 ,  PEEK  ( d + 1 )  + 1 :  POKE d + 2 , 2
1380 LET hpend = hpend + 1
1390 RETURN 

1399 REM 1400 - Si hay hamburgesas cayendo, hace animacion.
1400 LET d = 51000
1410 IF  PEEK d = 0 THEN  RETURN 
1420 IF  PEEK  ( d + 2 )  <> 2 THEN  LET d = d + nc :  GOTO 1410
1430 IF  PEEK  ( d + 1 )  =  PEEK  ( d + 7 )  THEN  POKE d + 2 , 0 :  LET hpend = hpend - 1 :  LET hlistas = hlistas + 1 :  LET d = d + nc :  LET punt = punt + 25 :  GOSUB 930 :  GOTO 1410 : REM actualiza marcador y nivel completo
1440 PRINT  AT  PEEK  ( d + 1 )  ,  PEEK d ; "   "
1450 POKE d + 1 ,  PEEK  ( d + 1 )  + 1
1460 LET d1 =  PEEK  ( d + 1 ) 
1470 PRINT  AT  PEEK  ( d + 1 )  ,  PEEK d ;  INK  PEEK  ( d + 5 )  ;  CHR$  PEEK  ( d + 6 )  ;  CHR$  ( 1 +  PEEK  ( d + 6 )  )  ;  CHR$  ( 2 +  PEEK  ( d + 6 )  ) 
1480 IF  INT  ( d1 / 4 )  * 4 <> d1 THEN  LET d = d + nc :  GOTO 1410
1490 LET hpend = hpend - 1 :  POKE d + 2 , 0 :  POKE d + 3 , 0 :  POKE d + 4 , 0
1500 LET f = 51000
1510 IF  PEEK f = 0 THEN  GOTO 1550
1520 IF d = f OR  PEEK f <>  PEEK d OR  PEEK  ( f + 1 )  <>  PEEK  ( d + 1 )  THEN  LET f = f + nc :  GOTO 1510
1530 POKE f + 1 ,  PEEK  ( f + 1 )  + 1 :  POKE f + 2 , 2 :  POKE f + 3 , 0 :  POKE f + 4 , 0 :  LET hpend = hpend + 1
1540 PRINT  AT  PEEK  ( f + 1 )  ,  PEEK f ;  INK  PEEK  ( f + 5 )  ;  CHR$  PEEK  ( f + 6 )  ;  CHR$  ( 1 +  PEEK  ( f + 6 )  )  ;  CHR$  ( 2 +  PEEK  ( f + 6 )  ) 
1550 LET d = d + nc :  GOTO 1410

1559 REM 1560 - NIVEL COMPLETO
1560 PRINT  INK 7 ;  AT 9 , 6 ;  FLASH 1 ; "                  " ;  AT 10 , 6 ; " NIVEL COMPLETADO " ;  AT 11 , 6 ; "                  "
1570 BEEP 1 , 10 :  PAUSE 0
1580 IF  INKEY$  <> "" THEN  GOTO 1580
1590 PAUSE 1 :  PAUSE 0
1600 LET hlistas = 0 :  LET hpend = 0 :  GOTO 30 : REM volvemos a dibujar el escenario desde 0.

9609 REM 9610 - RUTINA DE GENERACION DE UDG
9610 RESTORE 9640 
9620 FOR b = 0 TO 14 * 8 - 1 :  READ a :  POKE  USR "A" + b , a :  NEXT b
9630 RETURN 
9640 DATA 31 , 127 , 255 , 239 , 255 , 253 , 127 , 31 , 255 , 255 , 183 , 255 , 254 , 247 , 255 , 255 , 248 , 254 , 223 , 251 , 255 , 239 , 254 , 248
9650 DATA 62 , 65 , 144 , 140 , 131 , 170 , 88 , 7 , 251 , 4 , 0 , 139 , 36 , 48 , 40 , 231 , 158 , 98 , 1 , 137 , 70 , 129 , 65 , 190
9660 DATA 66 , 126 , 66 , 66 , 66 , 126 , 66 , 66 , 255 , 133 , 133 , 133 , 255 , 145 , 145 , 255
9670 DATA 126 , 255 , 255 , 66 , 60 , 60 , 36 , 66 , 66 , 60 , 255 , 60 , 60 , 60 , 66 , 66
9680 DATA 0 , 60 , 126 , 255 , 215 , 255 , 255 , 255 , 207 , 199 , 199 , 199 , 231 , 126 , 124 , 90
9690 DATA 96 , 44 , 118 , 178 , 72 , 150 , 129 , 193 , 230 , 116 , 252 , 252 , 120 , 120 , 132 , 132

9980 CLEAR 49999 :  RANDOMIZE  :  LET nc = 8 :  LET hipunt = 0 :  GOSUB 9610 :  GOTO 850 : REM UDG y luego MENU PRINCIPAL.
9990 CLEAR  :  SAVE "BURGER" LINE 9980
