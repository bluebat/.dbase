STORE NLevel TO MLevel
STORE "查詢" TO FineItem
STORE "是" TO KeepItem
CLEAR
@ 2,28 SAY "空軍聯隊人事密碼"
@ 3,2 TO 22,76
@ 7,20 SAY "請 輸 入 欲 作 業 之 密 碼 級 別....."
DO WHILE KeepItem = "是"
  @ 11,20 CLEAR TO 20,60
  IF NLevel = 1
    @ 7,58 GET MLevel PICTURE "9" RANGE 1,6
  ELSE
    MLevel = NLevel
    @ 7,58 SAY MLevel
  ENDIF
  @ 11,20 SAY "以 上 係 用 以....( 查詢 或 替換 ) " GET FineItem
  READ
  ExitKey = READKEY()
  DO CASE
    CASE ExitKey = 15 .OR. ExitKey = 271
      IF FineItem = "查詢" .OR. FineItem = "替換"
        GO TOP
        LOCATE FOR level = MLevel  
        @ 13,20 SAY "此 級 現 設 密 碼 為 ..... " + passCode
        IF FineItem = "替換"
          MPassCode = passCode
          @ 15,20 SAY "請 輸 入 新 設 之 密 碼 ..... " GET MPassCode
          READ
          REPLACE passCode WITH MPassCode
          @ 17,20 SAY "密 碼 已 重 新 設 定 完 成 !"
        ENDIF
        @ 19,20 SAY "是 否 要 繼 續 此 一 作 業 ?" GET KeepItem
        READ
      ENDIF
    CASE ExitKey = 12
      KeepItem = "否"
    OTHERWISE
      ?? CHR(7),CHR(7)
      @ 17,20 SAY "請 以 [Enter] 鍵 確 認 可 執 行 之 選 項 !!"
      @ 20,30 SAY "請 按 任 一 鍵 繼 續 ....."     
      WAIT ""
  ENDCASE
ENDDO
RETURN
