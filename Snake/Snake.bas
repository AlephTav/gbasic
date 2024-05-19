ABOUT

The classic Snake game.

VARIABLES

X,Y       - snake head coordinates
I,J       - snake head coordinate increments
SX(),SY() - arrays of snake body coordinates
LI,LJ     - indexes of snake head and tall coordinates
C$        - snake char
O$        - char devoured by snake
L         - snake length
K,SP      - determines snake speed in relation to its length
M         - code of a pressed key
P         - total score
PI        - the current cost of a berry

PROGRAM CODE

Drawing the playing field:
-------------------------------------------------------------------
0 CLS:PALETB 0,15,32,36,28
10 LOCATE 0,0:PRINT CHR$(222):LOCATE 27,20:PRINT CHR$(225)
20 FOR I=1 TO 26
30 LOCATE I,0:PRINT CHR$(227)
40 LOCATE 27-I,20:PRINT CHR$(227)
50 NEXT
60 LOCATE 27,0:PRINT CHR$(223):LOCATE 0,20:PRINT CHR$(224)
70 FOR I=1 TO 19
80 LOCATE 27,I:PRINT CHR$(226)
90 LOCATE 0,20-I:PRINT CHR$(226)
100 NEXT
110 LOCATE 1,21:PRINT CHR$(238):LOCATE 26,21:PRINT CHR$(238):
    LOCATE 13,21:PRINT CHR$(238):LOCATE 14,21:PRINT CHR$(238)
120 LOCATE 1,22:PRINT CHR$(241):LOCATE 26,22:PRINT CHR$(242):
    LOCATE 13,22:PRINT CHR$(242):LOCATE 14,22:PRINT CHR$(241)
130 FOR I=2 TO 7
140 LOCATE I,22:PRINT CHR$(237):LOCATE 27-I,22:PRINT CHR$(237):
    LOCATE 14-I,22:PRINT CHR$(237):LOCATE 13+I,22:PRINT CHR$(237)
150 NEXT
160 LOCATE 2,21:PRINT "SCORE:    0":LOCATE 15,21:PRINT "LENGTH:   1"

First berries arrangement:
-------------------------------------------------------------------
170 FOR I=1 TO 5:GOSUB 1010:NEXT

Variables initialization:
-------------------------------------------------------------------
700 X=12:Y=9:I=1:J=0:C$=CHR$(207):
    DIM SX(255),SY(255):SX(0)=X:SY(0)=Y:
    LI=0:LJ=0:P=0:L=0:SP=4:K=SP

The main loop of snake move:
-------------------------------------------------------------------
710 IF K>0 K=K-1:GOTO 850
720 K=SP
730 LOCATE SX(LJ),SY(LJ):PRINT " ":X=X+I:Y=Y+J
740 LI=LI+1:IF LI>254 LI=0
750 LJ=LJ+1:IF LJ>254 LJ=0
760 SX(LI)=X:SY(LI)=Y
770 O$=SCR$(X,Y)
780 if O$=" " GOTO 840
790 IF O$<>CHR$(215) GOTO 910
800 LJ=LJ-1:IF LJ<0 LJ=254
810 IF L<41 SP=4-L/10
820 IF L<101 PI=2+L/5
830 GOSUB 1010:GOSUB 1100:GOSUB 1200:PLAY "T1O0D0F0"
840 LOCATE X,Y:PRINT C$

Processing of key press:
-------------------------------------------------------------------
850 M=STICK(0)
860 IF M=1 J=1:J=0
870 IF M=2 I=-1:J=0
880 IF M=4 J=1:I=0
890 IF M=8 J=-1:I=0
900 GOTO 710

Defeat
-------------------------------------------------------------------
910 SPRITE ON:CGSET 1,0
920 DEF MOVE(0)=SPRITE(10,0,3,100,0,3)
930 POSITION 0,8*X+12,8*Y+20:MOVE 0
940 PLAY "T4O0GFDG":FOR I=0 TO 3:CGSET 0,0:CGSET 1,1:NEXT
950 PLAY "T8O0ABDECEDDEACFCE"
1000 SPRITE OFF:END

Berry placement:
-------------------------------------------------------------------
1010 FX=RND(26)+1:FY=RND(18)+1
1020 IF SCR$(FX,FY)<>" " GOTO 1010
1030 LOCATE FX,FY:PRINT CHR$(215)
1040 RETURN

Calculating and drawing the current snake length:
-------------------------------------------------------------------
1100 L=L+1:IF L>255 L=255
1110 LOCATE 26-LEN(STR$(L)),21:PRINT L:RETURN

Claculating and drawing the current score:
-------------------------------------------------------------------
1200 P=P+PI:IF P<0 P=32767
1210 LOCATE 13-LEN(STR$(P)),21:PRINT P:RETURN