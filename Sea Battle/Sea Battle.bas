ABOUT

This is variation of the Sea Battle game.

VARIABLES

A()   - enemy's board
S$()  - sprite parts of player's and enemy's spaceships
D     - game difficulty or ship direction (1 - vertical, 0 - horizontal)
T     - 0 - player moves, 1 - enemy moves
X,Y   - player's target coordinates
M,N,K - pressed key codes

PROGRAM CODE

Allocate memory for enemy's board and spaceships:
-------------------------------------------------------------------
0 DIM A(9,9),S$(4)

Drawing the game board:
-------------------------------------------------------------------
1 CLS:SPRITEOFF:CGEN3
2 C$=CHR$(227):FOR X=7 TO 11:
  LOCATE X,3:PRINT C$:LOCATE 13-X,3:PRINT C$:
  LOCATE 14+X,3:PRINT C$:LOCATE 27-X,3:PRINT C$:
  NEXT
3 C$=CHR$(222):LOCATE 1,3:PRINT C$:LOCATE 15,3:PRINT C$:
  C$=CHR$(223):LOCATE 12,3:PRINT C$:LOCATE 26,3:PRINT C$
4 C$=CHR$(226):FOR Y=4 TO 13:
  LOCATE 1,Y:PRINT C$:LOCATE 12,Y:PRINT C$:
  LOCATE 15,Y:PRINT C$:LOCATE 26,Y:PRINT C$:
  NEXT
5 C$=CHR$(224):LOCATE 1,14:PRINT C$:LOCATE 15,14:PRINT C$:
  C$=CHR$(225):LOCATE 12,14:PRINT C$:LOCATE 26,14:PRINT C$
6 C$=CHR$(227):FOR X=2 TO 6:
  LOCATE X,14:PRINT C$:LOCATE 13-X,14:PRINT C$:
  LOCATE 14+X,14:PRINNT C$:LOCATE 27-X,14:PRINT C4:
  NEXT      
7 FOR X=8 TO 18 STEP 2:COLOR X,0,3:NEXT:
  LOCATE 9,0:PRINT "SEA BATTLE":LOCATE 4,2:PRINT "PLAYER":
  LOCATE 17,2:PRINT "COMPUTER":LOCATE 13,8:PRINT "VS"

Placement of player ships:
-------------------------------------------------------------------

Generating of ships' sprites
-------------------------------
8 C$=CHR$(193):FOR I=0 TO 3:DEF SPRITE I,(2,0,0,0,0)=C$:NEXT

The main loop of ships placement:
-------------------------------
9 FOR S=4 TO 1 STEP -1:FOR C=5-S TO 1 STEP -1:
  GOSUB 10:NEXT:SPRITE S-1:NEXT:GOTO 40

Drawing the ship:
-------------------------------
10 D=0:X=(10-S)/2*8+32:Y=87:SPRITE ON
11 FOR K=0 TO S-1
12 SPRITE K,X-(D=0)*8*K,Y-(D=1)*8*K
13 NEXT

Processing of key press:
-------------------------------
14 M=STICK(0):N=STRIG(0):K=ASC(INKEY$):PAUSE 3
15 IF N=4 OR K=84 GOTO 22
16 IF N=8 OR K=13 OR K=32 GOTO 32
17 IF M=2 IF X>32 X=X-8:GOTO 11
18 IF M=1 IF X<104+8*(D=0)*(S-1) X=X+8:GOTO 11
19 IF M=8 IF Y>55 Y=Y-8:GOTO 11
20 IF M=4 IF Y<127+8*(D=1)*(S-1) Y=Y+8:GOTO 11
21 M=RND(9):GOTO 14

Movement and rotation of a ship:
-------------------------------
22 D=1-D:IF D=0 GOTO 28
23 X=X+S/2*8:Y=Y-S/2*8
24 IF X>104 X=104
25 IF Y>135-8*S Y=135-8*S
26 IF Y<55 Y=55
27 GOTO 11
28 X=X-S/2*8:Y=Y+S/2*8
29 IF X<32 X=32
30 IF X>112-8*S X=112-8*S
31 GOTO 11

Collision check and ship accepting:
-------------------------------
32 F=0:T=(X-16)/8:K=(Y-23)/8:M=S:N=1:IF D=1 SWAP N,M
33 FOR I=T-1 TO T+M:FOR J=K-1 TO K+N
34 IF SCR$(J,K)=C$ J=99:K=99:F=1
35 NEXT:NEXT:IF F=1 PLAY "O0A3:O1C3:O2B3":GOTO 14
36 IF D=0 FOR I=T TO T+S-1:LOCATE I,K:PRINT C$:GOTO 39
38 FOR J=K TO K+S-1:LOCATE T,J:PRINT C$
39 NEXT:RETURN

Difficulty mode selection:
-------------------------------------------------------------------
40 LOCATE 16,6:PRINT "DIFFICULTY":LOCATE 19,8:PRINT"EASY":
   LOCATE 19,9:PRINT "NORMAL":LOCATE 19,10:PRINT "HARD"
41 DEF SPRITE 0,(2,0,0,0,0)=">":X=152:Y=95

Processing of key press:
-------------------------------
42 SPRITE 0,X,Y:PAUSE 5:M=STICK(0):N=STRIG(0):K=ASC(INKEY$)
43 IF M=8 Y=Y-8:IF Y<87 Y=103
44 IF M=4 Y=Y+8:IF Y>103 Y=87
45 IF N=1 OR K=13 OR K=32 GOTO 47
46 GOTO 42

Placement of enemy's ships:
-------------------------------------------------------------------
47 D=(Y-23)/8-8
48 SPRITE 0:FOR Y=4 TO 13: FOR X=16 TO 25:
   LOCATE X,Y:PRINT CHR$(176):
   NEXT:NEXT:
   LOCATE 16,15:PRINT "(        )"
49 E=0:FOR S=4 TO 1 STEP -1:FOR K=1 TO 5-S:E=E+S
50 X=RND(11-S):Y=RND(10):M=S:N=1
51 F=RND(2):IF F=1 SWAP X,Y:SWAP M,N
52 FOR I=X-1 TO X+M:FOR J=Y-1 TO Y+N
53 IF I>=0 IF I<10 IF J>=0 IF J<10 
   IF A(J,I)>0 I=99:J=99:NEXT:NEXT:GOTO 50
54 NEXT:NEXT
55 IF F=1 GOTO 57
56 FOR I=X TO X+S-1:A(Y,I)=S:NEXT:GOTO 58
57 FOR J=Y TO Y+S-1:A(J,X)=S:NEXT
58 LOCATE 16+7*E/20,15:PRINT "--":NEXT:NEXT:
   LOCATE 16,15:PRINT "          "

The battle process:
-------------------------------------------------------------------
59 T=0:C=20:E=20:X=176:Y=95:D$=CHR$(205):E$=CHR$(181):
   DEF SPRITE 5,(1,0,0,1,0)=CHR$(221)

Processing of key press:
-------------------------------
60 SPRITE 5,X,Y:PAUSE 5:M=STICK(0):N=STRIG(0):K=ASC(INKEY$)
61 IF M=1 IF X<216 X=X+8:GOTO 60
62 IF M=2 IF X>144 X=X-8:GOTO 60
63 IF M=8 IF Y>55 Y=Y-8:GOTO 60
64 IF M=4 IF Y<127 Y=Y+8:GOTO 60
65 IF N=8 OR K=13 OR K=32 SPRITE 5:GOTO 67
66 GOTO 60

Player switching:
-------------------------------
67 IF T=1 GOTO 69
68 S$(0)=CHR$(211):
   A$=CHR$(25):S$(1)=" "+A$+A$+CHR$(20):
   A$=CHR$(3):S$(2)=A$+" "+CHR$(8)+A$:
   S$(3)=CHR$(5)+CHR$(11)+" "+CHR$(12):
   S$(4)=CHR$(21)+CHR$(27)+CHR$(24)+" ":
   GOTO 70
69 S$(0)=CHR$(212):
   A$=CHR$(185):B$=CHR$(186):S$(1)=CHR$(9)+A$+CHR$(10)+B$:
   S$(2)=A$+CHR$(17)+B$+CHR$(18):
   A$=CHR$(12):B$=CHR$(24):S$(3)=A$+CHR$(27)+" "+A$:
   S$(4)=CHR$(5)+B$+B$+" "
70 DEF SPRITE 0,(3-T,0,0,0,0)=S$(0):
   FOR I=1 TO 4:DEF SPRITE I,(2-T,1,0,0,0)=S$(I):NEXT

Player's move:
-------------------------------
71 I=D:IF T=0 N=X-12:M=Y:GOTO 75

Enemy's move:
--------------
72 Q=RND(10)+2:W=RND(10)+4:A$=SCR$(Q,W):
   IF A$=D$ OR A$=E$ GOTO 72
73 IF I>0 IF A$<>C$ I=I-1:GOTO 72
74 N=8*Q+4:M=8*W+23

Spacehip's move:
-------------------------------
75 FOR J=223 TO 160 STEP -1:
   SPRITE 1,N,J:SPRITE 2,N+16,J:
   SPRITE 3,N,J+16:SPRITE 4,N+16,J+16:
   NEXT

Bullet's move:
-------------------------------
76 FOR J=168 TO M STEP -1:SPRITE 0,N+12,J:NEXT

Removing spacehips:
-------------------------------
77 FOR I=0 TO 4:SPRITE I:NEXT:IF T=1 GOTO 83

Player's shot check:
-------------------------------
78 N=(X-16)/8:M=(Y-23)/8:I=N-16:J=M-4:
   IF A(J,I)=0 GOSUB 81:T=1-T:GOTO 67
79 A(J,I)=0:C=C-1:I=X:J=Y:GOSUB 82:
   IF C=0 GOTO 87
80 GOTO 60

Miss:
-------------------------------
81 LOCATE N,M:PRINT D$:PLAY "T1O1DCDC":RETURN

Hit:
-------------------------------
82 LOCATE N,M:PRINT E$:CGEN 2:
   DEF MOVE(0)=SPRITE(10,0,3,100,0,2):POSITION 0,I-4,J-4:MOVE 0:
   PLAY "T1O0FGDACB":PAUSE 90:ERA 0:CGEN 3:RETURN

Enemy's shot check:
-------------------------------
83 I=N:J=M:N=Q:M=W:IF SCR$(N,M)<>C$ GOSUB 81:T=1-T:GOTO 60
84 E=E-1:I=I+12:GOSUB 82:IF E=0 GOTO 86
85 GOTO 67

Victory or defeat:
-------------------------------------------------------------------
86 LOCATE 3,15:PRINT "YOU LOSE":GOTO 88
87 LOCATE 3,15:PRINT "YOU WIN!"
88 IF STICK(0)=0 AND STRIG(0)=0 AND ASC(INKEY$)=0 GOTO 88
89 LOCATE 3,15:PRINT "        ":
   FOR X=2 TO 11:FOR Y=4 TO 13:
   A(Y-4,X-2)=0:
   LOCATE X,Y:PRINT " ":
   LOCATE X+14,Y:PRINT " ":
   NEXT:NEXT
90 GOTO 8
