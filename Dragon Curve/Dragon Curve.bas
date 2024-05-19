ABOUT

Drawing of the Dragon Curve.

VARIABLES

P     - curve order (from 1 to 8)
V     - curve view (from 1 to 6)
N     - 2^P
X,Y   - coordinates of the current curve element
XI,YI - coordinate increments
T,G   - determines view of a curve element

PROGRAM CODE

Setting the curve order and view: 
-------------------------------------------------------------------
10 CLS
20 INPUT P,V:CLS
30 IF P<1 P=1
40 IF P>8 P=8
44 IF V<1 V=1
45 IF V>6 V=6

Calculating N=2^P:
-------------------------------------------------------------------
50 N=1
60 FOR I=1 TO P
70 N=2*N
80 NEXT

Variables initialization:
-------------------------------------------------------------------
90 G=1
91 ON V GOTO 92,93,94,95,96,97
92 C1=222:C2=221:GOTO 100
93 C1=222:C2=226:GOTO 100
94 C1=222:C2=227:GOTO 100
95 C1=239:C2=232:GOTO 100
96 C1=239:C2=238:GOTO 100
97 C1=239:C2=237
100 X=12+P:Y=13:XI=-1:YI=0
110 P=1:T=0:H=N/2
120 DIM S(127)

The main loop of the drawing:
-------------------------------------------------------------------
150 FOR I=0 TO N-2
160 IF I MOD 2=0 GOTO 190
170 T=S((I+1)/2-1)
180 GOTO 200
190 T=P:P=1-P
200 IF I<H S(I)=T
210 GOSUB 300
220 NEXT
230 END

Drawing a curve element:
-------------------------------------------------------------------
300 X=X+XI:Y=Y+YI
310 IF T=1 AND G=0 AND XI=0 AND YI=1 G=2:XI=1:YI=0:GOTO 600
320 IF T=0 AND G=0 AND XI=0 AND YI=1 G=3:XI=-1:YI=0:GOTO 600
330 IF T=1 AND G=0 AND XI=1 AND YI=0 G=3:XI=0:YI=-1:GOTO 600
340 IF T=0 AND G=0 AND XI=1 AND YI=0 G=1:XI=0:YI=1:GOTO 600
350 IF T=1 AND G=1 AND XI=0 AND YI=1 G=2:XI=1:YI=0:GOTO 600
360 IF T=0 AND G=1 AND XI=0 AND YI=1 G=3:XI=-1:YI=0:GOTO 600
370 IF T=1 AND G=1 AND XI=-1 AND YI=0 G=0:XI=0:YI=1:GOTO 600
380 IF T=0 AND G=1 AND XI=-1 AND YI=0 G=2:XI=0:YI=-1:GOTO 600
390 IF T=1 AND G=2 AND XI=0 AND YI=-1 G=1:XI=-1:YI=0:GOTO 600
400 IF T=0 AND G=2 AND XI=0 AND YI=-1 G=0:XI=1:YI=0:GOTO 600
410 IF T=1 AND G=2 AND XI=1 AND YI=0 G=3:XI=0:YI=-1:GOTO 600
420 IF T=0 AND G=2 AND XI=1 AND YI=0 G=1:XI=0:YI=1:GOTO 600
430 IF T=1 AND G=3 AND XI=0 AND YI=-1 G=1:XI=-1:YI=0:GOTO 600
440 IF T=0 AND G=3 AND XI=0 AND YI=-1 G=0:XI=1:YI=0:GOTO 600
450 IF T=1 AND G=3 AND XI=-1 AND YI=0 G=0:XI=0:YI=1:GOTO 600
460 IF T=0 AND G=3 AND XI=-1 AND YI=0 G=2:XI=0:YI=-1
600 IF SCR$(X,Y)<>" " LOCATE X,Y:PRINT CHR$(C2):RETURN
610 LOCATE X,Y:PRINT CHR$(C1+G)
620 RETURN