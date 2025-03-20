//JEXT     JOB (ACCT#),'GAYLORD',MSGCLASS=H,
//    CLASS=A,MSGLEVEL=(1,1),NOTIFY=&SYSUID,TIME=(0,30)
//************************************************************
//* SUPPRESION DU FICHIER API5.PROJET.EXTRACT.DATA
//************************************************************
//SUPALL   EXEC PGM=IDCAMS
//SYSPRINT DD SYSOUT=*
//SYSIN    DD *
 DELETE API5.PROJET.EXTRACT.DATA
/*
//************************************************************
//* CREATION DU FICHIER API5.PROJET.EXTRACT.DATA
//************************************************************
//CREERFIC EXEC PGM=IEFBR14
//FICHIER  DD DSN=API5.PROJET.EXTRACT.DATA,DISP=(NEW,CATLG,CATLG),
//            DCB=(LRECL=277,RECFM=FB,BLKSIZE=2770),UNIT=3390,
//            SPACE=(TRK,(1,1),RLSE)
//SYSOUT   DD SYSOUT=*
