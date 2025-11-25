+++
title = "$ETAS"
author = ["Yi Zhang"]
draft = false
+++

## $ETAS $PHIS {#etas-phis}

Specifies Initial Values for Etas or Phis


## CONTEXT {#context}

NM-TRAN Control Record


## USAGE {#usage}

```sh
$ETAS  [[value1  [value2]  [value3] ... [valuen]]
        [FILE=filename  [FORMAT|DELIM =s] [TBLN=n]]  [ITERATION=n]]

$PHIS  [[value1  [value2]  [value3] ... [valuen]]
        [FILE=filename  [FORMAT|DELIM=s1] [TBLN=n]]  [ITERATION=n]]
```


## EXAMPLE {#example}

```sh
$ETAS 0.4 3.0 3.0 5.0
$PHIS 0.4 3.0 3.0 5.0
$ETAS FILE=myprevious.phi FORMAT=s1pE15.8 TBLN=3
$PHIS FILE=myprevious.phi FORMAT=s1pE15.8 TBLN=3
$ETAS FILE=myprevious.iph TBLN=3 ITERATION=123
```

NONMEM  describes the use of these records with messages in the report
file such as the following:

```nil
LOADED    3 PHI/ETA ITEMS FROM CONTROL STREAM
```


## DISCUSSION {#discussion}

By default, the initial value used for ETA's in  the  Estimation  Step
search  is  0.   The $ETAS and $PHIS records provide different initial
estimates.  Optional.


## OPTIONS {#options}

There are two forms:


### $ETAS  value1  [value2]  [value3] ...[[valuen] {#etas-value1-value2-value3-dot-dot-dot-valuen}

All of the subjects in the data set will be given  these  initial
values  of  etas.   If fewer values are listed than the number of
etas in the problem, the value 0 will be used for  the  remaining
etas.   Any  real  value (positive, negative, zero) may be speci-
fied.

When the record is $PHIS, values are entered as phi values,  con-
venient for EM methods.  The eta values will then be evaluated as
eta(i)=phi(i)-mu(i) for each eta, where mu(i)=mu_i  is  evaluated
according to their definitions in the $PK section.


### FILE=filename  FORMAT=s  TBLN=n  ITERATION=n                           | {#file-filename-format-s-tbln-n-iteration-n}

Uses  initial etas and/or phis for an entire set of subjects from |
a file  .phi, .phm (in the case of mixture problems) of a  previ- |
ous analysis, or .iph file.                                       |

With  FORMAT,  s defines the delimiter [,|s(pace)|t(ab)] followed
by a Fortran format specification. The default is s1PE12.5.  FOR-
MAT  should  at  least have the delimiter appropriate to read the
file.  May also be coded DELIM.
For more details, see the format help item:
(See format).
See INTRODUCTION TO NONMEM 7, FORMAT=s1PE11.4

TBLN is the table number in the file.  If TBLN is not  specified,
it  defaults  to  1, i.e., the first set of etas/phis are brought
in.

ITERATION is the iteration number in a .iph  file  (not  relevant |
for  .phi or .phm file).  As a .iph file has both ETA() and PHI() |
items, ETA()s will be selected for a $ETAS record, and PHI() will |
be  selected  for  a  $PHIS  record.   The  first  ITERATION&gt;0 is |
selected, unless a particular iteration is specified.             |

In matching the etas/phis to the data set given in $DATA  of  the |
control  stream  file,  the  attempt  will be to match ID numbers |
rather than subject numbers, if an ID column in the file  exists, |
which  it  will,  if  you are using a .phi or .phm file generated |
from a previous nonmem analysis.  The phc/etc variances will also |
be brought in.                                                    |

One  purpose to bringing initial eta/phi and etc/phc values is you can
readily resume an analysis, if an MSF file was not set up in the  pre-
vious  analysis (the MSF file system is still the most complete infor-
mation transfer for resuming an analysis.


## FURTHER DISUCSSION {#further-disucssion}

The etas from $ETAS/$PHIS can be used in several ways.

In METHOD=0  (FO),  they  are  ignored,  because  FO  is  specifically
designed as a first order Taylor series approximation process centered
around eta=0.

In METHOD=1 (FOCE), they are ignored unless  MCETA&gt;0.   When  MCETA&gt;0,
then  various  starting  etas  are tested, including a set from $ETAS,
when available.

In Bayes, SAEM, IMP MAPITER=0 they are used as the starting etas.

In MAP estimation methods, such as METHOD=1, or ITS, or IMP MAPITER&gt;0,
or  IMPMAP, and if MCETA&gt;0, then these etas are one of the initial eta
vector positions tested (during the first iteration), and the one giv-
ing the lowest OBJ is then selected.

In  cases  where  FNLETA=2,  the  estimation step is skipped, and etas
inputted from $ETAS are treated as if they were the final result of an
estimation.

For examples and discussion:

See INTRODUCTION  TO  NONMEM  7,  $ETAS and $PHIS Record For Inputting
Specific Eta or Phi values


## REFERENCES {#references}

Guide Introduction_7
