//JPP2     JOB NOTIFY=&SYSUID,CLASS=A,MSGCLASS=H,TIME=(0,59)            00010000
//*=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-*  00080000
//*   CETTE PROCEDURE CONTIENT 5 STEPS :                             *  00090000
//*       ======> SI RE-EXECUTION FAIRE RESTART AU "STEPRUN"         *  00100000
//*                                                                  *  00110000
//*         1/  PRECOMPILE  DB2                                      *  00120000
//*         2/  COMPILE COBOL II                                     *  00130000
//*         3/  LINKEDIT  (DANS FORM.CICS.LOAD)                      *  00140000
//*         4/  BIND PLAN PARTIR DE APIXX.SOURCE.DBRMLIB             *  00150000
//*         5/  EXECUTE DU PROGRAMME                                 *  00160000
//*  LES   PROCEDURES  SE TROUVENT DANS SDJ.FORM.PROCLIB             *  00170000
//*=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-*  00180000
//PROCLIB  JCLLIB ORDER=SDJ.FORM.PROCLIB                                00190000
//*                                                                     00200000
//         SET SYSUID=API5,                                             00210000
//             NOMPGM=PP2                                               00220000
//*                                                                     00230000
//APPROC   EXEC COMPDB2                                                 00240000
//STEPDB2.SYSLIB   DD DSN=&SYSUID..SOURCE.DCLGEN,DISP=SHR               00250000
//                 DD DSN=&SYSUID..SOURCE.COPY,DISP=SHR                 00260000
//STEPDB2.SYSIN    DD DSN=&SYSUID..SOURCE.DB2(&NOMPGM),DISP=SHR         00270000
//STEPDB2.DBRMLIB  DD DSN=&SYSUID..SOURCE.DBRMLIB(&NOMPGM),DISP=SHR     00280000
//STEPLNK.SYSLMOD  DD DSN=&SYSUID..SOURCE.PGMLIB(&NOMPGM),DISP=SHR      00290000
//*--- ETAPE DE BIND --------------------------------------             00310000
//BIND     EXEC PGM=IKJEFT01,COND=(4,LT)                                00330000
//*DBRMLIB  DD  DSN=&SYSUID..DB2.DBRMLIB,DISP=SHR                       00340000
//DBRMLIB  DD  DSN=&SYSUID..SOURCE.DBRMLIB,DISP=SHR                     00350000
//SYSTSPRT DD  SYSOUT=*,OUTLIM=25000                                    00360000
//SYSTSIN  DD  *                                                        00370000
  DSN SYSTEM (DSN1)                                                     00380000
  BIND PLAN      (PP2)     -                                            00390000
       QUALIFIER (API5)    -                                            00400000
       ACTION    (REPLACE) -                                            00410000
       MEMBER    (PP2)     -                                            00420000
       VALIDATE  (BIND)    -                                            00430000
       ISOLATION (CS)      -                                            00440000
       ACQUIRE   (USE)     -                                            00450000
       RELEASE   (COMMIT)  -                                            00460000
       EXPLAIN   (NO)                                                   00470000
/*                                                                      00480000
//STEPRUN  EXEC PGM=IKJEFT01,COND=(4,LT)                                00490000
//STEPLIB  DD DSN=&SYSUID..SOURCE.PGMLIB,DISP=SHR                       00500000
//*        DD DSN=&SYSUID..COBOL.LOAD,DISP=SHR                          00510000
//SYSOUT   DD  SYSOUT=*,OUTLIM=1000                                     00520000
//SYSTSPRT DD  SYSOUT=*,OUTLIM=2500                                     00530000
//SYSIN    DD *                                                         00540000
//SYSTSIN  DD  *                                                        00550000
  DSN SYSTEM (DSN1)                                                     00560000
  RUN PROGRAM(PP2) PLAN(PP2)                                            00570000
/*                                                                      00580000
//VEU      DD DSN=API5.PROJET.VENTESEU.DATA,DISP=SHR                    00600001
//VAS      DD DSN=API5.PROJET.VENTESAS.DATA,DISP=SHR                    00610001
