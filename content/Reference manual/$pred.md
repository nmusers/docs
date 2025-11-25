+++
title = "$PRED"
author = ["Yi Zhang"]
draft = false
+++

## $PRED {#pred}

Marks the beginning of abbreviated code for the PRED routine


## CONTEXT {#context}

NM-TRAN Control Record


## USAGE {#usage}

```sh
$PRED
abbreviated code
```


## DISCUSSION {#discussion}

The $PRED record is used to model values for the DV data items.  It is
NOT used with PREDPP (but (See $ERROR).  General rules for abbreviated
code  are documented elsewhere (See abbreviated code).  Specific rules
for $PRED follow.


### ASSIGNMENT AND CONDITIONAL STATEMENTS {#assignment-and-conditional-statements}

Left-hand quantities in assignment statements:

Y (Required. The modeled value for the dependent variable under  the
statistical model.)

PRED-defined items.

Right-hand quantities in assignment statement and in conditions:

Data item labels specified on the $INPUT statement.

THETA(n).

ETA(n)  (Used if the data are population or single-subject data, and
in the latter case can be coded ERR(n).)

EPS(n) (Used if the data are population, and can be coded ERR(n).)

PRED-defined items that appeared earlier  as  left-hand  quantities.
This includes Y.

NEWIND
 Same as the NEWIND argument passed by NONMEM to PREDPP.
 NEWIND=0:  First  record  of  the data set.  THETA value may differ
 from value at last call with this record.
 NEWIND=1: First record of the data set, THETA value does not differ
 from  value at last call with this record, and PRED is nonrecursive
 (see I_REC), or,
 First record of a subsequent individual record.
 NEWIND=2: Subsequent data record of an individual record.

NEWL2
 NEWL2=1: First record of an L2 record.
 NEWL2=2: Otherwise.

ICALL
 ICALL=0: Run initialization.
 ICALL=1: Problem initialization.
 ICALL=2: Normal call.
 ICALL=3: Problem finalization.
 ICALL=4: Simulation.
 ICALL=5: Expectation.
 ICALL=6: Data Average.
 Special rules apply to blocks of abbreviated code that are executed
 when ICALL is not 2.
 (See initialization, finalization, simulation).
 (See expectation, data average).

Variables in Fortran modules
 Certain  variables  in  FORTRAN  modules  can  be used.  (See Vari-
 ables_in_modules)

Forbidden Variable Names:

DATREC INDXS G H DADT(n) A(n) E(n) P(n)


### PSEUDO ASSIGNMENT STATEMENTS {#pseudo-assignment-statements}

COMRES=-1


### RECORD ORDER: {#record-order}

Follows $SUBROUTINES and $INPUT


## REFERENCES {#references}

Guide I, section C.2


## REFERENCES {#references}

Guide IV, section III.B.8 , IV


## REFERENCES {#references}

Guide V, section 12.3
