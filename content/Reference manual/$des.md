+++
title = "$DES"
author = ["Yi Zhang"]
draft = false
+++

## $DES {#des}

Marks the beginning of abbreviated code for the DES routine


## CONTEXT {#context}

NM-TRAN Control Record


## USAGE {#usage}

```sh
$DES
abbreviated code
```


## EXAMPLE {#example}

Suppose  differential  equations were used for ADVAN2, rather than the
analytic solution.  The $DES block would be as follows:

```sh
$DES
DADT(1)=-P(3)*A(1)
DADT(2)=P(3)*A(1)-P(1)*A(2)
```


## DISCUSSION {#discussion}

The $DES record is used to compute differential equations.  It is used
with  PREDPP's  general  non-linear  models  (ADVAN6,  ADVAN8, ADVAN9,
ADVAN13, ADVAN14, ADVAN15, ADVAN16, ADVAN17,ADVAN18).   General  rules
for abbreviated code are documented elsewhere
(See abbreviated code).
Specific rules follow.


### ASSIGNMENT AND CONDITIONAL STATEMENTS {#assignment-and-conditional-statements}

Left-hand quantities in assignment statements:

DADT(1),  DADT(2),  ...   (Required.  Derivative of each compartment
amount with respect to time.)

It is important to note that PREDPP itself adds in the  rates  for
any  infusions  that  may  be active.  It is possible to introduce
endogenous drug into a compartment by explicit terms in a  differ-
ential  equation,  rather than by PREDPP dose event records.  Drug
introduced in this manner is not included by PREDPP in the  compu-
tation of the output compartment.

DES-defined (i.e., PRED-defined) items.

Right-hand quantities in assignment statement and in conditions:

A(1),  A(2), ...   (Current compartment amounts; may be random vari-
ables.)

P(1), P(2), ...   (Post-translation explicit  basic  PK  parameters;
may be random variables.)

PK-defined items (Post-translation implicit basic PK parameters; may
be random variables.)

T (Time; may be random variable. T takes values continuously over an
integration interval.)  (Note that T may take values that are larger
than the ending time of the interval.)

DES-defined items that appeared earlier as left-hand  quantities  in
$DES.

Data  item  labels  specified  on  the  $INPUT statement may be used
explicitly in DES and $DES abbbreviated code (rather  than  obtained
as  PK  parameters). This may improve run time.  As with $PK, values
are those of the current event record (the event record to which the
system is being advanced).

THETA(n).

Fortran  functions  that  are  continuous, such as SIN and COS, may be
used.  The INT, MOD, and ABS functions (or other functions that intro-
duce  a discontinuity) should not be used in the $DES block.  Instead,
use model event times MTIME in the $PK  block,  and  either  set  flag
variables  in $PK that can be tested in $DES, or use MPAST in the $DES
block.  See Appendix 3 of  Guide  VI  PREDPP.   Several  examples  are
available for the use of MTIME with $DES.
(See mtime, model time examples).
(See Examples Using MTIME to Model Periodic Discontinuities in $DES).
See step_circexa.ctl in the NONMEM examples directory.
See idr_circexa.ctl in the NONMEM examples directory.

Global Variables in Modules
Certain variables in FORTRAN Modules can be used.
(See Variables_in_Modules)
The following are of particular interest.


### DOSTIM {#dostim}

DOSTIM  is  the time of a lagged dose or additional dose to which the
system is being advanced.  Abbreviated code in $DES may test  DOSTIM.
It  may  use DOSTIM on the right, unless DOSTIM is a random variable.
In this case, it may be used on the right in a $PK block to define  a
random  variable  which  may in turn be used on the right in the $DES
block.


### DOSREC {#dosrec}

DOSREC is the dose record corresponding to the dose entering at  DOS-
TIM.   Abbreviated code in $AES may test items in DOSREC in a logical
condition, and DOSREC may always be used on the right.


### ISFINL {#isfinl}

During simulation or a copying pass, and during the advance to a par-
ticular  time  (event or non-event time), ISFINL=1 at a final call to
DES at that time.  Otherwise, ISFINL=0.


### DES_DER, MITER, METH {#des-der-miter-meth}

See Diff Eq Solver Settings.

Forbidden Variable Names:

IR DA DP E(n) ETA(n) EPS(n) ERR(n)


### PSEUDO ASSIGNMENT STATEMENTS {#pseudo-assignment-statements}

COMRES=-1


### RECORD ORDER: {#record-order}

Follows $SUBROUTINES $INPUT $MODEL $PK


### DISPLAYED VALUES {#displayed-values}

DES-defined variables may be listed for display in $TABLE or $SCATTER.
The  values  displayed  for the first event record of the data set are
0's.  The values displayed  for the first event record  of  subsequent
individuals are those from the last event record of the previous indi-
vidual. This is because there is no call to DES with the  first  event
record  of  the individual record, or with any other event record with
the same value of TIME.  NM-TRAN provides a warning message.

```txt
(WARNING  48) DES-DEFINED ITEMS ARE COMPUTED ONLY WHEN EVENT TIME
 INCREASES. E.G., DISPLAYED VALUES ASSOCIATED  WITH  THE  FIRST  EVENT
RECORD OF  AN  INDIVIDUAL  RECORD ARE COMPUTED WITH (THE LAST ADVANCE TO) AN
EVENT TIME OF THE PRIOR INDIVIDUAL RECORD.
```

The values displayed for event records other than the first are evalu-
ated  at  the event time (as are all other displayed items such as PK-
defined values and data record items).

Note that multiple calls to DES are associated with each event record.
Some (including the final call during integration) may have a value of
T that is larger than the end time of the integration interval.   When
NONMEM is performing  simulation  or  a  copying  pass (COMACT&gt;0), DES
is called immediately after the  advance to  an  event  time  or  non-
event  time,  with  a value of T equal to this time, so that displayed
values are the final value of T.  Global variable  ISFINL  is  set  by
PREDPP  to  1  on  this  final call to DES.  ISFINL can be tested on a
WRITE statement if such statements are used in DES.

(See des, advan6, advan8, advan9).


## REFERENCES {#references}

Guide IV, section V.C.7


## REFERENCES {#references}

Guide VI, section VI.C
