+++
title = "$LDFOLD"
author = ["Yi Zhang"]
draft = false
+++

## $LDFOLD {#ldfold}

 Revert to pre NONMEM 7.5.1 interpretation of loss of degrees
of freedom (LDF).


## CONTEXT {#context}

NM-TRAN Control Record


## USAGE {#usage}

```sh
$LDFOLD
```

If there is a reason that you need your problem to handle LDFs in
the  manner of previous NONMEM versions, insert $LDFOLD after the
first $PROBLEM:

```sh
$PROB My problem
$LDFOLD
```

and this will revert to the old default handling of  LDFs.   Only
the  new methods (ITS/IMP/SAEM/BAYES) are affected by a change in
default behavior regarding LDFs of NONMEM version 7.5.0 to 7.5.1.


## REFERENCES {#references}

Guide Introduction_7
