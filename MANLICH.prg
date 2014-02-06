SET TALK OFF
SET ECHO OFF
SET STEP OFF
SET EXACT ON
SET ESCAPE OFF
SET DATE ANSI
CLEAR ALL
*
CLEAR
@ 8,22 SAY "請  輸  入  您  的  密  碼 .... "
STORE 0 TO KeyNum
STORE "" TO MPassCode
DO WHILE KeyNum # 13
  KeyNum = 0
  DO WHILE KeyNum = 0
    KeyNum = INKEY()
  ENDDO
  IF KeyNum # 13
    ?? CHR(42)
    MPassCode = MPassCode + CHR(KeyNum)
  ENDIF
ENDDO
*
SELECT 2
STORE SPACE(15) TO Path
DO WHILE .NOT. FILE(TRIM(Path) + "people.DBF")
  @ 12,22 SAY "請 輸 入 檔 案 所 在 路 徑 ...." GET Path
  READ
ENDDO
USE &Path.people.DBF
SELECT 1
IF .NOT. FILE(TRIM(Path) + "code.DBF")
  @ 14,22 SAY "所 輸 入 之 檔 案 路 徑 錯 誤 !!"
  ?? CHR(7)
  CANCEL
ELSE
  USE &Path.code.DBF
ENDIF
*
GO TOP
LOCATE FOR MPassCode = TRIM(PassCode)
IF .NOT. FOUND()
  CLOSE DATABASES
  CLEAR ALL
  CANCEL
ENDIF
NLevel = level
SELECT 2
@ 14,15 SAY "資 料 範 圍 ： 全 聯 隊"
@ 16,15 SAY "密 碼 功 能 ： 查 詢 、 替 換 （ 本 級 ）"
@ 18,15 SAY "人 事 功 能 ： 查 詢 、 列 示 、 增 添 、 替 換 、 刪 除"
DO CASE
  CASE NLevel = 1
    @ 16,46 SAY " （１～６ 級）"
  CASE NLevel = 2
    @ 18,44 SAY SPACE(27)                     
  CASE NLevel = 3
    @ 18,30 SAY SPACE(18)
  CASE NLevel = 4
    SET FILTER TO unit = "八大"
    @ 14,30 SAY "八 大"
  CASE NLevel = 5
    SET FILTER TO unit = "修大"
    @ 14,30 SAY "修 大"
  CASE NLevel = 6
    SET FILTER TO unit = "基大"
    @ 14,30 SAY "基 大"
ENDCASE
@ 21,30 SAY "請按任一鍵繼續 ....."
WAIT ""
*
Item = 2
Ending = .F.
DO WHILE .NOT. Ending
  CLEAR
  @ 3,25 SAY "======= 作   業   選   單 ======="
  @ 6,28 SAY "(1) 密   碼   作   業"
  @ 9,28 SAY "(2) 人   事   資   料   作   業"
  @ 12,28 SAY "(0) 結   束"
  @ 17,28 SAY "請 鍵 入 您 的 選 項 .... " GET Item PICTURE "9" RANGE 0,2
  READ
  DO CASE
    CASE Item = 0
      Ending = .Y.
      LOOP
    CASE Item = 1
      SELECT 1
      DO codeWork
    CASE Item = 2
      SELECT 2
      DO manWork
  ENDCASE
ENDDO
CLEAR ALL
RETURN

