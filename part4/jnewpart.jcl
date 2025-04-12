//JNEWPART JOB (ACCT#),'GAYLORD',MSGCLASS=H,REGION=4M,
//    CLASS=A,MSGLEVEL=(1,1),NOTIFY=&SYSUID,TIME=(0,30)
//************************************************************
//* SUPPRESION DES FICHIERS NEWPART.DATA ET NEWPART.KSDS
//************************************************************
//SUPALL   EXEC PGM=IDCAMS
//SYSPRINT DD SYSOUT=*
//SYSIN    DD *
 DELETE API5.PROJET.NEWPARTS.DATA
 DELETE API5.PROJET.NEWPARTS.KSDS
/*
//************************************************************
//* CREATION DU FICHIER API5.PROJET.NEWPARTS.DATA ET Y METTRE
//* DES DONNEES POUR LE DEBUT
//************************************************************
//CREATION EXEC PGM=IEBGENER
//SYSPRINT DD SYSOUT=*
//SYSIN    DD DUMMY
//SYSUT1   DD *
P1Case Screws                   Red                 10New York
P2Cable Ties                    Blue                20Los Angeles
P3Fan Grills                    Green               15Chicago
P4Dust Filters                  Yellow              25Houston
P5Cooling Fan                   Black               30Miami
/*
//SYSUT2   DD DSN=API5.PROJET.NEWPARTS.DATA,DISP=(NEW,CATLG,CATLG),
//            DCB=(LRECL=80,RECFM=FB,BLKSIZE=800),UNIT=3390,
//            SPACE=(TRK,(1,1),RLSE)
//***************************************************
//*  ETAPE DE CREATION DU FICHIER NEWPARTS.KSDS
//***************************************************
//CREAKSDS EXEC PGM=IDCAMS
//SYSPRINT DD SYSOUT=*
//SYSIN    DD *
  DEFINE CLUSTER (NAME(API5.PROJET.NEWPARTS.KSDS)           -
                  VOLUME(APIWK2)                            -
                  TRACKS(1 1)                               -
                  FREESPACE(20 20)                          -
                  KEYS(2 0)                                 -
                  RECORDSIZE(80 80)                         -
                  INDEXED)                                  -
         DATA    (NAME(API5.PROJET.NEWPARTS.KSDS.D))        -
         INDEX   (NAME(API5.PROJET.NEWPARTS.KSDS.I))

  REPRO INDATASET(API5.PROJET.NEWPARTS.DATA)    -
        OUTDATASET(API5.PROJET.NEWPARTS.KSDS)

  PRINT INDATASET(API5.PROJET.NEWPARTS.KSDS) CHAR
/*
