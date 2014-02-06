*~p9t24n73fkd0g2w1z1x8l5h;
*==============================*
* 此為 IOPRINT.PRG 之副程式    *
*==============================*

do while .not.(頁末 .or. eof())
  select A
  seek B->項次
  select B
  上存金額 = 上存數 * 上存價
  本進金額 = 本進數 * 本進價
  本銷金額 = 本銷數 * 本銷價
  本存金額 = 本存數 * 本存價
  差價金額 = 本銷金額 +	本存金額 - 上存金額 - 本進金額
  *
  if 顯示 = "S"	.or. 顯示 = "P"
    ? "║" + transform(編號 + (頁數 - 1) * 每頁項數,"####")
    ??"│" + transform(A->廠商名稱,"XXXXXXXX")
    if len(trim(A->品名規格)) >	24
      ??"│~d4;" + transform(A->品名規格,"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX") + space(12) + "~D0;"
    else
      ??"│" + transform(A->品名規格,"XXXXXXXXXXXXXXXXXXXXXXXX")
    endif
    ??"│" + transform(A->單位,"XX")
    ??"║" + transform(上存數,"####") +	"│" + transform(上存價,"###.##") + "│" + transform(上存金額,"#####.##")
    ??"║" + transform(本進數,"####") +	"│" + transform(本進價,"###.##") + "│" + transform(本進金額,"#####.##")
    ??"║" + transform(本銷數,"####") +	"│" + transform(本銷價,"###.##") + "│" + transform(本銷金額,"#####.##")
    ??"║" + transform(本存數,"####") +	"│" + transform(本存價,"###.##") + "│" + transform(本存金額,"#####.##")
    ??"║" + transform(差價金額,"#####.##") + "║"
  endif
  *
  skip
  編號 = 編號 +	1
  頁末 = 編號 >	每頁項數
  if 顯示 = "S"	.or. 顯示 = "P"
    if 頁末 .or. eof()
      ?"╟──┴────┴────────────┴─╫──┴───┴────╫──┴───┴────╫──┴───┴────╫──┴───┴────╫────╢"
    else
      ?"╟──┼────┼────────────┼─╫──┼───┼────╫──┼───┼────╫──┼───┼────╫──┼───┼────╫────╢"
    endif
  endif
  *
  上存合計 = 上存合計 +	上存金額
  本進合計 = 本進合計 +	本進金額
  本銷合計 = 本銷合計 +	本銷金額
  本存合計 = 本存合計 +	本存金額
  差價合計 = 差價合計 +	差價金額
  *
enddo

