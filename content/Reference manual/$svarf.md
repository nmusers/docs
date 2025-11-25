+++
title = "$SVARF"
author = ["Yi Zhang"]
draft = false
+++

## $SVARF {#svarf}

Specifies the weighting to the standard deviations of SIGMA


## CONTEXT {#context}

NM-TRAN Control Record


## USAGE {#usage}

```sh
$SVARF 0 (default)
$SVARF [value ... ]
$SVARF [(value)[xn]] ...
```


## EXAMPLE {#example}

```sh
$SVARF 2.0 5.0
```

Where  2.0 is specified for the first sigma block, 5.0 for the second.
If the corresponding $SLKJDF value is negative then this  is  argument
STDSSP in user-defined SIGMA_STD_PRIORU.f90.


## DISCUSSION {#discussion}

The  $SVARF  is  a separate record that allows the user to specify the
weighting (inverse variance) to the standard deviations LKJ decorrela-
tion degrees of freedom for each SIGMA block.  Used with NUTS method.

$EST SVARF over-rides $SVARF.


## REFERENCES {#references}

Guide Introduction_7
