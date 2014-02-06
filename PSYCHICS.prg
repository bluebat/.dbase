SET TALK OFF
SET BELL OFF
SET SCOREBOARD OFF
SET MENU ON
CLEAR ALL
CLEAR
*
STORE SPACE(20) TO FilePath    && 檔案所在路徑，須以'\'結尾
STORE SPACE(8) TO MainName     && 資料檔主檔名，勿用psychics
STORE SPACE(28) TO FileName    && 資料檔完整名稱
STORE .T. TO NoFile, NewOne    && 判別新檔是否建立
STORE 1 TO Item                && 作業選項
STORE 21 TO QuaNum             && 代表總題數，必須與資料檔結構一併修改
STORE 1 TO PageNum             && 統計表頁號
*
DO WHILE NoFile
  @ 3,5 SAY '羅哥：'
  @ 8,12 SAY '請輸入檔案所在路徑 (如: A:\ 或 B:\ ) ' GET FilePath
  @ 13,12 SAY '請輸入資料檔案名稱 (如: AT3 或 F16 ) ' GET MainName
  READ
  FileName = UPPER(FilePath - MainName - '.DBF')
  IF LEN(TRIM(FilePath)) > 0
    SET PATH TO &FilePath
  ENDIF
  IF .NOT. FILE('PSYCHICS.DBF') .OR. LEN(TRIM(MainName)) = 0
    @ 20,25 SAY '找不到! 請重新輸入路徑!'
    LOOP
  ENDIF
  USE PSYCHICS
  NoFile = .NOT. FILE(FileName)
  IF NoFile
    ?? CHR(7)
    @ 20,25 SAY '請注意! 這是一個新檔案!'
    @ 22,23 SAY '您確定要建立它嗎 ? (T/F) ' GET NewOne
    READ
    IF NewOne
      COPY TO &FileName
      NoFile = .F.
    ENDIF
  ENDIF
ENDDO
USE &FileName
*
DO WHILE Item > 0
  CLEAR
  TEXT

                       空 軍 第 八 二 八 聯 隊

                心 理 輔 導 室 問 卷 分 析 作 業  



                    =======   主   選   單   =======


        □□□□□□    1)  輸   入   編   修       □□□□□□
          □□□□□                                □□□□□
            □□□□    2)  分   類   統   計       □□□□
              □□□                                □□□
                □□    0)  結   束                 □□



                       請 按 下 您 的 選 項 ....
  ENDTEXT
  @ 19,48 GET Item PICTURE '9' RANGE 0,2
  READ
  DO CASE
    CASE Item = 0
      @ 19,22 SAY '謝 謝 您 的 使 用 ， 再 見 ！'
    CASE Item = 1
      GO TOP
      BROWSE
      PACK
    CASE Item = 2
      DataNum = RECCOUNT()
      PageNum = 1
      DO WHILE PageNum > 0
        CLEAR
        TEXT
       空 軍 第 八 二 八 聯 隊 心 理 輔 導 室 問 卷 分 析 表  
╭══════╤══╤══╤══╤══╤══╤══╤══╤══╤══╤══╮
║答案 ＼ 題號│    │    │    │    │    │    │    │    │    │    ║
╟──┬───┼──┼──┼──┼──┼──┼──┼──┼──┼──┼──╢
║ ０ │筆  數│    │    │    │    │    │    │    │    │    │    ║
║未答│百分比│    │    │    │    │    │    │    │    │    │    ║
╟──┼───┼──┼──┼──┼──┼──┼──┼──┼──┼──┼──╢
║ １ │筆  數│    │    │    │    │    │    │    │    │    │    ║
║    │百分比│    │    │    │    │    │    │    │    │    │    ║
╟──┼───┼──┼──┼──┼──┼──┼──┼──┼──┼──┼──╢
║ ２ │筆  數│    │    │    │    │    │    │    │    │    │    ║
║    │百分比│    │    │    │    │    │    │    │    │    │    ║
╟──┼───┼──┼──┼──┼──┼──┼──┼──┼──┼──┼──╢
║ ３ │筆  數│    │    │    │    │    │    │    │    │    │    ║
║    │百分比│    │    │    │    │    │    │    │    │    │    ║
╟──┼───┼──┼──┼──┼──┼──┼──┼──┼──┼──┼──╢
║ ４ │筆  數│    │    │    │    │    │    │    │    │    │    ║
║    │百分比│    │    │    │    │    │    │    │    │    │    ║
╟──┼───┼──┼──┼──┼──┼──┼──┼──┼──┼──┼──╢
║ ５ │筆  數│    │    │    │    │    │    │    │    │    │    ║
║    │百分比│    │    │    │    │    │    │    │    │    │    ║
╰══╧═══╧══╧══╧══╧══╧══╧══╧══╧══╧══╧══╯
  檔 名：                                     答題人數：          第    頁
  請 輸 入 欲 統 計 的 頁 號 ( 0 表 示 結 束)：
        ENDTEXT
        i = 1
        DO WHILE i<=10
          ii = i + (PageNum-1) * 10
          @ 3,11+i*6 SAY ii PICTURE '99'
          FieldName = Field(ii)
          j = 0
          DO WHILE j<=5
            COUNT FOR &FieldName = j TO NumOf
            @ 5+j*3,10+i*6 SAY NumOf PICTURE '9999'
            PerOf = NumOf*100/DataNum
            @ 6+j*3,10+i*6 SAY PerOf PICTURE '99.9'
            j = j + 1
          ENDDO
          i = IIF(ii = QuaNum,11,i+1)
        ENDDO
        @ 23,10 SAY FileName
        @ 23,57 SAY DataNum PICTURE '9999'
        @ 23,70 SAY PageNum PICTURE '9'
        @ 24,48 GET PageNum PICTURE '9' RANGE 0,INT(QuaNum/10)+1
        READ
     ENDDO
  ENDCASE
ENDDO
CLEAR ALL
SET BELL ON
RETURN

