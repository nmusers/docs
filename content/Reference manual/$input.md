+++
title = "$INPUT"
author = ["Yi Zhang"]
draft = false
+++

## $INPUT {#input}

Defines the data item types in the data set


## CONTEXT {#context}

NM-TRAN Control Record


## USAGE {#usage}

```sh
$INPUT item1    item2    item3   ...
```


## EXAMPLE {#example}

```sh
$INPUT      ID DOSE TIME CP=DV WT
```


## DISCUSSION {#discussion}

The  items  define the data item types that appear in the NM-TRAN data
records, and define the order of their appearance.

This record is required. It must precede  any  other  NM-TRAN  control
record that refers to specific data item types.

With  NONMEM  VI 2.0 and later versions, the length of a single $INPUT
record (and all records of the NM-TRAN input  file)  is  at  most  160
characters.  (Previously, it was 80 characters.)  With NONMEM 7.3, the
maximum length is given by FSD in resource/SIZES.f90  (FSD=67000  with
NONMEM  7.3).   With  NONMEM 7.2 and higher, both lower and upper case
may be used for all user-defined and reserved  words  in  the  control
stream.   With  NONMEM 7.3 and higher, &amp; may be used at the end of any
line of the control stream to indicate that the line is to be  contin-
ued, including control records as well as abbreviated code.

Multiple  $INPUT  records  may  be  used.  Each continues the previous
record.


## OPTIONS {#options}

Each item has form B or A=B, where A and B are data item labels.

With previous versions of NONMEM labels were restricted to  4  charac-
ters in length and could not include the character <span class="underline">.  With NONMEM 7 a
label consists of 1-24 letters (A-Z), numerals (0-9), and the  charac-
ter '</span>', beginning with a letter.  (The length 24 is specified by con-
stant SDF in SIZES)
(See SIZES).

The labels may be used in subsequent NM-TRAN control records and  will
be used as labels for data items in NONMEM output.

Certain data item labels are reserved and refer to data items that may
be needed by NONMEM or PREDPP, i.e.,

```sh
ID L1 L2 DV MDV
RAW_ MRG_ RPT_
TIME DATE DAT1 DAT2 DAT3 DROP SKIP EVID AMT RATE SS II ADDL
CMT PCMT CALL CONT
```

Certain data item labels are semi-reserved, in that they have reserved
meanings  if  used in $INPUT, but can also be user-defined in abbrevi-
ated code, in which case they have no reserved meaning, i.e.,

```sh
XVID1 XVID2 XVID3 XVID4 XVID5
;; (See evid data item).
REPL_
```

Others are labels assigned by the user, e.g., to label user  (concomi-
tant) data.

Certain labels should not appear in the $INPUT record:

ETA1 ETA2 ETA3 ETA4 ETA5 ETA6 ETA7 ETA8 ETA9
Labels for basic PK parameters (e.g., CL, V, K, KA)
Labels for additional PK parameters (e.g., S1, F0, R1, F1)
Arguments of subroutines internal to NONMEM/PREDPP
Mu variables (e.g., MU\_ MU_i )

When the form A=B is used, at least one of the labels A or B must be a
reserved label.  If A or B is a non-reserved label, it  is  a  synonym
for  the  reserved  label.  The synonym is used as the label in NONMEM
output.

If DROP (or SKIP) is used as a data item label or  synonym,  the  data
item type will not appear in the NONMEM data set.  DROP (or SKIP)  may
be used with more than one item.

If the label DATE (or DAT1, DAT2, or DAT3) is used,  DATE=DROP  causes
the  data  item to not appear in the NONMEM data set.  However, NMTRAN
will adjust the TIME data item to reflect the date.
(See date data item).


## REFERENCES {#references}

Guide IV, section III.B.2 , V.C.1


## REFERENCES {#references}

Guide V, section 6.5


## REFERENCES {#references}

Guide VI, section V.A
