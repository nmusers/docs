+++
title = "$RCOV"
author = ["Yi Zhang"]
draft = false
+++

## $RCOV $RCOVI {#rcov-rcovi}

Inputting Variance-Covariance information from another problem.


## CONTEXT {#context}

NM-TRAN Control Record


## USAGE {#usage}

```sh
$RCOV
       FILE=filename [FORMAT|DELIM=s1]  [TBLN=n]
$RCOVI
       FILE=filename [FORMAT|DELIM=s1]  [TBLN=n]
```


## EXAMPLE {#example}

```sh
$RCOV FILE=sirsample.cov TBLN=1 DELIM=,
```

The $RCOV record can be used to load the variance-covariance matrix of
estimates  results  from a previous problem, and use it for subsequent
use in assessing total standard errors of table items  without  having
to re-calculate the variance with a $COV step.

The  record  $RCOVI  may  be  used to load the the variance-covariance
information from the inverse-covariance file:

```sh
$RCOVI FILE=sirsample.coi TBLN=1 DELIM=,
```

The FILE=filename option is required.

If FORMAT or DELIM is used, it should be the same as was specified  on
the  $ESTIMATION record that created the file to be used.  The default
is s1PE12.5.

TBLN is the table number in the file.  If TBLN is  not  specified,  it
defaults to 1.

NONMEM describes the use of these records with a message in the report
file and to the terminal such as the following:

LOADED VARIANCE/COVARIANCE DATA FROM FILE c5.cov
If NONMEM is unable to read the file, the message is
COULD NOT FIND APPROPRIATE VARIANCE/COVARIANCE DATA IN FILE c5.cov

$RCOV and $RCOVI can be used with the $CHAIN record.  For examples and
discussion:

See INTRODUCTION  TO  NONMEM  7, $RCOV and $RCOVI Record For Inputting
Variance-Covariance information from another problem.


## REFERENCES {#references}

Guide Introduction_7
