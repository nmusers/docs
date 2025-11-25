+++
title = "$INDEX"
author = ["Yi Zhang"]
draft = false
+++

## $INDEX {#index}

Defines values for the PRED/PREDPP INDXS array


## CONTEXT {#context}

NM-TRAN Control Record


## USAGE {#usage}

```sh
$INDEX  [label1|value1]  [label2|value2]  [label3|value3] ...
```


## EXAMPLE {#example}

```sh
$INDEX   DOSE  1
```


## DISCUSSION {#discussion}

Optional. Used only with user-supplied FORTRAN subroutines (ERROR, PK,
INFN, PRED) which make explicit use of the INDXS array.  May  also  be
coded $INDXS or $INDEXES.


## OPTIONS {#options}

The  labels  are those of data items on the $INPUT record.  The values
are integers no larger than the number of data  items  in  the  NONMEM
input  data  set.   Either the index of the data items with  labeli or
valuei  is stored in INDXS(i).  (The index of a data item is its posi-
tion in the NONMEM data record.)


## REFERENCES {#references}

Guide I, section C.4.1


## REFERENCES {#references}

Guide IV, section III.B.3


## REFERENCES {#references}

Guide VI, section III.C , V.A
