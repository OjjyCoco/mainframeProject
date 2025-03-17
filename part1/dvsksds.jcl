//API5DVKS  JOB ,
// MSGCLASS=H,MSGLEVEL=(1,1),TIME=(2,1),REGION=70M,COND=(16,LT)
//* CLEAN : DELETE KSDS CLUSTER IF IT EXISTS
//CLEAN     EXEC PGM=IDCAMS
//SYSPRINT  DD   SYSOUT=*
//SYSIN     DD   *
      DELETE 'API5.PROJET.DVS.KSDS.CLUSTER'
/*
//*  SORT : TRIE DU FICHIER DATA POUR PERMETTRE L'INSERTION KSDS
//SORT      EXEC PGM=SORT
//SYSOUT    DD SYSOUT=*
//SORTIN    DD DSN=API5.PROJET.DVS.DATA,DISP=SHR
//SORTOUT   DD DSN=API5.PROJET.DVS.DATA,DISP=SHR
//SYSIN     DD *
  SORT FIELDS=(1,4,CH,A)
/*
//* STEPIDC CALL IDCAMS TO CREATE KSDS CLUSTER
//STEPIDC   EXEC PGM=IDCAMS
//SYSPRINT  DD   SYSOUT=*
//SYSIN     DD   *
 DEFINE    CLUSTER  (NAME(API5.PROJET.DVS.KSDS)  -
                    TRACKS(10 1)                             -
                    RECORDSIZE(20 20)                         -
                    FREESPACE(10 20)                          -
                    KEYS(4 0)                                 -
                    INDEXED)                                  -
           DATA     (NAME(API5.PROJET.DVS.KSDS.D)         -
                    CISZ(8192))                               -
           INDEX    (NAME(API5.PROJET.DVS.KSDS.I))

 REPRO INDATASET(API5.PROJET.DVS.DATA)                    -
    OUTDATASET(API5.PROJET.DVS.KSDS)

 PRINT INDATASET(API5.PROJET.DVS.KSDS) CHAR
/*
//
