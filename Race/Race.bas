ABOUT

Bet on the character who will reach the finish line first.

VARIABLES

S() - array of sprite indexes
W   - the index of selected character (sprite)
K   - code of the pressed key during sprite selection
X,Y - sprite coordinates
I   - auxiliary variable - counter

PROGRAM CODE

Variables initialization:
-------------------------------------------------------------------
0 DIM S(6):W=0

Move creation for 7 random sprites:
-------------------------------------------------------------------
50 FOR I=0 TO 6
55 S(I)=RND(16)
60 DEF MOVE(I)=SPRITE(S(I),3,1,1,0,0)
70 POSITION I,15,24*I+23
80 MOVE I
90 NEXT

Drawing racecourse and turning on sprite mode:
-------------------------------------------------------------------
10 CGSET 1,0:VIEW:SPRITE ON:LOCATE 12,0:PRINT"RACE"

Setting the selection flag and processing of keys:
-------------------------------------------------------------------
110 LOCATE 27,W*3+1:PRINT CHR$(199)
130 K1=STICK(0):K2=STRIG(0)
140 IF K1=4 OR k1=8 GOTO 180
160 IF K2<>0 GOTO 240
170 K1=RND(9):GOTO 130
180 LOCATE 27,W*3+1
190 PRINT " "
200 W=W+3-K1/2
210 IF W<0 W=6
220 IF W>6 W=0
230 GOTO 110

Race:
-------------------------------------------------------------------
240 FOR I=0 TO 6
242 X=XPOS(I):Y=YPOS(I)
243 IF X>=224 GOTO 290
245 IF MOVE(I)=-1 GOTO 270
250 DEF MOVE(I)=SPRITE(S(I),3,RND(10)+1,RND(20),0,0)
255 POSITION I,X,Y
260 MOVE I
270 NEXT
280 GOTO 240

Victory or defeat:
-------------------------------------------------------------------
290 CUT 0,1,2,3,4,5,6
300 LOCATE 10-(I=W),22
310 IF W=I GOTO 340
320 PRINT "YOU LOSE"
330 GOTO 350
340 PRINT "YOU WIN"
350 IF STRIG(0)=0 GOTO 350
360 LOCATE 10,22
370 PRINT "        "
380 GOTO 50