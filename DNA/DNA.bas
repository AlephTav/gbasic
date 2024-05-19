ABOUT

Demo of sliding window effect.

VARIABLES

X1,X2 - x coordinates of two molecules
I1,I2 - increments of molecular coordinates
R     - determines to what limit the displacement of molecules will reach
K     - increment for R

PROGRAM CODE

Palette selection:
-------------------------------------------------------------------
10 CLS:PALETB 0,1,33,5,46

Variables initialization:
-------------------------------------------------------------------
20 X1=13:X2=13:I1=1:I2=-1
30 R=1:K=1

The main loop:
-------------------------------------------------------------------
40 LOCATE X1,22:PRINT CHR$(207)
50 LOCATE X2,22:PRINT CHR$(207)
60 LOCATE 0,23:PRINT " "
70 IF RND(3)>0 GOTO 110
80 R=R+K
90 IF R<2 K=-K
100 IF R>10 K=-K
110 X1=X1+I1:X2=X2+I2
120 IF X1<R I1=-I1:X1=R
130 IF X1>26-R I1=-I1:X1=26-R
150 IF X2<R I2=-I2:X2=R
160 IF X2>26-R I2=-I2:X2=26-R
170 GOTO 40