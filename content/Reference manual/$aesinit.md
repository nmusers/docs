+++
title = "$AESINIT"
author = ["Yi Zhang"]
draft = false
+++

## $AESINIT {#aesinit}

Marks the beginning of abbreviated code for the AES routine.


## CONTEXT {#context}

NM-TRAN Control Record


## USAGE {#usage}

```sh
$AESINITIAL
abbreviated code
```


## DISCUSSION {#discussion}

The  $AESINITIAL record is used to compute the amounts in the equilibrium compartments at the beginning of an integration interval.  It  is
used  with  PREDPP's  ADVAN9, ADVAN15, and ADVAN17.  May also be coded
$AES0.
(See $AES).
General rules for abbreviated code are documented elsewhere
(See abbreviated code).
Specific rules follow.


### ASSIGNMENT AND CONDITIONAL STATEMENTS {#assignment-and-conditional-statements}


#### Left-hand quantities in assignment statements: {#left-hand-quantities-in-assignment-statements}

A(ncm1+1), A(ncm1+2), ...  (Required. The amounts in  the  equilibrium
compartments at the beginning of the integration interval. ncm1 is the
number of nonequilibrium compartments.)

INIT  (Initialization flag.)
 INIT=0: The A(n) are approximate.
 INIT=1: The A(n) are exact (the default).

AESINITIAL-defined (i.e., PRED-defined) items.


#### Right-hand quantities in assignment statement and in conditions: {#right-hand-quantities-in-assignment-statement-and-in-conditions}

A(1), A(2), ...   (Current compartment amounts; may be  random  variables.)

P(1),  P(2), ...   (Post-translation basic PK parameters; may be random variables.)

PK-defined items (Implicit basic PK parameters; may be  random  variables.)

T  (Time  at the beginning of the integration interval; may be random
variables.)

AESINITIAL-defined items that appeared earlier as  left-hand  quantities.


#### Data item labels specified on the $INPUT statement. {#data-item-labels-specified-on-the-input-statement-dot}

THETA(n).


#### Global Variables in Modules {#global-variables-in-modules}

Certain variables in FORTRAN Modules can be used.
(See Variables_in_modules)


#### Forbidden Variable Names: {#forbidden-variable-names}

IR DA DP DT E(n) ETA(n) EPS(n) ERR(n)


### PSEUDO ASSIGNMENT STATEMENTS {#pseudo-assignment-statements}

COMRES=-1

CALLFL=-1: Call ADVAN and AES with every event record (default).
CALLFL=1: Call ADVAN and AES once per individual record.

(CALLFL may be used only when the TIME data item is not defined.)  The
pseudo assignments statements may be enclosed in parentheses.  If both
are  present  within the same set of parentheses, separate them with a
semicolon.  Within parentheses, a calling protocol phrase may be  used
instead of CALLFL, and either upper or lower case may be used. E.g.,
$AESINIT (ONCE PER IR)     ; same as CALLFL=1
$AESINIT (EVERY EVENT)     ; same as CALLFL=-1 (default)

(See calling protocol).


### RECORD ORDER: {#record-order}

Follows $SUBROUTINES $INPUT $MODEL $PK

Precedes $AES


## REFERENCES {#references}

Guide IV, section V.C.8

Guide VI, section VI.E
