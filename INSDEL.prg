set echo off
set talk off
store 12 to WordLen
store space(WordLen) to String
store 0 to Length, KeyVal, Number, WordSite, Random, NewNum, Score
store 24 to Delay
store 0.4 to AddVal
clear
*
Random = val(substr(time(),4,2)) * val(substr(time(),7,2))
@ 12,42 say Number
*
do while Length < WordLen
  store 0 to Waits
  do while Waits < Delay
    KeyVal = inkey()
    do case
      case KeyVal = 48
        Number = mod(Number + 1,10)
        @ 12,42 say Number
      case KeyVal = 46
        WordSite = at(chr(Number + 48),String)
        if WordSite <> 0
          String = stuff(String,WordSite,1,'')
          Score = Score + 1
          @ 12,25 say String picture '999999999999'
        else
          AddVal = AddVal + 0.3
        endif
      endcase
      Waits = Waits + 1
    enddo
    store 0 to AddNum
    do while AddNum < AddVal
    Random = mod((Random + 7) * 4713,32767)
    String = String - chr(int(Random/32767*10)+48)
    Length = len(trim(String))
    @ 12,25 say String
    AddNum = AddNum + 1
  enddo
enddo
*
@ 20,30 say 'Your Score is  '+ltrim(str(Score))
cancel




