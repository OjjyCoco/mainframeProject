MS1PA    DFHMSD TYPE=&SYSPARM,                                         X
               MODE=INOUT,                                             X
               LANG=COBOL,                                             X
               EXTATT=YES,                                             X
               DATA=FIELD,                                             X
               STORAGE=AUTO,                                           X
               CTRL=(FREEKB,FRSET)
MAP1PA   DFHMDI SIZE=(24,80),CTRL=(FREEKB,FSET)
         DFHMDF POS=(1,1),                                             X
               LENGTH=79,                                              X
               INITIAL='***********************************************X
               ********************************',                      X
               ATTRB=ASKIP
         DFHMDF POS=(2,1),                                             X
               LENGTH=12,                                              X
               INITIAL='*    DATE : ',                                 X
               ATTRB=ASKIP,COLOR=YELLOW
DATEJ    DFHMDF POS=(2,14),                                            X
               LENGTH=08,                                              X
               ATTRB=ASKIP
LIBMAP   DFHMDF POS=(2,28),                                            X
               LENGTH=24,                                              X
               ATTRB=ASKIP,COLOR=GREEN
         DFHMDF POS=(2,53),                                            X
               LENGTH=08,                                              X
               INITIAL='HEURE : ',                                     X
               ATTRB=ASKIP,COLOR=YELLOW
HEURE    DFHMDF POS=(2,62),                                            X
               LENGTH=08,                                              X
               ATTRB=ASKIP
         DFHMDF POS=(2,79),                                            X
               LENGTH=1,INITIAL='*',                                   X
               ATTRB=ASKIP
         DFHMDF POS=(3,1),                                             X
               LENGTH=79,                                              X
               INITIAL='***********************************************X
               ********************************',                      X
               ATTRB=ASKIP
         DFHMDF POS=(7,1),                                             X
               LENGTH=11,                                              X
               INITIAL='CODE PART :',                                  X
               ATTRB=ASKIP,COLOR=YELLOW
CODEPA   DFHMDF POS=(7,17),                                            X
               PICIN='X(2)',PICOUT='X(2)',                             X
               LENGTH=02,                                              X
               VALIDN=(mustenter),                                     X
               INITIAL='__',                                           X
               ATTRB=(UNPROT,IC,FSET,NUM)
         DFHMDF POS=(7,20),                                            X
               LENGTH=00
         DFHMDF POS=(9,10),                                            X
               LENGTH=19,                                              X
               INITIAL='NOM PART         :',                           X
               ATTRB=ASKIP,COLOR=YELLOW
NOMPA    DFHMDF POS=(9,30),                                            X
               LENGTH=30,                                              X
               INITIAL='______________________________',               X
               VALIDN=(MUSTENTER),                                     X
               ATTRB=(UNPROT,IC,FSET)
         DFHMDF POS=(9,61),                                            X
               LENGTH=00
         DFHMDF POS=(11,10),                                           X
               LENGTH=19,                                              X
               INITIAL='COLOR PART       :',                           X
               ATTRB=ASKIP,COLOR=YELLOW
COLPA    DFHMDF POS=(11,30),                                           X
               LENGTH=20,                                              X
               INITIAL='____________________',                         X
               VALIDN=(MUSTENTER),                                     X
               ATTRB=(UNPROT,IC,FSET)
         DFHMDF POS=(11,51),                                           X
               LENGTH=00
         DFHMDF POS=(13,10),                                           X
               LENGTH=19,                                              X
               INITIAL='WEIGHT PART      :',                           X
               ATTRB=ASKIP,COLOR=YELLOW
WEIPA    DFHMDF POS=(13,30),                                           X
               LENGTH=2,                                               X
               INITIAL='__',                                           X
               VALIDN=(MUSTENTER),                                     X
               ATTRB=(UNPROT,IC,FSET)
         DFHMDF POS=(13,33),                                           X
               LENGTH=00
         DFHMDF POS=(15,10),                                           X
               LENGTH=19,                                              X
               INITIAL='CITY PART        :',                           X
               ATTRB=ASKIP,COLOR=YELLOW
CITYPA   DFHMDF POS=(15,30),                                           X
               LENGTH=20,                                              X
               INITIAL='____________________',                         X
               VALIDN=(MUSTENTER),                                     X
               ATTRB=(UNPROT,IC,FSET)
         DFHMDF POS=(15,51),                                           X
               LENGTH=00
         DFHMDF POS=(20,1),                                            X
               LENGTH=79,                                              X
               INITIAL='***********************************************X
               ********************************',                      X
               ATTRB=ASKIP
         DFHMDF POS=(21,1),                                            X
               LENGTH=79,                                              X
               INITIAL='* ESC : FIN     ENTER : AJOUTER                X
                                              *',                      X
               ATTRB=ASKIP
         DFHMDF POS=(22,1),                                            X
               LENGTH=12,                                              X
               INITIAL='* MESSAGE : ',                                 X
               ATTRB=ASKIP
MESS1    DFHMDF POS=(22,14),                                           X
               LENGTH=55,                                              X
               ATTRB=(ASKIP,BRT),color=red
         DFHMDF POS=(22,79),                                           X
               LENGTH=1,                                               X
               INITIAL='*',                                            X
               ATTRB=ASKIP
         DFHMDF POS=(23,1),                                            X
               LENGTH=1,                                               X
               INITIAL='*',                                            X
               ATTRB=ASKIP
MESS2    DFHMDF POS=(23,14),                                           X
               LENGTH=56,                                              X
               ATTRB=(ASKIP,BRT),color=red
         DFHMDF POS=(23,79),                                           X
               LENGTH=1,                                               X
               INITIAL='*',                                            X
               ATTRB=ASKIP
         DFHMDF POS=(24,1),                                            X
               LENGTH=79,                                              X
               INITIAL='***********************************************X
               ********************************',                      X
               ATTRB=ASKIP
         DFHMSD  TYPE=FINAL
         END
