//JEPJPT3B JOB (ACCT#),'GAYLORD',MSGCLASS=H,REGION=4M,
//    CLASS=A,MSGLEVEL=(1,1),NOTIFY=&SYSUID,TIME=(0,30)
//************************************************************
//* SUPPRESION DU FICHIER FACTURE.DATA
//************************************************************
//SUPALL   EXEC PGM=IDCAMS
//SYSPRINT DD SYSOUT=*
//SYSIN    DD *
 DELETE API5.PROJET.FACTURES.DATA
/*
//************************************************************
//* CREATION DU FICHIER API5.PROJET.FACTURES.DATA
//************************************************************
//CREERFIC EXEC PGM=IEFBR14
//FICHIER  DD DSN=API5.PROJET.FACTURES.DATA,DISP=(NEW,CATLG,CATLG),
//            DCB=(LRECL=102,RECFM=FB,BLKSIZE=2040),UNIT=3390,
//            SPACE=(TRK,(1,1),RLSE)
//SYSOUT   DD SYSOUT=*
//***************************************************
//*  ETAPE D'EXECUTION : EXECUTION DE PJPART3B
//***************************************************
//STEPEX8  EXEC PGM=PJPART3B
//STEPLIB  DD DSN=API5.COBOL.LOAD,DISP=SHR
//SYSOUT   DD SYSOUT=*
//EXTRACT  DD DSN=API5.PROJET.EXTRACT.DATA,DISP=SHR
//FACTURE  DD DSN=API5.PROJET.FACTURES.DATA,DISP=SHR
//SYSIN    DD *
2000
/*
