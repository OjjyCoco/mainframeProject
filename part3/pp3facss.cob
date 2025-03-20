000100 IDENTIFICATION DIVISION.
000200 PROGRAM-ID.          PJPT3BSS.
000300 AUTHOR.              GAYLORD.
000400 INSTALLATION.        AJC.
000500 DATE-WRITTEN.        13/02/2025.
000600 ENVIRONMENT DIVISION.
000700 CONFIGURATION SECTION.
000800 SPECIAL-NAMES.
000900     DECIMAL-POINT IS COMMA.
001400****************************************************
001500 DATA DIVISION.
002700
002800 WORKING-STORAGE SECTION.
002810******************************************************************
002820* DECLARATION DE VARIABLES POUR RECUPERER LES DONNEES DU JOUR    *
002830******************************************************************
003605 01 WS-DATE.
003606  05 WS-AA PIC 99.
003607  05 WS-MM PIC 99.
003608  05 WS-JJ PIC 99.
003609
003610 01 WS-DAY-POS    PIC 9.
003611
003612******************************************************************
003613* DECLARATION DE VARIABLES POUR RECUPERER LE JOUR ET LE MOIS     *
003614* AFIN D'ENVOYER AU PROGRAMME PRINCIPALE LA DATE COMPLETE        *
003615******************************************************************
003616 01 WS-DAY-NAME   PIC X(9).
003617 01 WS-MONTH-NAME PIC X(9).
003618
003619 LINKAGE SECTION.
003620
003621******************************************************************
003622* DECLARATION DE VARIABLE DU PROGRAMME PRINCIPALE POUR LA DATE   *
003623******************************************************************
003624 01 LS-DATE PIC X(40).
003660
003700 PROCEDURE DIVISION USING LS-DATE.
003712
003713******************************************************************
003714* ACCEPT POUR RECUPERER LES INFORMATIONS DE LA DATE DU JOUR      *
003715******************************************************************
003716      ACCEPT WS-DATE FROM DATE
003717
003718      ACCEPT WS-DAY-POS FROM DAY-OF-WEEK
003719
003720******************************************************************
003721* EVALUATE POUR AVOIR LE JOUR ET LE MOIS EN LETTRE               *
003722******************************************************************
003723      EVALUATE WS-DAY-POS
003724          WHEN 1 MOVE 'MONDAY'    TO WS-DAY-NAME
003725          WHEN 2 MOVE 'TUESDAY'   TO WS-DAY-NAME
003726          WHEN 3 MOVE 'WEDNESDAY' TO WS-DAY-NAME
003727          WHEN 4 MOVE 'THURSDAY'  TO WS-DAY-NAME
003728          WHEN 5 MOVE 'FRIDAY'    TO WS-DAY-NAME
003729          WHEN 6 MOVE 'SATURDAY'  TO WS-DAY-NAME
003730          WHEN 7 MOVE 'SUNDAY'    TO WS-DAY-NAME
003731      END-EVALUATE
003732
003733      EVALUATE WS-MM
003734          WHEN 1  MOVE 'JANUARY'    TO WS-MONTH-NAME
003735          WHEN 2  MOVE 'FEBRUARY'   TO WS-MONTH-NAME
003736          WHEN 3  MOVE 'MARCH'      TO WS-MONTH-NAME
003737          WHEN 4  MOVE 'ARPRIL'     TO WS-MONTH-NAME
003738          WHEN 5  MOVE 'MAY'        TO WS-MONTH-NAME
003739          WHEN 6  MOVE 'JUNE'       TO WS-MONTH-NAME
003740          WHEN 7  MOVE 'JULY'       TO WS-MONTH-NAME
003741          WHEN 8  MOVE 'AUGUST'     TO WS-MONTH-NAME
003742          WHEN 9  MOVE 'SEPTEMBER'  TO WS-MONTH-NAME
003743          WHEN 10 MOVE 'OCTOBER'    TO WS-MONTH-NAME
003744          WHEN 11 MOVE 'NOVEMBER'   TO WS-MONTH-NAME
003745          WHEN 12 MOVE 'DECEMBER'   TO WS-MONTH-NAME
003746      END-EVALUATE
003747
003748******************************************************************
003749* STRING POUR AVOIR LA DATE COMPLETE AU BON FORMAT               *
003750******************************************************************
003751      STRING
003752         'NEW YORK, '  DELIMITED BY SIZE
003753         WS-DAY-NAME   DELIMITED BY SPACES
003754         ', '          DELIMITED BY SIZE
003755         WS-MONTH-NAME DELIMITED BY SPACES
003756         ' '           DELIMITED BY SIZE
003757         WS-JJ         DELIMITED BY SPACES
003758         ', 20'        DELIMITED BY SIZE
003759         WS-AA         DELIMITED BY SPACES
003760         INTO LS-DATE
003761      END-STRING
003762
003763
003770      GOBACK.
