10 GO TO 490: REM \* 2003 Alvaro Alea Fenandez, \{i2}A\{i6}L\{i4}E\{i1}A\{i3}soft\{i7} , Distribuido bajo licencia GPL Version 2, Dedicado a Covadonga
20 LET a$=INKEY$:  IF a$="o"  AND l$(cx,cy)<>" "  THEN LET cx1=cx-1: GO TO 70
30 IF a$="p"  AND r$(cx,cy)<> " "  THEN LET cx1=cx+1: GO TO 70
40 IF a$="a"  AND d$(cx,cy) ="\g"  THEN LET cy1=cy+1: GO TO 70
50 IF a$="q"  AND u$(cx,cy)="\g"  THEN LET cy1=cy-1: GO TO 70
60 IF a$="t"  THEN GO TO 410
70 IF cx<>cx1 OR cy<>cy1  THEN GO SUB 410
80 IF hpend>0 THEN GO SUB 800
90 IF hlistas=6 THEN GO TO 1510
100 IF cx=px AND cy=py THEN GO TO 580
110 IF cx=mx AND cy=my THEN GO TO 580
120 LET r=RND
130 IF r<0.25  AND l$(px,py)<> " "  THEN LET px1=px-1: GO TO 180
140 IF r<0.5  AND r$(px,py) <> " " THEN LET px1=px+1: GO TO 180
150 IF r<0.75  AND d$(px,py) ="\g"  THEN LET py1=py+1: GO TO 180
160 IF u$(px,py) ="\g"  THEN LET py1=py-1: GO TO 180
170 IF px1=px AND py1=py THEN GO TO 120
180 GO SUB 340
190 IF RND<0.15 THEN GO TO 20
200 IF my>cy  AND u$(mx,my)="\g" THEN LET my1=my-1: GO TO 250
210 IF my<cy  AND d$(mx,my)="\g"  THEN LET my1=my+1: GO TO 250
220 IF cx<mx  AND l$(mx,my)<>" "  THEN LET mx1=mx-1: GO TO 250
230 IF r$(mx,my)<> " "  THEN LET mx1=mx+1: GO TO 250
240 LET mx1=mx1-1
250 GO SUB 270
260 GO TO 20
270 IF u$(mx,my-1)="\g" THEN PRINT INK 5;AT my-1,mx;"\g": GO TO 290
280 PRINT AT my-1,mx;" "
290 IF u$(mx,my)="\g" THEN PRINT INK 5;AT my,mx;"\g": GO TO 310
300 PRINT AT my,mx;" "
310 LET my=my1: LET mx=mx1
320 PRINT INK 6;AT my-1,mx;"\k";AT my,mx;"\l"
330 RETURN 
340 IF u$(px,py-1)="\g"  THEN PRINT INK 5;AT py-1,px;"\g": GO TO 360
350 PRINT AT py-1,px;" "
360 IF u$(px,py)="\g" THEN PRINT INK 5;AT py,px;"\g": GO TO 380
370 PRINT AT py,px;" "
380 LET py=py1: LET px=px1
390 PRINT INK 4;AT py-1,px;"\m";AT py,px;"\n"
400 RETURN 
410 IF u$(cx,cy)="\g" THEN PRINT INK 5;AT cy,cx;"\g": GO TO 430
420 PRINT AT cy,cx;" "
430 IF u$(cx,cy-1)="\g"  THEN PRINT INK 5;AT cy-1,cx;"\g": GO TO 450
440 PRINT AT cy-1,cx;" "
450 PRINT INK 7;AT cy1-1,cx1;"\i";AT cy1,cx1;"\j"
460 LET cx=cx1: LET cy=cy1
470 IF d$(cx,cy)="_" THEN GO SUB 660
480 RETURN 
490 CLEAR 49999: RANDOMIZE : LET nc=8: LET hipunt=0
500 BORDER 1: INK 7: PAPER 0: BRIGHT 1: FLASH 0: CLS : POKE 23658,0
510 PRINT AT 2,12;"BURGER";AT 3,13;"TIME"; FLASH 1;AT 18,1;" PULSE UNA TECLA PARA EMPEZAR "; FLASH 0;AT 20,1;"\* 2003 Alvaro Alea - "; INK 2;"A"; INK 6;"L"; INK 4;"E"; INK 1;"A"; INK 3;"soft"
520 PRINT AT 3,26;"\i";AT 4,26;"\j"
530 PRINT AT 2,5; INK 2;"\a\b\c";AT 4,5;"\a\b\c";AT 2,21;"\a\b\c";AT 4,21;"\a\b\c"; INK 4;AT 3,5;"\d\e\f";AT 3,21;"\d\e\f"; INK 3;AT 5,0;"\h\h\h\h\h\h\h\h\h\h\h\h\h\h\h\h\h\h\h\h\h\h\h\h\h\h\h\h\h\h\h\h"
540 PRINT AT 8,2;"Movimientos: O,P,Q,A"
550 PRINT AT 10,2;"Instrucciones: Pasa por en-     cima de los ingredientes        de las hamburgesas mientras     evitas al pimiento y la man-    cha de mostaza, El nivel        acaba cuando tengas todas       las Hamburgesas listas."
560 PAUSE 0
570 LET hlistas=0: LET hpend=0: LET punt=0:  LET vidas=3: LET nivel=0: GO TO 1050
580 LET vidas=vidas-1
590 BORDER 2: BEEP 1,0: BORDER 1
600 IF vidas=0 THEN GO TO 1470
610 GO SUB 1420
620 LET px1=px0: LET py1=py0: GO SUB 340
630 LET mx1=mx0: LET my1=my0: GO SUB 270
640 LET cx1=cx0: LET cy1=cy0: GO SUB 450
650 GO TO 20
660 LET d=51000
670 IF PEEK (d+1)=0 THEN RETURN 
680 IF PEEK (d+1)<>(cy+1) THEN LET d=d+nc: GO TO 670
690 IF PEEK d>cx THEN LET d=d+nc: GO TO 670
700 LET dif=cx-PEEK d: IF dif>2 THEN LET d=d+nc: GO TO 670
710 POKE d+2+dif,1
720 PRINT AT PEEK (d+1),(PEEK d)+dif; INK PEEK (d+5); BRIGHT 0;CHR$ (dif+PEEK (d+6))
730 LET punt=punt+1: GO SUB 960
740 IF PEEK (d+2)=0 OR PEEK (d+3)=0 OR PEEK (d+4)=0 THEN RETURN 
750 PRINT AT PEEK (d+1),PEEK d; INK 7;"___"; INK PEEK (d+5);AT PEEK (d+1)+1,PEEK d;CHR$ PEEK (d+6);CHR$ (1+PEEK (d+6));CHR$ (2+PEEK (d+6))
760 LET punt=punt+4: GO SUB 960
770 POKE d+1,PEEK (d+1)+1: POKE d+2,2
780 LET hpend=hpend+1
790 RETURN 
800 LET d=51000
810 IF PEEK d=0 THEN RETURN 
820 IF PEEK (d+2)<>2 THEN LET d=d+nc: GO TO 810
830 IF PEEK (d+1)=PEEK (d+7) THEN POKE d+2,0: LET hpend=hpend-1: LET hlistas=hlistas+1: LET d=d+nc: LET punt=punt+25: GO SUB 960: GO TO 810
840 PRINT AT PEEK (d+1),PEEK d;"   "
850 POKE d+1,PEEK (d+1)+1
860 LET d1=PEEK (d+1)
870 PRINT AT PEEK (d+1),PEEK d; INK PEEK (d+5);CHR$ PEEK (d+6);CHR$ (1+PEEK (d+6));CHR$ (2+PEEK (d+6))
880 IF INT (d1/4)*4<>d1 THEN LET d=d+nc: GO TO 810
890 LET hpend=hpend-1: POKE d+2,0: POKE d+3,0: POKE d+4,0
900 LET f=51000
910 IF PEEK f=0 THEN GO TO 950
920 IF d=f OR PEEK f<>PEEK d OR PEEK (f+1)<>PEEK (d+1) THEN LET f=f+nc: GO TO 910
930 POKE f+1,PEEK (f+1)+1: POKE f+2,2: POKE f+3,0: POKE f+4,0: LET hpend=hpend+1
940 PRINT AT PEEK (f+1),PEEK f; INK PEEK (f+5);CHR$ PEEK (f+6);CHR$ (1+PEEK (f+6));CHR$ (2+PEEK (f+6))
950 LET d=d+nc: GO TO 810
960 INK 7:  PRINT AT 0,0;"BURGER TIME SCORE:";
970 IF punt<1000 THEN PRINT "0";
980 IF punt<100 THEN PRINT "0";
990 IF punt<10  THEN PRINT "0";
1000 PRINT punt;" HISC:";
1010 IF hipunt<1000 THEN PRINT "0";
1020 IF hipunt<100 THEN PRINT "0";
1030 IF hipunt<10  THEN PRINT "0";
1040 PRINT hipunt: RETURN 
1050 CLS :  PRINT AT 0,0; "DIBUJANDO MAPA, ESPERE POR FAVOR"
1060 DIM u$(32,21): DIM d$(32,21): DIM l$(32,21): DIM r$(32,21)
1070 IF nivel=6 THEN LET nivel=0
1080 RESTORE 1360: RESTORE 1360+(nivel*10)
1090 READ A: IF A=0  THEN GO TO 1240
1100 IF A=1  THEN LET p$="\h": INK 3
1110 IF a=2 THEN LET p$="_": INK 7
1120 IF a=10  THEN LET p$="\g": INK 5
1130 READ n: READ x: READ y
1140 FOR B=1 TO n: PRINT AT y,x;p$
1150 LET u$(x,y)=p$
1160 IF y<=1 THEN GO TO 20
1170 LET d$(x,y-1)=p$
1180 IF x>1 THEN LET r$(x-1,y-1)=p$
1190 IF x<32 THEN LET l$(x+1,y-1)=p$
1200 IF A<10 THEN LET X=X+1
1210 IF A>=10  THEN LET Y=Y+1
1220 NEXT B
1230 GO TO 1090
1240 LET HAMB=0: LET dh=51000
1250 READ t
1260 IF t=0 THEN GO TO 1310
1270 LET co= 2: LET nu=144: LET s$="\a\b\c": GO SUB 1350
1280 LET co= 4: LET nu=147: LET s$="\d\e\f": GO SUB 1350
1290 LET co= 2: LET nu=144: LET s$="\a\b\c": GO SUB 1350
1300 LET hamb=hamb+1: GO TO 1250
1310 POKE dh,0: POKE dh+1,0
1320 READ py0,px0,my0,mx0,cx0,cy0
1330 LET py1=py0: LET px1=px0: LET my1=my0: LET mx1=mx0: LET cx1=cx0: LET cy1=cy0
1340 GO SUB 310: GO SUB 380: GO SUB 450: GO SUB 1420:  GO SUB 960: GO TO 20
1350 READ x,y: POKE dh,x: POKE dh+1,y: POKE dh+2,0: POKE dh+3,0: POKE dh+4,0: POKE dh+5,co: POKE dh+6,nu: POKE dh+7,t: LET t=t+1: LET dh=dh+nc: PRINT INK co;AT y,x;s$: RETURN 
1360 DATA  1,26,3,4,  1,26,3,8,  1,11,3,12,  1,11,18,12,  1,26,3,16,  10,12,5,4,  10,12,27,4,  10,8,12,4, 10,4,19,12, 2,3,8,19, 2,3,22,19, 2,3,22,4, 2,3,8,16, 2,3,8,12, 2,3,8,8, 2,3,22,16, 2,3,22,12, 2,3,22,8, 0, 17,8,8,8,12,8,16, 17,22,4,22,8,22,12,0,  15,28,15,3,15,15
1370 DATA 1,25,2,4, 1,20,2,8, 1,5,24,8, 1,27,2,12, 1,16,2,16, 10,4,3,4, 10,4,7,8, 10,4,3,12, 10,12,10,4, 10,12,16,4, 10,4,25,4, 10,4,27,8, 2,3,12,4, 2,3,12,8, 2,3,12,12, 2,3,12,16, 2,3,18,4, 2,3,18,8, 2,3,18,12, 0, 17,12,4,12,8,12,12, 13,18,4,18,8,18,12, 0,  11,28,15,3,16,15
1380 DATA  1,26,3,4,  1,26,3,8,  1,11,3,12,  1,11,18,12,  1,26,3,16,  10,12,5,4,  10,12,27,4,  10,8,12,4, 10,4,19,12, 2,3,8,19, 2,3,22,19, 2,3,22,4, 2,3,8,16, 2,3,8,12, 2,3,8,8, 2,3,22,16, 2,3,22,12, 2,3,22,8, 0, 17,8,8,8,12,8,16, 17,22,4,22,8,22,12,0,  15,28,15,3,15,15
1390 DATA 1,25,2,4, 1,20,2,8, 1,5,24,8, 1,27,2,12, 1,16,2,16, 10,4,3,4, 10,4,7,8, 10,4,3,12, 10,12,10,4, 10,12,16,4, 10,4,25,4, 10,4,27,8, 2,3,12,4, 2,3,12,8, 2,3,12,12, 2,3,12,16, 2,3,18,4, 2,3,18,8, 2,3,18,12, 0, 17,12,4,12,8,12,12, 13,18,4,18,8,18,12, 0,  11,28,15,3,16,15
1400 DATA  1,26,3,4,  1,26,3,8,  1,11,3,12,  1,11,18,12,  1,26,3,16,  10,12,5,4,  10,12,27,4,  10,8,12,4, 10,4,19,12, 2,3,8,19, 2,3,22,19, 2,3,22,4, 2,3,8,16, 2,3,8,12, 2,3,8,8, 2,3,22,16, 2,3,22,12, 2,3,22,8, 0, 17,8,8,8,12,8,16, 17,22,4,22,8,22,12,0,  15,28,15,3,15,15
1410 DATA 1,25,2,4, 1,20,2,8, 1,5,24,8, 1,27,2,12, 1,16,2,16, 10,4,3,4, 10,4,7,8, 10,4,3,12, 10,12,10,4, 10,12,16,4, 10,4,25,4, 10,4,27,8, 2,3,12,4, 2,3,12,8, 2,3,12,12, 2,3,12,16, 2,3,18,4, 2,3,18,8, 2,3,18,12, 0, 17,12,4,12,8,12,12, 13,18,4,18,8,18,12, 0,  11,28,15,3,16,15
1420 LET A=20-(3*VIDAS)
1430 FOR B=5 TO 20 STEP 3
1440 PRINT INK 7;AT B,0;" ";AT B+1,0;" "
1450 IF B>A THEN PRINT INK 7;AT B,0;"\i";AT B+1,0;"\j"
1460 NEXT B: RETURN 
1470 PRINT INK 7;AT 9,10; FLASH 1;"           ";AT 10,10;" GAME OVER ";AT 11,10;"           "
1480 IF hipunt<punt THEN LET hipunt=punt
1490 IF INKEY$<>"" THEN GO TO 410
1500 PAUSE 1: PAUSE 0: GO TO 500
1510 IF nivel = 5 THEN PRINT INK 7;AT 9,6; FLASH 1;"                   ";AT 10,6;" SEMANA COMPLETADA ";AT 11,6;" 1 DIA DE DESCANSO ";AT 12,6;"                   "
1520 IF nivel<>5 THEN PRINT INK 7;AT 9,6; FLASH 1;"                  ";AT 10,6;" NIVEL COMPLETADO ";AT 11,6;"                  "
1530 BEEP 1,10: PAUSE 0
1540 IF INKEY$<>"" THEN GO TO 1540
1550 PAUSE 1: PAUSE 0
1560 LET hlistas=0: LET hpend=0: LET nivel=nivel+1: GO TO 1050
1570 RESTORE 1600
1580 FOR b=0 TO 14*8-1: READ a: POKE USR "A"+b,a: NEXT b
1590 GO TO 490
1600 DATA 31,127,255,239,255,253,127,31,255,255,183,255,254,247,255,255,248,254,223,251,255,239,254,248
1610 DATA 62,65,144,140,131,170,88,7,251,4,0,139,36,48,40,231,158,98,1,137,70,129,65,190
1620 DATA 66,126,66,66,66,126,66,66,255,133,133,133,255,145,145,255
1630 DATA 126,255,255,66,60,60,36,66,66,60,255,60,60,60,66,66
1640 DATA 0,60,126,255,215,255,255,255,207,199,199,199,231,126,124,90
1650 DATA 96,44,118,178,72,150,129,193,230,116,252,252,120,120,132,132
9999 CLEAR : SAVE "BURGER" LINE 1570

