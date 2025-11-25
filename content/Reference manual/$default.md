+++
title = "$DEFAULT"
author = ["Yi Zhang"]
draft = false
+++

## $DEFAULT {#default}

Specifies certain defaults for NONMEM


## CONTEXT {#context}

NM-TRAN Control Record


## USAGE {#usage}

```sh
$DEFAULT  [NOSUB=[-1|0|1]]
```


## EXAMPLE {#example}

```sh
$DEFAULT NOSUB=1
```


## DISCUSSION {#discussion}

$DEFAULT is optional.  If present, it must appear following $PROB

Specifies  certain  defaults  for  NONMEM.   If more than one $DEFAULT
record is present in a given problem, the one used by  NONMEM  is  the
last one in the problem.


## OPTIONS {#options}


### NOSUB=[-1|0|1] {#nosub-1-0-1}

With  NOSUB=0, label substitution will be performed for all tasks
in the problem.  This is the default.
(See $ABBREVIATED).
With NOSUB=1, label substitution will not be performed.
With NOSUB=-1, revert to NONMEM default, which is to treat -1  as
a 0.

If  the  NOSUB  option  is also specified on a task specification
record ($TABLE, $SCATTER), then this value of NOSUB applies  only
for the current task.  When speficied on a $EST record, the usual
rule for options apply, in which the option varies  carries  into
the  next  $EST  record in the problem unless otherwise re-speci-
fied.

May also be coded $DEFAULTS.


## REFERENCES {#references}

Guide Introduction_7
