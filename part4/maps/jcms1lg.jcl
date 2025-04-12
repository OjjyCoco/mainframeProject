//JCMS1LG JOB DPTM,VSAM,MSGLEVEL=(1,1),MSGCLASS=H,CLASS=A,
//   NOTIFY=&SYSUID,TIME=(0,5)
//*------------------------------------------------------*
//*      MODIFIER XX PAR N¢ DU GROUPE                    *
//*      MODIFIER N PAR N¢ DE MAP                        *
//*      MODIFIER &MAP  PAR MAPNCIXX                     *
//*------------------------------------------------------*
//*
//         JCLLIB  ORDER=SDJ.FORM.PROCLIB
//         EXEC    COMPMAP,MAP=MS1LG
//*
//*----------------------------------------------------------*
//*                                                          *
//* COMPIL / LINK / COPY MAP CICS TS 2.2                     *
//*                                                          *
//*----------------------------------------------------------*
//*
//STEPEXT.SYSUT1   DD DSN=API1.SOURCE.COBOL(MS1LG),DISP=SHR
//STEPCOP.SYSPUNCH DD DSN=API1.COB.CPY(MS1LG),DISP=SHR
