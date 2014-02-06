  CLEAR
  GO BOTTOM
  SKIP
  STORE "增添" TO FineItem
  STORE 1 TO ListItem
  STORE "是" TO KeepItem
  @ 2,28 SAY "空軍八二八聯隊人事資料表"
  @ 3,0 TO 21,78  
  @ 24,4 SAY "[F1]__選項   [Pg Up]__前筆記錄"
  @ 24,40 SAY "[Pg Dn]__次筆記錄   [Esc]__忽略跳離"
  DO WHILE KeepItem = "是"
    MGrade = grade
    MUNIT = unit
    MSubunit = subunit
    MTitle = title
    MName = name
    MArmNumber = armNumber
    MBirthday = birthday
    MInDay = inDay
    MOutDay = outDay
    MHereDay = hereDay
    MMilitary = military
    MFolk = folk
    MWave = wave
    MFormalAdd = formalAdd
    MCurrentAdd = currentAdd
    MTelephone = telephone
    *
    IF .NOT. DELETED()
      RecordMode = IIF(RECNO() > RECCOUNT(),"未儲存",SPACE(6))
    ELSE
      RecordMode = "已刪除"
    ENDIF
    @ 2,59 SAY RecordMode
    @ 2,65 SAY RECNO()
    @ 5,4 SAY "姓    名" GET MName
    @ 5,57 SAY "兵籍號碼" GET MArmNumber
    @ 7,4 SAY "階    級" GET MGrade
    @ 7,30 SAY "單位" GET MUnit
    @ 7,40 GET MSubunit
    @ 7,58 SAY "職    稱" GET MTitle
    @ 9,4 SAY "出生日期" GET MBirthday
    @ 9,54 SAY "梯次" GET MWave
    @ 11,4 SAY "入伍日期" GET MInDay
    @ 11,30 SAY "預退日期" GET MOutDay
    @ 11,58 SAY "調入日期" GET MHereDay
    @ 13,4 SAY "軍事專長" GET MMilitary
    @ 13,46 SAY "民間專長" GET MFolk
    @ 15,4 SAY "住址" GET MCurrentAdd
    @ 15,59 SAY "電話" GET MTelephone PICTURE "(99)9999999"
    @ 17,4 SAY "戶    籍" GET MFormalAdd
    @ 19,4 SAY "以上資料係用以....." GET FineItem
    @ 19,49 SAY "是否繼續使用此畫面....." GET KeepItem
    READ
    DO MANCASE
  ENDDO
  PACK
  RETURN
