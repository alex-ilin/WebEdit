@echo off
if "%1" == "" (
  echo Usage: %~nx0 Ver1 Ver2 [Ver3]
  echo Example: %~nx0 2 0
) else (
  if "%2" == "" (
    echo Error: Ver2 is missing. Run without parameters for help.
  ) else (
    if "%3" == "" (
      sed -e "3 s/Version .*,/Version %1.%2,/" < Changelog.txt > Changelog.tmp
      sed -e "s@s/$Ver1/.*/@s/$Ver1/%1/@" -e "s@s/$Ver2/.*/@s/$Ver2/%2/@" -e "s@s/$Ver3/.*/@s/$Ver3/0/@" < ..\WebEditVer > ..\WebEditVer.tmp
      sed -e "s@s/$Ver1/.*/@s/$Ver1/%1/@" -e "s@s/$Ver2/.*/@s/$Ver2/%2/@" -e "s@s/$Ver3/.*/@s/$Ver3/0/@" < ..\WebEditUVer > ..\WebEditUVer.tmp
    ) else (
      sed -e "3 s/Version .*,/Version %1.%2.%3,/" < Changelog.txt > Changelog.tmp
      sed -e "s@s/$Ver1/.*/@s/$Ver1/%1/@" -e "s@s/$Ver2/.*/@s/$Ver2/%2/@" -e "s@s/$Ver3/.*/@s/$Ver3/%3/@" < ..\WebEditVer > ..\WebEditVer.tmp
      sed -e "s@s/$Ver1/.*/@s/$Ver1/%1/@" -e "s@s/$Ver2/.*/@s/$Ver2/%2/@" -e "s@s/$Ver3/.*/@s/$Ver3/%3/@" < ..\WebEditUVer > ..\WebEditUVer.tmp
    )
    del Changelog.txt ..\WebEditVer ..\WebEditUVer
    ren Changelog.tmp Changelog.txt
    ren ..\WebEditVer.tmp WebEditVer
    ren ..\WebEditUVer.tmp WebEditUVer
  )
)
