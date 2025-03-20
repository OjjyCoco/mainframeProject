000100 IDENTIFICATION DIVISION.                                         00010000
000200 PROGRAM-ID.        PJPART3.                                      00020000
000210 AUTHOR.            GAYLORD.                                      00021000
000220 INSTALLATION.      AJC.                                          00022000
000230 DATE-WRITTEN.      12/02/2025.                                   00023000
000240 DATE-COMPILED.                                                   00024000
000250 SECURITY.          COMMENTAIRES.                                 00025000
000260                                                                  00026000
000270 ENVIRONMENT DIVISION.                                            00027000
000280 CONFIGURATION SECTION.                                           00028000
000290 SPECIAL-NAMES.                                                   00029000
000300     DECIMAL-POINT IS COMMA.                                      00030000
000400                                                                  00040000
000410 INPUT-OUTPUT SECTION.                                            00041000
000420 FILE-CONTROL.                                                    00042000
000430      SELECT EXT ASSIGN TO EXTRACT                                00043000
000440      ORGANIZATION IS SEQUENTIAL.                                 00044000
000459                                                                  00045900
000460***********************************************                   00046000
000500 DATA DIVISION.                                                   00050000
000600 FILE SECTION.                                                    00060000
000700 FD EXT.                                                          00070000
000800 01 ENR-EXT PIC X(277).                                           00080000
000874                                                                  00087400
001200 WORKING-STORAGE SECTION.                                         00120000
001210******************************************************************00121000
001211*                  DECLARATION SQL                               *00121100
001212******************************************************************00121200
001220     EXEC SQL                                                     00122000
001221        INCLUDE SQLCA                                             00122100
001222     END-EXEC.                                                    00122200
001223                                                                  00122300
001224     EXEC SQL                                                     00122400
001225        INCLUDE ORDERS                                            00122500
001226     END-EXEC.                                                    00122600
001227                                                                  00122700
001228     EXEC SQL                                                     00122800
001229        INCLUDE CUSTS                                             00122900
001230     END-EXEC.                                                    00123000
001231                                                                  00123100
001232     EXEC SQL                                                     00123200
001233        INCLUDE EMPLO                                             00123300
001234     END-EXEC.                                                    00123400
001235                                                                  00123500
001236     EXEC SQL                                                     00123600
001237        INCLUDE DEPTS                                             00123700
001238     END-EXEC.                                                    00123800
001239                                                                  00123900
001240     EXEC SQL                                                     00124000
001241        INCLUDE ITEMS                                             00124100
001242     END-EXEC.                                                    00124200
001243                                                                  00124300
001244     EXEC SQL                                                     00124400
001245        INCLUDE PRODUCTS                                          00124500
001246     END-EXEC.                                                    00124600
001247                                                                  00124700
001248******************************************************************00124800
001249* DECLARATION DE CURSEUR POUR RECUPERE LIGNE PAR LIGNE            00124900
001250* LES INFORMATIONS D'UNE TABLE TELLE QUE ORDERS OU ITEMS          00125000
001251******************************************************************00125100
001252     EXEC SQL                                                     00125200
001253        DECLARE CORD CURSOR                                       00125300
001254        FOR                                                       00125400
001255           SELECT O_NO, S_NO, C_NO, O_DATE                        00125500
001256           FROM API5.ORDERS                                       00125600
001257           ORDER BY O_NO                                          00125700
001258     END-EXEC.                                                    00125800
001259                                                                  00125900
001260     EXEC SQL                                                     00126000
001261        DECLARE CITEM CURSOR                                      00126100
001262        FOR                                                       00126200
001263           SELECT O_NO, P_NO, QUANTITY, PRICE                     00126300
001264           FROM API5.ITEMS                                        00126400
001265           WHERE O_NO = :ORDER-O-NO                               00126500
001266     END-EXEC.                                                    00126600
001270                                                                  00127000
001280******************************************************************00128000
001290* DECLARATION DE VARIABLE POUR L'ECRITURE DANS LE FICHIER EXTRACT*00129000
001291******************************************************************00129100
001300 01 L-EXT.                                                        00130000
001301      05 WS-O-NO        PIC 9(3).                                 00130100
001302      05 WS-O-DATE      PIC X(11).                                00130200
001310      05 WS-COMPANY     PIC X(30).                                00131000
001320      05 WS-ADDRESS     PIC X(100).                               00132000
001330      05 WS-CITY        PIC X(20).                                00133000
001340      05 WS-ZIP         PIC X(5).                                 00134000
001350      05 WS-STATE       PIC X(2).                                 00135000
001380      05 WS-DNAME       PIC X(20).                                00138000
001381      05 WS-LNAME       PIC X(20).                                00138100
001382      05 WS-FNAME       PIC X(20).                                00138200
001387      05 WS-COM         PIC 99V99.                                00138700
001390      05 WS-P-NO        PIC X(3).                                 00139000
001391      05 WS-DESCRIPTION PIC X(30).                                00139100
001392      05 WS-QUANTITY    PIC 99.                                   00139200
001393      05 WS-PRICE       PIC 9(5)V99.                              00139300
001394                                                                  00139400
001397******************************************************************00139700
001398* DECLARATION DE VARIABLE UTILITAIRE COMME AFFICHER LE CODE SQL  *00139800
001399* DE RETOUR OU EN CAS D'ANOMALIE ARRETER LE PROGRAMME            *00139900
001400******************************************************************00140000
001401 77 ED-SQLCODE PIC +Z(8)9.                                        00140100
001402                                                                  00140200
001403 77 WS-ANO PIC 99 VALUE 0.                                        00140300
001404                                                                  00140400
001406 PROCEDURE DIVISION.                                              00140600
001407                                                                  00140700
001408     OPEN OUTPUT EXT                                              00140800
001409     PERFORM 200-OPEN-CORD                                        00140900
001410     PERFORM 300-FETCH-CORD                                       00141000
001411     PERFORM 310-GET-DATA UNTIL SQLCODE NOT = ZERO.               00141100
001412     PERFORM 700-CLOSE-CORD                                       00141200
001420     GOBACK.                                                      00142000
001500                                                                  00150000
001510******************************************************************00151000
001520* PARAGRAPHES POUR OUVRIR LES CURSEURS                           *00152000
001530******************************************************************00153000
001600 200-OPEN-CORD.                                                   00160000
001700       EXEC SQL                                                   00170000
001800          OPEN CORD                                               00180000
001900       END-EXEC                                                   00190000
002000       PERFORM TEST-SQLCODE                                       00200000
002100       EXIT.                                                      00210000
002110                                                                  00211000
002111 210-OPEN-CITEM.                                                  00211100
002112       EXEC SQL                                                   00211200
002113          OPEN CITEM                                              00211300
002114       END-EXEC                                                   00211400
002115       PERFORM TEST-SQLCODE                                       00211500
002116       EXIT.                                                      00211600
002117                                                                  00211700
002118******************************************************************00211800
002119* PARAGRAPHES POUR RECUPERER LES INFORMATIONS POUR L'ECRITURE    *00211900
002120* TELLE QUE LES INFORMATIONS GENERALE OU DES PRODUITS            *00212000
002121******************************************************************00212100
002122 300-FETCH-CORD.                                                  00212200
002130       INITIALIZE ST-ORDER                                        00213000
002140       EXEC SQL                                                   00214000
002150          FETCH CORD                                              00215000
002160          INTO :ORDER-O-NO, :ORDER-S-NO,                          00216000
002161               :ORDER-C-NO, :ORDER-O-DATE                         00216100
002170       END-EXEC                                                   00217000
002171       PERFORM TEST-SQLCODE                                       00217100
002172       MOVE ORDER-O-NO   TO WS-O-NO                               00217200
002173       MOVE ORDER-O-DATE TO WS-O-DATE                             00217300
002174       EXIT.                                                      00217400
002180                                                                  00218000
002190 310-GET-DATA.                                                    00219000
002194       PERFORM 320-FETCH-CUST                                     00219400
002195       PERFORM 330-FETCH-EMP                                      00219500
002196       PERFORM 340-FETCH-DEPT                                     00219600
002199       PERFORM 210-OPEN-CITEM                                     00219900
002200       PERFORM 350-FETCH-CITEM                                    00220000
002201       PERFORM 360-GET-ITEM-DATA UNTIL WS-O-NO NOT = ITEM-O-NO    00220100
002202       PERFORM 710-CLOSE-CITEM                                    00220200
002205       PERFORM 300-FETCH-CORD                                     00220500
002206       EXIT.                                                      00220600
002210                                                                  00221000
002211 320-FETCH-CUST.                                                  00221100
002212       INITIALIZE ST-CUSTS                                        00221200
002213       MOVE ORDER-C-NO TO CUSTS-C-NO                              00221300
002214       EXEC SQL                                                   00221400
002215           SELECT COMPANY, ADDRESS, CITY, STATE, ZIP              00221500
002216               INTO :CUSTS-COMPANY, :CUSTS-ADDRESS, :CUSTS-CITY,  00221600
002217                    :CUSTS-STATE, :CUSTS-ZIP                      00221700
002218               FROM API5.CUSTOMERS                                00221800
002219               WHERE C_NO = :CUSTS-C-NO                           00221900
002220       END-EXEC                                                   00222000
002221       PERFORM TEST-SQLCODE                                       00222100
002222       MOVE CUSTS-COMPANY TO WS-COMPANY                           00222200
002223       MOVE CUSTS-ADDRESS TO WS-ADDRESS                           00222300
002224       MOVE CUSTS-CITY    TO WS-CITY                              00222400
002225       MOVE CUSTS-STATE   TO WS-STATE                             00222500
002226       MOVE CUSTS-ZIP     TO WS-ZIP                               00222600
002227       EXIT.                                                      00222700
002228                                                                  00222800
002229 330-FETCH-EMP.                                                   00222900
002230       INITIALIZE ST-EMPLO                                        00223000
002231       MOVE ORDER-S-NO TO EMPLO-E-NO                              00223100
002232       EXEC SQL                                                   00223200
002233           SELECT DEPT, LNAME, FNAME, COM                         00223300
002234               INTO :EMPLO-DEPT, :EMPLO-LNAME,                    00223400
002235                    :EMPLO-FNAME, :EMPLO-COM                      00223500
002236               FROM API5.EMPLOYEES                                00223600
002237               WHERE E_NO = :EMPLO-E-NO                           00223700
002238       END-EXEC                                                   00223800
002239       PERFORM TEST-SQLCODE                                       00223900
002240       MOVE EMPLO-LNAME TO WS-LNAME                               00224000
002241       MOVE EMPLO-FNAME TO WS-FNAME                               00224100
002242       MOVE EMPLO-COM   TO WS-COM                                 00224200
002243       EXIT.                                                      00224300
002244                                                                  00224400
002245 340-FETCH-DEPT.                                                  00224500
002246       INITIALIZE ST-DEPT                                         00224600
002247       MOVE EMPLO-DEPT TO DEPT-DEPT                               00224700
002248       EXEC SQL                                                   00224800
002249           SELECT DNAME                                           00224900
002250               INTO :DEPT-DNAME                                   00225000
002251               FROM API5.DEPTS                                    00225100
002252               WHERE DEPT = :DEPT-DEPT                            00225200
002253       END-EXEC                                                   00225300
002254       PERFORM TEST-SQLCODE                                       00225400
002255       MOVE DEPT-DNAME TO WS-DNAME                                00225500
002256       EXIT.                                                      00225600
002257                                                                  00225700
002260 350-FETCH-CITEM.                                                 00226000
002261       INITIALIZE ST-ITEM                                         00226100
002262       EXEC SQL                                                   00226200
002263          FETCH CITEM                                             00226300
002264          INTO :ITEM-O-NO, :ITEM-P-NO, :ITEM-QUANTITY, :ITEM-PRICE00226400
002266       END-EXEC                                                   00226600
002267       PERFORM TEST-SQLCODE                                       00226700
002268       MOVE ITEM-P-NO     TO WS-P-NO                              00226800
002269       MOVE ITEM-QUANTITY TO WS-QUANTITY                          00226900
002270       MOVE ITEM-PRICE    TO WS-PRICE                             00227000
002271       EXIT.                                                      00227100
002272                                                                  00227200
002273 360-GET-ITEM-DATA.                                               00227300
002274       PERFORM 370-FETCH-PROD                                     00227400
002275       WRITE ENR-EXT FROM L-EXT                                   00227500
002277       PERFORM 350-FETCH-CITEM                                    00227700
002278       EXIT.                                                      00227800
002283                                                                  00228300
002284 370-FETCH-PROD.                                                  00228400
002285       INITIALIZE ST-PROD                                         00228500
002286       MOVE ITEM-P-NO TO PROD-P-NO                                00228600
002287       EXEC SQL                                                   00228700
002288          SELECT DESCRIPTION                                      00228800
002289              INTO :PROD-DESCRIPTION                              00228900
002290              FROM API5.PRODUCTS                                  00229000
002291              WHERE P_NO = :PROD-P-NO                             00229100
002292       END-EXEC                                                   00229200
002293       PERFORM TEST-SQLCODE                                       00229300
002294       MOVE PROD-DESCRIPTION TO WS-DESCRIPTION                    00229400
002295       EXIT.                                                      00229500
002296                                                                  00229600
002297******************************************************************00229700
002298* PARAGRAPHES POUR FERMER LES CURSEURS                           *00229800
002299******************************************************************00229900
002300 700-CLOSE-CORD.                                                  00230000
002301       EXEC SQL                                                   00230100
002302          CLOSE CORD                                              00230200
002303       END-EXEC                                                   00230300
002304       PERFORM TEST-SQLCODE                                       00230400
002305       EXIT.                                                      00230500
002306                                                                  00230600
002307 710-CLOSE-CITEM.                                                 00230700
002308       EXEC SQL                                                   00230800
002309          CLOSE CITEM                                             00230900
002310       END-EXEC                                                   00231000
002311       PERFORM TEST-SQLCODE                                       00231100
002312       EXIT.                                                      00231200
002313                                                                  00231300
002314******************************************************************00231400
002315* PARAGRAPHE POUR TESTER LE CODE SQL DE RETOUR ET AGIR SELON LUI *00231500
002316******************************************************************00231600
002320 TEST-SQLCODE.                                                    00232000
002400       MOVE SQLCODE TO ED-SQLCODE                                 00240000
002500       EVALUATE TRUE                                              00250000
002600           WHEN SQLCODE = ZERO                                    00260000
002700                 CONTINUE                                         00270000
002800           WHEN SQLCODE > ZERO                                    00280000
002900               IF SQLCODE = +100                                  00290000
003000                     CONTINUE                                     00300000
003100               ELSE                                               00310000
003200                     DISPLAY 'WARNING : ' ED-SQLCODE              00320000
003300               END-IF                                             00330000
003400           WHEN OTHER                                             00340000
003500               PERFORM 900-ABEND-PROG                             00350000
003600       END-EVALUATE.                                              00360000
003610                                                                  00361000
003620******************************************************************00362000
003630* PARAGRAPHE APPELER EN CAS D'ANOMALIE POUR ARRETER LE PROGRAMME *00363000
003640******************************************************************00364000
003800 900-ABEND-PROG.                                                  00380000
003810       DISPLAY 'SQLCODE : ' ED-SQLCODE                            00381000
003900       DISPLAY 'ANOMALIE GRAVE !'                                 00390000
004000       COMPUTE WS-ANO = 1 / WS-ANO.                               00400000
