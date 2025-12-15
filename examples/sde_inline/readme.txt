The following describes how to use Christoffer Tornoe's R script to add SDE equations to a control stream file.  Two exmamples are given.  For further understanding of SDE systems, and how to implement them in NONMEM, see the workshop materials sdecourse.zip (courtesy of Christoffer Tornoe).

Load R, then in the console:

setwd("c:/nm760/examples/sde_inline") 
(or wherever your nonmem installation is located)
source("NONMEMSDEscript.R")
SDEmodel(CS="run1.mod",datafile="PKdata.dta")
SDEmodel(CS="ex4.mod",datafile="EX4.dataODE")

From a command window, in the sde_inline directory,

nmfe75 run1.modSDE run1.res -prdefault
and compare 
run1.res against run1_ref.res
run1.fit against run1_ref.fitsde

Next,
Modify ex4.mod so that 

$THETA (0,1) ; SGW3
is changed to
$THETA (0,.1) ; SGW3

and
ISR=A(3)
ISRV=0

is modified to
ISR=AHT3
ISRV=PHT6

and 
moved to end of $PK record.

Then
nmfe75 ex4.mod ex4.res -prdefault

and compare:
ex4.res against ex4_ref.res
ex4.table1 egainst ex4_ref.table2
