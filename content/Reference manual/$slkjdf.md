+++
title = "$SLKJDF"
author = ["Yi Zhang"]
draft = false
+++

## $SLKJDF {#slkjdf}

Specifies LKJ decorrelation degrees of freedom for each SIGMA
block


## CONTEXT {#context}

NM-TRAN Control Record


## USAGE {#usage}

```sh
$SLKJDF 0 (default)
$SLKJDF [value ... ]
$SLKJDF [(value)[xn]] ...
```


## DISCUSSION {#discussion}

SLKJDF is an option of the $ESTIMATION record.  $SLKJDF is a  separate
record  that  allows  the user to specify LKJ decorrelation degrees of
freedom for each SIGMA block.


## EXAMPLE {#example}

```sh
$SLKJDF 4.5 3.5 -2.0
```

Where 4.5 degrees of freedom are specified for the first sigma  block,
3.5  for  the second, and - 2.0 specifies 2 degrees of freedom for the
third sigma block, but a user-defined definition of the standard devi-
ations   of   the  diagonals  for  the  third  sigma  block.  Use  the
SIGMA_STD_PRIORU.f90 file in the ..\source directory as a template  to
modify the SIGMA_STD_PRIORU to provide the desired probability density
function. Set $SUBR OTHER=SIGMA_STD_PRIORU.f90 to use the  user  modi-
fied template (you may rename the file for organizational purposes).

RECORD ORDER:

Follows $SIGMA


## REFERENCES {#references}

Guide Introduction_7
