ABOUT

Generate labyrinth consists of digits and try to find a path through it
or seek help of computer.

VARIABLES

B()   - array of labyrinth nodes
S()   - array of directions in labyrinth to select
X,Y   - coordinates of active node
SX,SY - coordinates of the start node
EX,EY - coordinates of the end node
SC    - the length of the happy path through labyrinth
S     - contains value (digit) of the current node
K,I,C - auxiliary counter variables
H$,V$ - auxiliary variables

PROGRAM CODE

Initializing variables:
-------------------------------------------------------------------
0 CLS:PALETB 0,30,39,50,60:DIM B(9,9),S(3):S=-112

Drawing the game board:
-------------------------------------------------------------------
1 LOCATE 0,0:PRINT CHR$(222):LOCATE 20,20:PRINT CHR$(225):
  H$=CHR$(227):V$=CHR$(226)
2 FOR C=1 TO 19:
  LOCATE C,0:PRINT H$:LOCATE 0,C:PRINT V$:
  LOCATE 20-C,20:PRINT H$:LOCATE 20,20-C:PRINT V$:
  NEXT
3 LOCATE 0,20:PRINT CHR$(224):LOCATE 20,0:PRINT CHR$(223)
4 FOR C=1 TO 19:FOR I=2 TO 18 STEP 2
5 K=1-K:ON K+1 GOTO 6,7
6 LOCATE I,C:PRINT V$:LOCATE C,I:PRINT H$:GOTO 8
7 LOCATE 20-I,20-C:PRINT V$:LOCATE 20-C,20-I:PRINT H$
8 NEXT:NEXT
9 LOCATE 21,1:PRINT "CONTROL":
  LOCATE 21,3:PRINT "UP":
  LOCATE 21,4:PRINT "DOWN":
  LOCATE 21,5:PRINT "LEFT":
  LOCATE 21,6:PRINT "RIGHT":
  LOCATE 21,8:PRINT "N-NEW":
  LOCATE 21,9:PRINT "R-RAND":
  LOCATE 21,10:PRINT "P-SHOW":
  LOCATE 23,11:PRINT "PATH":
  GOTO 500

Labyrinth generating:
-------------------------------------------------------------------
10 GOSUB 450
12 SX=RND(10):SY=RND(10):X=SX:Y=SY:SC=RND(11)+10

Generating of the happy path:
-----------------------------
13 FOR I=0 TO SC
14 K=15:H$=STR$(50*I/SC)+"%":
   LOCATE 15,22:PRINT RIGHT$(H$,LEN(H$)-1) 
15 S=RND(9)+1:C=0

20 IF X+S>9 GOTO 25
21 IF B(Y,X+S)<>0 GOTO 15
22 S(C)=1:C=C+1
25 IF X-S<0 GOTO 30
26 IF B(Y,X-S)<>0 GOTO 15
27 S(C)=2:C=C+1
30 IF Y+S>9 GOTO 35
31 IF B(Y+S,X)<>0 GOTO 15
32 S(C)=3:C=C+1
35 IF Y-S<0 GOTO 40
36 IF B(Y-S,X)<>0 GOTO 15
37 S(C)=4:C=C+1
40 IF C>0 GOTO 45
41 K=K-1:IF K=0 I=SC:NEXT:GOTO 10
42 GOTO 15

45 IF X+S<=9 B(Y,X+S)=10
50 IF X-S>=0 B(Y,X-S)=10
55 IF Y+S<=9 B(Y+S,X)=10
60 IF Y-S>=0 B(Y-S,X)=10
65 B(Y,X)=-S:PX=X:PY=Y

70 ON S(RND(C)) GOTO 75,80,85,90
75 X=X+S:GOTO 95
80 X=X-S:GOTO 95
85 Y=Y+S:GOTO 95
90 Y=Y-S
95 B(Y,X)=0
100 NEXT
105 EX=X:EY=Y:B(Y,X)=-55

Generating the rest of the labyrinth:
-------------------------------------
110 FOR Y=0 TO 9:FOR X=0 TO 9
111 H$=STR$(50+50*(10*Y+X)/99)+"%":
    LOCATE 15,22:PRINT RIGHT$(H$,LEN(H$)-1)
115 K=15:IF B(Y,X)<0 GOTO 155
120 S=RND(9)+1:C=0
125 IF X+S<=9 C=C+1:IF B(Y,X+S)<0 GOTO 120
130 IF X-S>=0 C=C+1:IF B(Y,X-S)<0 GOTO 120
135 IF Y+S<=9 C=C+1:IF B(Y+S,X)<0 GOTO 120
140 IF Y-S>=0 C=C+1:IF B(Y-S,X)<0 GOTO 120
145 IF C>0 GOTO 150
146 K=K-1:IF K=0 S=0:GOTO 150
147 GOTO 120
150 B(Y,X)=S
155 NEXT:NEXT

Drawing labyrinth nodes:
--------------------------
160 FOR Y=0 TO 9:FOR X=0 TO 9:
    LOCATE 2*X+1,2*Y+1:PRINT CHR$(144+ABS(B(Y,X))):
    NEXT:NEXT
165 X=SX:Y=SY:LOCATE 4,22:PRINT "FIND THE PATH    ":
170 RETURN

Drawing the path through labyrinth:
-------------------------------------------------------------------
200 FOR I=0 TO 9:FOR C=0 TO 9
210 IF B(I,C)<0 IF B(I,C)>-10
    LOCATE 2*C+1,2*I+1:PRINT CHR$(48+ABS(B(I,C)))
215 NEXT:NEXT
220 IF ASC(INKEY$)=0 GOTO 220
225 RETURN

Generating the simple random labyrinth:
-------------------------------------------------------------------
300 GOSUB 450

Generating the happy path:
--------------------------
305 SX=RND(10):SY=RND(10):X=SX:Y=SY:SC=RND(18)+3
310 FOR I=0 TO SC
315 H$=STR$(50*I/SC)+"%":
    LOCATE 15,22:PRINT RIGHT$(H$,LEN(H$)-1)
320 S=RND(9)+1:B(Y,X)=-S
325 ON RND(4)+1 GOTO 330,335,340,345
330 IF X+S<=9 IF B(Y,X+S)=0 X=X+S:GOTO 355 
335 IF X-S>=0 IF B(Y,X-S)=0 X=X-S:GOTO 355
340 IF Y+S<=9 IF B(Y+S,X)=0 Y=Y+S:GOTO 355
345 IF Y-S>=0 IF B(Y-S,X)=0 Y=Y-S:GOTO 355
350 GOTO 320
355 NEXT
360 EX=X:EY=Y:B(EY,EX)=-55

Generating the rest of the labyrinth:
-------------------------------------
365 FOR Y=0 TO 9:FOR X=0 TO 9
370 H$=STR$(50+50*(10*Y+X)/99)+"%":
    LOCATE 15,22:PRINT RIGHT$(H$,LEN(H$)-1)
375 IF B(Y,X)<0 GOTO 395
380 S=0:IF RND(20)>0 S=RND(9)+1
385 IF X-S<0 IF X+S>9 IF Y-S<0 IF Y+S>9 GOTO 380
390 B(Y,X)=S
395 NEXT:NEXT
400 GOTO 160

Labyrinth cleaning:
-------------------------------------------------------------------
450 LOCATE 4,22:PRINT "GENERATING:0% "
455 FOR Y=0 TO 9:FOR X=0 TO 9:B(Y,X)=0:NEXT:NEXT
460 RETURN

Processing of key press:
-------------------------------------------------------------------
500 K=ASC(INKEY$)
505 IF K=78 GOSUB 10:GOTO 550
510 IF K=82 GOSUB 300:GOTO 550
520 IF K=80 C=144:GOSUB 605:GOSUB 200:GOTO 550
525 IF K=28 IF X+S<=9 C=144:GOSUB 605:X=X+S:GOTO 550
530 IF K=29 IF X-S>=0 C=144:GOSUB 605:X=X-S:GOTO 550
535 IF K=31 IF Y+S<=9 C=144:GOSUB 605:Y=Y+S:GOTO 550
540 IF K=30 IF Y-S>=0 C=144:GOSUB 605:Y=Y-S:GOTO 550
545 LOCATE 2*X+1,2*Y+1:PRINT " ":GOSUB 625:GOTO 500
550 S=ABS(B(Y,X)):C=48:GOSUB 605
555 IF X=EX IF Y=EY LOCATE 4,22:PRINT "   YOU WIN   "
560 GOTO 500

Highlighting available transitions:
-------------------------------------------------------------------
605 IF X+S<=9 IF B(Y,X+S)>-55 
    LOCATE 2*(X+S)+1,2*Y+1:PRINT CHR$(C+ABS(B(Y,X+S)))
610 IF X-S>=0 IF B(Y,X-S)>-55
    LOCATE 2*(X-S)+1,2*Y+1:PRINT CHR$(C+ABS(B(Y,X-S)))
615 IF Y+S<=9 IF B(Y+S,X)>-55
    LOCATE 2*X+1,2*(Y+S)+1:PRINT CHR$(C+ABS(B(Y+S,X)))
620 IF Y-S>=0 IF B(Y-S,X)>-55
    LOCATE 2*X+1,2*(Y-S)+1:PRINT CHR$(C+ABS(B(Y-S,X)))
625 LOCATE 2*X+1,2*Y+1:PRINT CHR$(144+S)
630 RETURN