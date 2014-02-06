ExitKey = READKEY()
ItemPass = .Y.
DO CASE
  CASE ExitKey = 271 .OR. ExitKey = 15
    IF (NLevel=4 .AND. MUnit#"八大") .OR. (NLevel=5 .AND. MUnit#"修大")  
      .OR. (NLevel = 6 .AND. MUnit # "基大")
      FineItem = "運用"
      ItemPass = .N.
    ENDIF
    DO CASE
      CASE FineItem = "查詢" .AND. NLevel # 3
        GO TOP
        LOCATE FOR name = MName .OR. armNumber = MArmNumber
        ItemPass = FOUND()
      CASE FineItem = "列示" .AND. NLevel # 3
        @ 4,2 CLEAR TO 19,77
@ 7,9 SAY "（１）：  階級，單位，職稱，姓名，兵籍號碼，入伍日期，預退日期"
@ 9,9 SAY "（２）：（１），梯次，調入日期，軍事專長，民間專長"
@ 11,9 SAY "（３）：（１），出生日期，戶籍，現在住址，電話"
@ 13,9 SAY "（４）：（１），（２），（３）"
@ 16,29 SAY "請鍵入欲列示的選項 ....." GET ListItem PICTURE "9" RANGE 1,4
        READ
        @ 4,0 CLEAR TO 21,79
        DO CASE
          CASE ListItem = 1
            LIST grade,unit,subunit,title,name,armNumber,inday,outday FOR 
                 grade = MGrade .AND. unit = MUnit
          CASE ListItem = 2
          CASE ListItem = 3
        ENDCASE
      CASE (FineItem = "增添" .OR. FineItem = "替換") .AND. NLevel # 2
        IF FineItem = "增添"
          APPEND BLANK
        ELSE
          LOCATE FOR name = MName .OR. armNumber = MArmNumber
          ItemPass = FOUND()
        ENDIF
        IF ItemPass
          REPLACE grade WITH MGrade,unit WITH MUnit,subunit WITH MSubunit
          REPLACE title WITH MTitle,name WITH MName,armNumber WITH MArmNumber
          REPLACE birthday WITH MBirthday,military WITH MMilitary
          REPLACE folk WITH MFolk,inDay WITH MInDay,outDay WITH MOutDay
       REPLACE wave WITH MWave,hereday WITH MHereDay,formalAdd WITH MFormalAdd
          REPLACE currentAdd WITH MCurrentAdd,telephone WITH MTelephone
        ENDIF
        IF FineItem = "增添"
          SKIP
        ENDIF
      CASE FineItem = "刪除" .AND. NLevel # 2
        GO TOP
        LOCATE FOR name = MName .OR. armNumber = MArmNumber
        IF FOUND()
          DELETE
        ELSE
          ItemPass = .N.
        ENDIF
      OTHERWISE
        ItemPass = .N.
    ENDCASE
    IF .NOT. ItemPass
      @ 22,14 SAY "無法" + FineItem + "到資料 !!"
      @ 22,48 SAY "請按任一鍵繼續 ....." 
      WAIT ""
      @ 22,14 CLEAR TO 22,66
    ENDIF
  CASE ExitKey = 6
    IF RECNO() = 1
      GO BOTTOM
    ELSE
      SKIP -1
    ENDIF
  CASE ExitKey = 7
    IF EOF()
      GO TOP
    ELSE
      SKIP
    ENDIF
  CASE ExitKey = 12
    KeepItem = "否"
ENDCASE


