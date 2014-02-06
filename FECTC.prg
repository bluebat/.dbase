CLEAR
SET BELL OFF
SET ECHO OFF
SET TALK OFF
SET PROCEDURE TO FECTC.PRG
PUBL B1,B2,B3,B4,B5,B6,B7,B8,B9,B10,B11,B12,B13,B14,B15,B16
USE  YY  INDEX  YY1,YY2

TEXT
┌─────┬────────────┬──────┬───────────┐
│[1] 料  號│                        │[9]  名  稱 │                      │
├─────┼────────────┼──────┼───────────┤
│[2] 件  號│                        │[10] 說  明 │                      │
├─────┼────────────┼──────┼───────────┤
│[3] 技  令│                        │[11]存放位置│                      │
├─────┼────────────┼──────┼───────────┤
│[4] 版  期│                        │[12] 結   存│                      │
├─────┼────────────┼──────┼───────────┤
│[5] 圖  號│                        │[13] 本   性│                      │
├─────┼────────────┼──────┼───────────┤
│[6] 頁  次│                        │[14] 單   位│                      │
├─────┼────────────┼──────┼───────────┤
│[7] 廠  代│                        │[15]系統代號│                      │
├─────┼────────────┼──────┼───────────┤
│[8] 單  價│                        │[16]異動日期│                      │
╞═════╧════════════╧══════╧═══════════╡
│                                                                          │
│                                                    紀錄狀態 ：           │
╞═════════════════════════════════════╡
│0 結束  1 上筆  2 下筆  3 增添  4 查詢  5 更正  6 刪除  7 重整  ======>   │
└─────────────────────────────────────┘
ENDTEXT
DO SAYA
A17 = 2

DO WHILE A17 <> 0
@ 18,2 CLEAR TO 19,53
@ 21,74 GET A17 PICTURE '9' RANGE 0,7
READ

DO CASE
   CASE  A17 = 0
     CLEAR
     @ 10,20 SAY 'BY-BY  結束作業  GOOD LUCKY'
   CASE  A17 = 1
      @ 19,5 SAY '==看上一筆=='
      SKIP -1
      IF BOF()
        GO BOTTOM
      ENDIF
      DO SAYA
   CASE  A17  =2
      @ 19,5 SAY '==看下一筆=='
      SKIP
      IF EOF()
        GO TOP
      ENDIF
      DO SAYA
   CASE  A17 =3
      @ 19 ,5 SAY '==增添一筆=='
      APPEND BLANK
      DO SETB
      DO GETB
      DO SETA
      DO SAYA
  CASE A17 = 4
     @ 19 ,5 SAY '==查詢某筆=='
     NOWNO = RECNO()
     ISFOUND = .F.
     FK = 1
     DO WHILE .NOT. ISFOUND
       @ 18,2 SAY '您欲以何欄查詢(1.料號 2.件號 0.取消):_' GET FK PICTURE '9' RANGE 0,2
       READ
       DO CASE
         CASE FK = 0
           ISFOUND = .T.
         CASE FK = 1
           @ 2,14 GET B1
           READ
           SET ORDER TO 1
           SEEK B1
           ISFOUND =  FOUND()
           IF .NOT. ISFOUND
             @ 19,22 SAY '沒找到 !!'
             GO NOWNO
           ENDIF
         CASE FK = 2
           @ 4,14 GET B2
           READ
           SET ORDER TO 2
           SEEK B2
           ISFOUND =  FOUND()
           IF .NOT. ISFOUND
             @ 19,22 SAY '沒找到 !!'
             GO NOWNO
           ENDIF
       ENDCASE
     ENDDO
     DO SAYA
  CASE A17 = 5
     @ 19,5 SAY '==更正此筆=='
     DO SETB
     DO GETB
     DO SETA
     DO SAYA
  CASE A17 = 6
     @ 19,5 SAY '==刪除此筆=='
     DELETE
     DO SAYA
  CASE A17 = 7
     @ 19,5 SAY '==檔案重整=='
     PACK
     REINDEX
     DO SAYA
ENDCASE

ENDDO
RETURN
*=======================================================

*==============================================
PROCEDURE SAYA
   @ 2  ,14       SAY A1
   @ 4  ,14       SAY A2
   @ 6  ,14       SAY A3
   @ 8  ,14       SAY A4
   @ 10 ,14       SAY A5
   @ 12 ,14       SAY A6
   @ 14 ,14       SAY A7
   @ 16 ,14       SAY A8
   @ 2  ,54       SAY A9
   @ 4  ,54       SAY A10
   @ 6  ,54       SAY A11
   @ 8  ,54       SAY A12
   @ 10 ,54       SAY A13
   @ 12 ,54       SAY A14
   @ 14 ,54       SAY A15
   @ 16 ,54       SAY A16
   @ 19 ,67       SAY IIF(DELETE(),'已刪除','未刪除')
RETURN
*=========================================

*==============================================
PROCEDURE SETB
   B1   =  A1
   B2   =  A2
   B3   =  A3
   B4   =  A4
   B5   =  A5
   B6   =  A6
   B7   =  A7
   B8   =  A8
   B9   =  A9
   B10  =  A10
   B11  =  A11
   B12  =  A12
   B13  =  A13
   B14  =  A14
   B15  =  A15
   B16  =  A16
RETURN
*=========================================

*==============================================
PROCEDURE GETB
   @ 2  ,14       GET B1
   @ 4  ,14       GET B2
   @ 6  ,14       GET B3
   @ 8  ,14       GET B4
   @ 10 ,14       GET B5
   @ 12 ,14       GET B6
   @ 14 ,14       GET B7
   @ 16 ,14       GET B8
   @ 2  ,54       GET B9
   @ 4  ,54       GET B10
   @ 6  ,54       GET B11
   @ 8  ,54       GET B12
   @ 10 ,54       GET B13
   @ 12 ,54       GET B14
   @ 14 ,54       GET B15
   @ 16 ,54       GET B16
   READ
RETURN
*=========================================

*=========================================
PROCEDURE SETA
  REPLACE A1 WITH B1, A2 WITH B2, A3 WITH B3, A4 WITH B4, A5 WITH B5, A6 WITH B6
  REPLACE A7 WITH B7, A8 WITH B8, A9 WITH B9, A10 WITH B10, A11 WITH B11
  REPLACE A12 WITH B12, A13 WITH B13, A14 WITH B14, A15 WITH B15, A16 WITH B16
RETURN
*=========================================




