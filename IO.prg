*~p9t24n70fkd0g2w1z1x12l5h;
*=======================================================*
*	進  銷	月  報	表				*
*				輸  入	程  式		*
*							*
*						  J.W.L	*
*=======================================================*
set echo off
set talk off
close all
clear
*
store month(date()) to 月份
store space(2) to 月,下月
select A
use FULIE index	FULIE
*
@ 10,15	say "欲 輸 入 何 月 份 之 進 銷 存 月 報 表 ? ..... " get 月份 picture "99" range 1,12
read
月 = ltrim(str(月份))
下月 = iif(月份	= 12,"1",ltrim(str(月份	+ 1)))
select B
use IO&月 index	IO&月
reindex
go top
clear
*
store 0000 to 暫上存數,暫本進數,暫本銷數,暫本存數
store 000.00 to	暫上存價,暫本進價,暫本銷價,暫本存價
store 00000.00 to 上存金額,本進金額,本銷金額,本存金額,差價金額
store space(5) to 項
*
do while 項 # "00000"
  @2,14	say "國軍第六二三營區福利站八十一年度 "	+ 月 + " 月福利品進銷存資料"
  @7,7 say "結束： 00000"
  項 = space(5)
  do while len(trim(項)) # 5
    @5,5 say "項  次："	get 項 picture "99999"
    read
  enddo
  select A
  seek 項
  if found()
    @5,25 say A->品名規格
    select B
    seek 項
    if .not. found()
      append blank
    endif
    @ 10,25 clear to 16,55
*
    @ 7,25 say "數量"
    @ 7,35 say "單價"
    @ 7,45 say "金額"
    @ 10,5 say "上月存貨"
    @ 12,5 say "本月進貨"
    @ 14,5 say "本月存貨"
    @ 16,5 say "本月銷貨"
    暫上存數 = 上存數
    暫上存價 = 上存價
    暫本進數 = 本進數
    暫本進價 = 本進價
    暫本銷數 = 本銷數
    暫本銷價 = 本銷價
    暫本存數 = 本存數
    暫本存價 = 本存價
 *
    @ 10,25 get	暫上存數 picture "####"
    @ 10,35 get	暫上存價 picture "###.##"
    read
    暫本進價 = 暫上存價
    暫本存價 = 暫上存價
    上存金額 = 暫上存數	* 暫上存價
    @ 10,45 say	transform(上存金額,"#####.##")
*
    @ 12,25 get	暫本進數 picture "####"
    @ 12,35 get	暫本進價 picture "###.##"
    read
    本進金額 = 暫本進數	* 暫本進價
    @ 12,45 say	transform(本進金額,"#####.##")
*
    @ 14,25 get	暫本存數 picture "####"
    @ 14,35 say	transform(暫本存價,"###.##")
    read
    本存金額 = 暫本存數	* 暫本存價
    @ 14,45 say	transform(本存金額,"#####.##")
*
    暫本銷數 = 暫上存數	+ 暫本進數 - 暫本存數
    @ 16,25 say	transform(暫本銷數,"####")
    @ 16,35 get	暫本銷價 picture "###.##"
    read
    本銷金額 = 暫本銷數	* 暫本銷價
    @ 16,45 say	transform(本銷金額,"#####.##")
*
    replace 項次 with 項
    replace 上存數 with	暫上存數,上存價	with 暫上存價,本進數 with 暫本進數,本銷數 with 暫本銷數
    replace 本進價 with	暫本進價,本銷價	with 暫本銷價,本存數 with 暫本存數,本存價 with 暫本存價
    skip
  endif
enddo
*
store .N. to 要複製
@23,24 say "要 複 製 出 下 月 資 料 嗎 ? (T/F) " get 要複製
read
if 要複製
  select b
  use io&月
  copy to io&下月
  use io&下月
  replace all 上存數 with 本存數,上存價	with 本存價,本進數 with	0,本銷數 with 0,本進價 with 0,本銷價 with 0,本存數 with	0,本存價 with 0
  index	on 項次	to IO&下月
endif
*
select a
close all
cancel

