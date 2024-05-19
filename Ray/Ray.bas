ABOUT

Simple graphics with randomization.

VARIABLES

X,Y - ray coordinatez
YM  - maximum Y coordinate
I,J - coordinate increments
D   - determines whether to output the ray symbol or not
S$  - ray symbol

PROGRAM CODE

Variables initialization:
-------------------------------------------------------------------
10 CLS
20 X=0:YM=RND(20)+3:Y=RND(YM)
30 I=1:J=1
40 D=RND(2):GOTO 130

The main loop:
-------------------------------------------------------------------
50 LOCATE X,Y:IF D=0 PRINT S$
55 X=X+I:Y=Y+J
60 D=1-D
70 IF X>27 I=-I:X=27
80 IF X<0 I=-I:X=0
90 IF Y>YM J=-J:Y=YM
100 IF Y<0 J=-J:Y=0
120 IF I+J=0 S$="/":GOTO 50
130 S$="\":GOTO 50