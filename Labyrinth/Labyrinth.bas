ABOUT

Try to remember labyrinth entirely and then
to pass it with small view window.

VARIABLES

S     - determines the size of the square view window (the smaller the more difficult)
SS    - window size, equals to 2*S+1
C     - palet number (0-3) for view window
WX,WY - coordinates of the top left corner of the view window
FX,FY - labyrinth frame coordinates
PX,PY - player coordinates in the maze
X,Y,I - auxiliary variables
W$()  - array of maze strings
P$    - player symbol (ball)
G$    - symbol of exit from the maze (flag)
B$    - symbol on the player's path

PROGRAM CODE

Variables initialization:
-------------------------------------------------------------------
0 DIM W$(20):G$=CHR$(199):P$=CHR$(207):
  C=2:S=2:SS=2*S+1:
  WX=(27-SS)/2:WY=(20-SS)/2

Storing the labyrinth in memory:
-------------------------------------------------------------------
1 VIEW:
  FOR X=10 TO 18 STEP 2:COLOR X,22,2:NEXT:
  LOCATE 10,22:PRINT "REMEMBER"
2 FOR Y=0 TO 20:FOR X=0 TO 27:B$=SCR$(X,Y)
3 IF B$=P$ PX=X:PY=Y:B$=" "
4 W$(Y)=W$(Y)+B$
5 NEXT:NEXT

Creation of the player sprite:
-------------------------------------------------------------------
10 CLS:SPRITE ON:CGEN3:CGSET0,2:DEF SPRITE 0,(3,0,0,0,0)=P$

Drawing the frame of view window:
-------------------------------------------------------------------
11 FOR X=WX TO WX+SS+1 STEP 2:FOR Y=WY TO WY+SS+1 STEP 2 
12 COLOR X,Y,C:NEXT:NEXT:X=WX+SS+1:Y=WY+SS+1
15 LOCATE WX,WY:PRINT CHR$(222):LOCATE X,Y:PRINT CHR$(225):
   FOR I=1 TO SS
16 LOCATE WX+I,WY:PRINT CHR$(227):LOCATE X-I,Y:PRINT CHR$(227)
17 LOCATE WX,WY+I:PRINT CHR$(226):LOCATE X,Y-I:PRINT CHR$(226)
18 NEXT:
   LOCATE X,WY:PRINT CHR$(223):LOCATE WX,Y:PRINT CHR$(224)
19 LOCATE 8,Y+2:PRINT "FIND A WAY OUT"

Calculating player and view window coordinates:
-------------------------------------------------------------------
20 FX=PX-S:X=WX+S+1
21 IF FX<0 X=X+FX:FX=0
22 IF FX>28-SS X=X+FX-28+SS:FX=28-SS
23 FY=PY-S:Y=WY+S+1
24 IF FY<0 Y=Y+FY:FY=0
25 IF FY>21-SS Y=Y+FY-21+SS:FY=21-SS

Drawing the view window and player:
-------------------------------------------------------------------
30 FOR I=1 TO SS:LOCATE WX+1,WY+I:PRINT MID$(W$(FY+I-1),FX+1,SS):NEXT
35 SPRITE 0,16+8*X,23+8*Y

Player control and move through labyrinth:
-------------------------------------------------------------------
40 X=PX:Y=PY
41 I=ASC(INKEY$)
42 IF I=28 PX=PX-(PX<27)
43 IF I=29 PX=PX+(PX>0)
44 IF I=30 PY=PY+(PY>0)
45 IF I=31 PY=PY-(PY<20)
46 B$=MID$(W$(PY),PX+1,1)
47 IF B$=G$ GOTO 50
48 IF B$<>" " PX=X:PY=Y:GOTO 41
49 GOTO 20 

Victory:
-------------------------------------------------------------------
50 Y=WY+SS+3:LOCATE 8,Y:PRINT "   VICTORY    "
51 FOR C=0 TO 3:FOR X=11 TO 18 STEP 2:COLOR X,Y,C:NEXT:NEXT:GOTO 51