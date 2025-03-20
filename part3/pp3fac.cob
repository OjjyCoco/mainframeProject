000100 IDENTIFICATION DIVISION.                                         00010000
000200 PROGRAM-ID.        PJPART3B.                                     00020000
000210 AUTHOR.            GAYLORD.                                      00021000
000220 INSTALLATION.      AJC.                                          00022000
000230 DATE-WRITTEN.      13/02/2025.                                   00023000
000240 DATE-COMPILED.                                                   00024000
000250 SECURITY.          COMMENTAIRES.                                 00025000
000260                                                                  00026000
000270 ENVIRONMENT DIVISION.                                            00027000
000410 INPUT-OUTPUT SECTION.                                            00041000
000420 FILE-CONTROL.                                                    00042000
000430      SELECT EXT ASSIGN TO EXTRACT                                00043000
000440      ORGANIZATION  IS SEQUENTIAL.                                00044000
000441      SELECT FAC ASSIGN TO FACTURE                                00044100
000442      ORGANIZATION  IS SEQUENTIAL.                                00044200
000459                                                                  00045900
000460***********************************************                   00046000
000500 DATA DIVISION.                                                   00050000
000600 FILE SECTION.                                                    00060000
000700 FD EXT.                                                          00070000
000800 01 ENR-EXT PIC X(277).                                           00080000
000871                                                                  00087100
000872 FD FAC.                                                          00087200
000873 01 ENR-FAC PIC X(101).                                           00087300
001100                                                                  00110000
001200 WORKING-STORAGE SECTION.                                         00120000
001201******************************************************************00120100
001202* DECLARATION DU FLAG POUR LA LECTURE DU FICHIER EXTRACT.DATA    *00120200
001203******************************************************************00120300
001210 77 FLAG-EXT    PIC 9 VALUE 0.                                    00121000
001211    88 FF-EXT VALUE 1.                                            00121100
001231                                                                  00123100
001232 77 WS-MSG      PIC X(20).                                        00123200
001233                                                                  00123300
001236******************************************************************00123600
001237* DECLARATION D'UNE VARIABLE EN CAS D'ANOMALIE                   *00123700
001238******************************************************************00123800
001239 77 WS-ANO PIC 99 VALUE ZERO.                                     00123900
001240                                                                  00124000
001241******************************************************************00124100
001242* DECLARATION D'UNE VARIABLE POUR RECUPERER LA TVA EN SYSIN      *00124200
001243******************************************************************00124300
001244 01 WS-TVA PIC 99V99.                                             00124400
001245                                                                  00124500
001310******************************************************************00131000
001320* DECLARATION DE VARIABLES POUR LES DIFFERENTS CUMULS DE FACTURE *00132000
001321******************************************************************00132100
001323 77 WS-CUMUL     PIC 9(7)V99 VALUE ZERO.                          00132300
001324 77 WS-CUMULTVA  PIC 9(7)V99 VALUE ZERO.                          00132400
001325 77 WS-CUMULCOM  PIC 9(7)V99 VALUE ZERO.                          00132500
001326 77 WS-CUMULTTC  PIC 9(7)V99 VALUE ZERO.                          00132600
001327 77 WS-SUMPROD   PIC 9(7)V99 VALUE ZERO.                          00132700
001330                                                                  00133000
001346******************************************************************00134600
001347* DECLARATION DES VARIABLES POUR LES DIFFERENTES LIGNES DU       *00134700
001348* FICHIER FACTURE TEL QUE LES INFOS CLIENT OU LA LIGNE PRODUIT   *00134800
001349******************************************************************00134900
001352 77 L-STAR      PIC X(100) VALUE ALL '*'.                         00135200
001353 77 L-VIDE      PIC X(100) VALUE ALL SPACE.                       00135300
001354                                                                  00135400
001355 01 L-BOX-CLIENT.                                                 00135500
001356    05 FILLER PIC X(50) VALUE ALL SPACES.                         00135600
001357    05 FILLER PIC X(49) VALUE ALL '*'.                            00135700
001358                                                                  00135800
001359 01 L-DATA-BOX-CLIENT.                                            00135900
001360    05 FILLER         PIC X(50) VALUE ALL SPACES.                 00136000
001361    05 FILLER         PIC X(3) VALUE '*  '.                       00136100
001362    05 ED-DATA-CLIENT PIC X(43).                                  00136200
001363    05 FILLER         PIC X(3) VALUE '  *'.                       00136300
001364                                                                  00136400
001365 01 L-DATE.                                                       00136500
001366    05 FILLER  PIC X(2) VALUE ALL SPACES.                         00136600
001367    05 ED-DATE PIC X(40).                                         00136700
001368                                                                  00136800
001369 01 L-ORDER-NUM.                                                  00136900
001370    05 FILLER PIC X(2) VALUE ALL SPACES.                          00137000
001371    05 FILLER PIC X(11) VALUE 'N° ORDER : '.                      00137100
001372    05 ED-O-NO PIC 9(3).                                          00137200
001373                                                                  00137300
001374 01 L-ORDER-DATE.                                                 00137400
001375    05 FILLER PIC X(2) VALUE ALL SPACES.                          00137500
001376    05 FILLER PIC X(13) VALUE 'ORDER DATE : '.                    00137600
001377    05 ED-O-DATE PIC X(11).                                       00137700
001378                                                                  00137800
001379 01 L-CONTACT.                                                    00137900
001380    05 FILLER     PIC X(2) VALUE ALL SPACES.                      00138000
001381    05 FILLER     PIC X(13) VALUE 'YOUR CONTACT '.                00138100
001382    05 FILLER     PIC X(23) VALUE 'WITHIN THE DEPARTEMENT '.      00138200
001383    05 ED-CONTACT PIC X(55).                                      00138300
001384                                                                  00138400
001385 01 L-BOX-PROD.                                                   00138500
001386    05 FILLER PIC X(1) VALUE ALL SPACES.                          00138600
001387    05 FILLER PIC X(98) VALUE ALL '*'.                            00138700
001388                                                                  00138800
001389 01 L-ENTETE-BOX-PROD.                                            00138900
001390    05 FILLER   PIC X(1) VALUE SPACE.                             00139000
001391    05 FILLER   PIC X(2) VALUE '* '.                              00139100
001392    05 FILLER   PIC X(11) VALUE 'N° PRODUCT '.                    00139200
001393    05 FILLER   PIC X(8) VALUE '*       '.                        00139300
001394    05 FILLER   PIC X(20) VALUE 'PRODUCT DESCRIPTION '.           00139400
001395    05 FILLER   PIC X(8) VALUE '     *  '.                        00139500
001396    05 FILLER   PIC X(17) VALUE 'PRODUCT QUANTITY '.              00139600
001397    05 FILLER   PIC X(2) VALUE '* '.                              00139700
001398    05 FILLER   PIC X(14) VALUE 'PRODUCT PRICE '.                 00139800
001399    05 FILLER   PIC X(3) VALUE ' * '.                             00139900
001400    05 FILLER   PIC X(12) VALUE 'TOTAL PRICE '.                   00140000
001410    05 FILLER   PIC X VALUE '*'.                                  00141000
001431                                                                  00143100
001432 01 L-DATA-BOX-PROD.                                              00143200
001433    05 FILLER   PIC X(1) VALUE SPACE.                             00143300
001434    05 FILLER   PIC X(2) VALUE '* '.                              00143400
001435    05 ED-P-NO  PIC X(3).                                         00143500
001436    05 FILLER   PIC X(8) VALUE ALL SPACES.                        00143600
001437    05 FILLER   PIC X(2) VALUE '* '.                              00143700
001439    05 ED-DESC  PIC X(30).                                        00143900
001440    05 FILLER   PIC X(3) VALUE ' * '.                             00144000
001441    05 ED-QUANT PIC 9(2).                                         00144100
001442    05 FILLER   PIC X(16) VALUE ALL SPACES.                       00144200
001443    05 FILLER   PIC X(2) VALUE '* '.                              00144300
001444    05 ED-PRICE PIC $$$B$$9.99.                                   00144400
001445    05 FILLER   PIC X(5) VALUE ALL SPACES.                        00144500
001446    05 FILLER   PIC X VALUE '*'.                                  00144600
001447    05 ED-SUMP  PIC $$B$$$B$$9.99.                                00144700
001448    05 FILLER   PIC X VALUE '*'.                                  00144800
001449                                                                  00144900
001450 01 L-TOTAL.                                                      00145000
001451    05 FILLER   PIC X(64) VALUE SPACE.                            00145100
001452    05 ED-TOTAL PIC X(19).                                        00145200
001453    05 FILLER   PIC X(2) VALUE SPACE.                             00145300
001454    05 ED-CUMUL PIC $$B$$$B$$9.99.                                00145400
001455                                                                  00145500
001456******************************************************************00145600
001457* DECLARATION D'UNE VARIABLE POUR LA RECUPERATION DE LA DATE     *00145700
001458* GRACE A UN SOUS PROGRAMME                                      *00145800
001459******************************************************************00145900
001460 77 WS-DATE PIC X(40).                                            00146000
001461                                                                  00146100
001463******************************************************************00146300
001464* DECLARATION D'UNE VARIABLE POUR L'AFFICHAGE DE LA TVA ET COM   *00146400
001465******************************************************************00146500
001466 77 ED-TVA PIC Z9.99.                                             00146600
001467 77 ED-COM PIC 9.99.                                              00146700
001468                                                                  00146800
001469******************************************************************00146900
001470* DECLARATION DE VARIABLES POUR RECUPERER LES INFORMATIONS POUR  *00147000
001471* LA FACTURE TELLE QUE LE NOM DU CLIENT OU LES PRODUITS          *00147100
001472******************************************************************00147200
001473 01 L-EXT.                                                        00147300
001474      05 WS-O-NO        PIC 9(3).                                 00147400
001475      05 WS-O-DATE      PIC X(11).                                00147500
001476      05 WS-COMPANY     PIC X(30).                                00147600
001477      05 WS-ADDRESS     PIC X(100).                               00147700
001478      05 WS-CITY        PIC X(20).                                00147800
001479      05 WS-ZIP         PIC X(5).                                 00147900
001480      05 WS-STATE       PIC X(2).                                 00148000
001482      05 WS-DNAME       PIC X(20).                                00148200
001483      05 WS-LNAME       PIC X(20).                                00148300
001484      05 WS-FNAME       PIC X(20).                                00148400
001485      05 WS-COM         PIC 99V99.                                00148500
001487      05 WS-P-NO        PIC X(3).                                 00148700
001488      05 WS-DESCRIPTION PIC X(30).                                00148800
001489      05 WS-QUANTITY    PIC 99.                                   00148900
001490      05 WS-PRICE       PIC 9(5)V99.                              00149000
001491                                                                  00149100
001492 77 WS-CUR-ORD PIC 9(3).                                          00149200
001493                                                                  00149300
001494 77 WS-CONTACT PIC X(55).                                         00149400
001495                                                                  00149500
001496 PROCEDURE DIVISION.                                              00149600
001497                                                                  00149700
001498     OPEN INPUT EXT                                               00149800
001499     MOVE 'FICHIER EXT VIDE !' TO WS-MSG                          00149900
001500     PERFORM 200-READ-EXT                                         00150000
001501                                                                  00150100
001502     OPEN OUTPUT FAC                                              00150200
001503                                                                  00150300
001504     ACCEPT WS-TVA FROM SYSIN                                     00150400
001510                                                                  00151000
001600     PERFORM 300-WRITE-ALL-FAC UNTIL FF-EXT                       00160000
002735                                                                  00273500
002736     CLOSE EXT                                                    00273600
002737     CLOSE FAC                                                    00273700
002738                                                                  00273800
002743     GOBACK.                                                      00274300
002744                                                                  00274400
002745******************************************************************00274500
002746* PARAGRAPHE POUR LA LECTURE DU FICHIER EXTRACT                  *00274600
002747******************************************************************00274700
002748 200-READ-EXT.                                                    00274800
002749     READ EXT AT END                                              00274900
002750          SET FF-EXT TO TRUE                                      00275000
002751          DISPLAY WS-MSG                                          00275100
002753     END-READ                                                     00275300
002755     INITIALIZE L-EXT                                             00275500
002756     MOVE ENR-EXT TO L-EXT                                        00275600
002760     EXIT.                                                        00276000
002761                                                                  00276100
002762******************************************************************00276200
002763* PARAGRAPHES POUR L'ECRITURE DES FACTURES                       *00276300
002764******************************************************************00276400
002765 300-WRITE-ALL-FAC.                                               00276500
002767     MOVE WS-O-NO TO WS-CUR-ORD                                   00276700
002768     PERFORM 320-WRITE-CUST-INFO                                  00276800
002769     PERFORM 330-WRITE-DATE                                       00276900
002770     PERFORM 340-WRITE-ORD-INFO                                   00277000
002771     PERFORM 350-WRITE-EMP-INFO                                   00277100
002780     PERFORM 360-WRITE-PROD                                       00278000
002781     PERFORM 370-WRITE-TOTAL                                      00278100
002791     IF FF-EXT THEN                                               00279100
002792        WRITE ENR-FAC FROM L-VIDE                                 00279200
002793     ELSE                                                         00279300
002794        WRITE ENR-FAC FROM L-VIDE BEFORE ADVANCING PAGE           00279400
002795     END-IF                                                       00279500
002800     EXIT.                                                        00280000
002810                                                                  00281000
002811******************************************************************00281100
002812* PARAGRAPHE POUR RECUPERER LES INFORMATIONS GENERALE D'UNE      *00281200
002813* FACTURE DANS UNE VARIABLE                                      *00281300
002814******************************************************************00281400
002820 310-GET-EXT-DATA.                                                00282000
002821      INITIALIZE L-EXT                                            00282100
002830      MOVE ENR-EXT TO L-EXT                                       00283000
002840      EXIT.                                                       00284000
002850                                                                  00285000
002860 320-WRITE-CUST-INFO.                                             00286000
002870      WRITE ENR-FAC FROM L-BOX-CLIENT                             00287000
002871      MOVE WS-COMPANY TO ED-DATA-CLIENT                           00287100
002880      WRITE ENR-FAC FROM L-DATA-BOX-CLIENT                        00288000
002890      MOVE WS-ADDRESS TO ED-DATA-CLIENT                           00289000
002891      WRITE ENR-FAC FROM L-DATA-BOX-CLIENT                        00289100
002892      MOVE WS-CITY    TO ED-DATA-CLIENT                           00289200
002893      WRITE ENR-FAC FROM L-DATA-BOX-CLIENT                        00289300
002894      MOVE WS-STATE   TO ED-DATA-CLIENT                           00289400
002895      WRITE ENR-FAC FROM L-DATA-BOX-CLIENT                        00289500
002896      WRITE ENR-FAC FROM L-BOX-CLIENT                             00289600
002897      EXIT.                                                       00289700
002900                                                                  00290000
004084******************************************************************00408400
004085* PARAGRAPHE POUR APPELER UN SOUS PROGRAMME AFIN DE RECUPERER    *00408500
004086* LA DATE DU JOUR ET DE LE METTRE SOUS UN BON FORMAT             *00408600
004087******************************************************************00408700
004088 330-WRITE-DATE.                                                  00408800
004090      CALL 'PJPT3BSS' USING BY REFERENCE WS-DATE                  00409000
004092                                                                  00409200
004093      MOVE WS-DATE TO ED-DATE                                     00409300
004094      WRITE ENR-FAC FROM L-DATE                                   00409400
004097      EXIT.                                                       00409700
004098                                                                  00409800
004099 340-WRITE-ORD-INFO.                                              00409900
004100     INITIALIZE L-ORDER-NUM                                       00410000
004101     INITIALIZE L-ORDER-DATE                                      00410100
004102     MOVE WS-O-NO TO ED-O-NO                                      00410200
004110     WRITE ENR-FAC FROM L-ORDER-NUM                               00411000
004120     MOVE WS-O-DATE TO ED-O-DATE                                  00412000
004200     WRITE ENR-FAC FROM L-ORDER-DATE                              00420000
004210     EXIT.                                                        00421000
004220                                                                  00422000
004230 350-WRITE-EMP-INFO.                                              00423000
004231     INITIALIZE L-CONTACT                                         00423100
004232     STRING                                                       00423200
004233        WS-DNAME DELIMITED BY SPACES                              00423301
004234        ':'    DELIMITED BY SIZE                                  00423402
004235        WS-LNAME DELIMITED BY SPACES                              00423501
004236        ','     DELIMITED BY SIZE                                 00423602
004237        WS-FNAME DELIMITED BY SPACES                              00423701
004238        INTO WS-CONTACT                                           00423800
004239     END-STRING                                                   00423900
004240     MOVE WS-CONTACT TO ED-CONTACT                                00424000
004270     WRITE ENR-FAC FROM L-CONTACT                                 00427000
004271     MOVE SPACE TO WS-CONTACT                                     00427100
004280     EXIT.                                                        00428000
004281                                                                  00428100
004282 360-WRITE-PROD.                                                  00428200
004283     PERFORM 500-REINIT-TOTAL                                     00428300
004286     WRITE ENR-FAC FROM L-BOX-PROD                                00428600
004287     WRITE ENR-FAC FROM L-ENTETE-BOX-PROD                         00428700
004288     PERFORM 361-WRITE-LINE-PROD UNTIL WS-O-NO NOT = WS-CUR-ORD   00428800
004289               OR FF-EXT                                          00428900
004290     WRITE ENR-FAC FROM L-BOX-PROD                                00429000
004291     EXIT.                                                        00429100
004292                                                                  00429200
004293 361-WRITE-LINE-PROD.                                             00429300
004294     INITIALIZE L-DATA-BOX-PROD                                   00429400
004296     MOVE WS-P-NO TO ED-P-NO                                      00429600
004297     MOVE WS-DESCRIPTION TO ED-DESC                               00429700
004298     MOVE WS-QUANTITY TO ED-QUANT                                 00429800
004299     MOVE WS-PRICE TO ED-PRICE                                    00429900
004300     COMPUTE WS-SUMPROD = WS-QUANTITY * WS-PRICE                  00430000
004301     MOVE WS-SUMPROD TO ED-SUMP                                   00430100
004302     WRITE ENR-FAC FROM L-DATA-BOX-PROD                           00430200
004303     ADD WS-SUMPROD TO WS-CUMUL                                   00430300
004304     PERFORM 200-READ-EXT                                         00430400
004309     EXIT.                                                        00430900
004310                                                                  00431000
004311******************************************************************00431100
004312* PARAGRAPHE POUR REINITIALISER LES CUMUL D'UNE FACTURE          *00431200
004313******************************************************************00431300
004314 500-REINIT-TOTAL.                                                00431400
004315     INITIALIZE WS-CUMUL                                          00431500
004316     INITIALIZE WS-CUMULTVA                                       00431600
004317     INITIALIZE WS-CUMULCOM                                       00431700
004318     INITIALIZE WS-CUMULTTC                                       00431800
004319     EXIT.                                                        00431900
004320                                                                  00432000
004321******************************************************************00432100
004322* PARAGRAPHE POUR L'ECRITURE DES CUMULS D'UNE FACTURE            *00432200
004323******************************************************************00432300
004328 370-WRITE-TOTAL.                                                 00432800
004329     MOVE WS-CUMUL TO ED-CUMUL                                    00432900
004330     MOVE 'SUB TOTAL' TO ED-TOTAL                                 00433000
004331     WRITE ENR-FAC FROM L-TOTAL                                   00433100
004332                                                                  00433200
004333     COMPUTE WS-CUMULTVA = (WS-TVA / 100) * WS-CUMUL              00433300
004334     MOVE WS-CUMULTVA TO ED-CUMUL                                 00433400
004335     MOVE WS-TVA TO ED-TVA                                        00433500
004336     STRING                                                       00433600
004337        'SALEE TAX (' DELIMITED BY SIZE                           00433700
004338        ED-TVA DELIMITED BY SIZE                                  00433800
004339        '%)'   DELIMITED BY SIZE                                  00433900
004340        INTO ED-TOTAL                                             00434000
004341     END-STRING                                                   00434100
004342     WRITE ENR-FAC FROM L-TOTAL                                   00434200
004343                                                                  00434300
004344     COMPUTE WS-CUMULCOM = WS-COM * WS-CUMUL                      00434400
004345     MOVE WS-CUMULCOM TO ED-CUMUL                                 00434500
004346     COMPUTE ED-COM = WS-COM * 100                                00434600
004347     STRING                                                       00434700
004348        'COMMISSION (' DELIMITED BY SIZE                          00434800
004349        ED-COM DELIMITED BY SIZE                                  00434900
004350        '%)'   DELIMITED BY SIZE                                  00435000
004351        INTO ED-TOTAL                                             00435100
004352     END-STRING                                                   00435200
004353     WRITE ENR-FAC FROM L-TOTAL                                   00435300
004354                                                                  00435400
004355     COMPUTE WS-CUMULTTC = WS-CUMUL + WS-CUMULTVA                 00435500
004356     MOVE WS-CUMULTTC TO ED-CUMUL                                 00435600
004357     MOVE 'TOTAL' TO ED-TOTAL                                     00435700
004358     WRITE ENR-FAC FROM L-TOTAL                                   00435800
004359     EXIT.                                                        00435900
004360                                                                  00436000
004370******************************************************************00437000
004380* PARAGRAPHE POUR LE CAS OU UNE ANOMALIE EST DETECTER DE METTRE  *00438000
004381* FIN AU PROGRAMME EN EFFECTUANT UNE DIVISION PAR ZERO           *00438100
004390******************************************************************00439000
004400 ABEND-PROG.                                                      00440000
004500     DISPLAY 'ABEND-PROG !'                                       00450000
004600     COMPUTE WS-ANO = 1 / WS-ANO.                                 00460000
