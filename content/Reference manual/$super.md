+++
title = "$SUPER"
author = ["Yi Zhang"]
draft = false
+++

## $SUPER {#super}

Identifies the start of a NONMEM Superproblem


## CONTEXT {#context}

NM-TRAN Control Record


## USAGE {#usage}

```sh
$SUPER  [SCOPE=n1] [ITERATIONS=n2]
        [NOPRINT|PRINT]
```


## EXAMPLE {#example}

```sh
$SUPER     SCOPE=2 ITERATIONS=10
```


## DISCUSSION {#discussion}

Optional.


## OPTIONS {#options}


### SCOPE=n1 {#scope-n1}

Number  of  problems  in the superproblem.  Required.  Must be at
least 1.


### ITERATIONS=n2 {#iterations-n2}

Number of iterations of the superproblem.  Required.  Must be  at
least 2.  ITERATIONS may also be coded NITERATIONS.


### NOPRINT {#noprint}

NONMEM  printout displaying the input information for each of the
problems of the superproblem will be generated  only  during  the
first iteration.  This is the default.


### PRINT {#print}

NONMEM  printout displaying the input information for each of the
problems of the superproblem will be generated during all  itera-
tions.

To define a sequence of problems as a superproblem, precede the $PROB-
LEM record of the first problem of the sequence with a $SUPER  record.
More than one $SUPER problem can be present in the control stream, but
the level of nesting can be at most 2.

The pattern for nested super problems is

```sh
$SUPER SCOPE=s1
$PROBLEM 1
 ...
$PROBLEM n
$SUPER SCOPE=s2
$PROBLEM n+1
 ...
$PROBLEM n+m
```

The second super problem must be totally contained with in the first.

n &gt;= 1 and m &gt;= 1 is required (each $SUPER  problem  must  contain  at
least one $PROBLEM).

If  s1  &gt;  n,  then  the scope of the first $SUPER includes the second
$SUPER, and the scope of the second must be entirely contained  within
the scope of the first: s1 &gt;= n+s2.

(See Problem_Iteration_Counters).
