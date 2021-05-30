# ============================================================================
# This file is part of GNUmakefile
# Some hidden rules (template rules) and internal variables are declared here
# to help you make your Amadeus project(s)
#
# The XDS/BIN directory should be in the PATH environment variable.
#
# ============================================================================

SHELL := cmd.exe

.PHONY: dist

.PRECIOUS: %Ver.res

%Ver.ob2: %Ver %Ver.obt
	sed --file=$< -e "s/\.0';/';/" -e "s/\.0';/';/" < $<.obt > $@
# The additional regex removes two trailing zeroes from the version string.

%Ver.rc: %Ver %Ver.rct
	sed --file=$< < $<.rct > $@

%Ver.res: %Ver.rc
	gorc /r $<

%.dll: %.prj %Ver.res %Ver.ob2 ../Lib/*.ob2 %.ob2 IniFiles.ob2 Settings.ob2 Tags.ob2
	xc =project $<
	-@echo off && mkdir obj 2> NUL
	-@echo off && mv *.obj *.sym tmp.lnk obj 2> NUL

install: WebEdit.dll
	-"d:\Program Files\System\SysInt\pskill.exe" notepad++
	sleep 1
	cp -f $< "d:/Program Files/Utils/Notepad++/plugins"
	start "" "d:\Program Files\Utils\Notepad++\Notepad++.exe"

WebEdit.zip: Changelog.txt compile.bat ..\Lib\NotepadPP.ob2 ..\Lib\NotepadPPU.ob2 ..\Lib\Scintilla.ob2 WebEdit.dll WebEditU.dll WebEdit.ob2 WebEditU.ob2 IniFiles.ob2 Settings.ob2 Tags.ob2 WebEdit.prj WebEditU.prj \
  ..\..\ReadMe.txt WebEditVer.res WebEditVer.ob2 WebEditUVer.res WebEditUVer.ob2 Config/WebEdit.ini Config/*.bmp ..\Lib\Str.ob2 ..\Lib\StrU.ob2
	md WebEdit\Config
	md WebEdit\Source
	cp $? WebEdit\Source
	$(if $(filter Config/%,          $?), mv $(subst Config/, WebEdit/Source/, $(filter Config/%, $?)) WebEdit/Config)
	$(if $(findstring WebEdit.dll,   $?), mv WebEdit\Source\WebEdit.dll   WebEdit)
	$(if $(findstring WebEditU.dll,  $?), mv WebEdit\Source\WebEditU.dll  WebEdit)
	$(if $(findstring ReadMe.txt,    $?), mv WebEdit\Source\ReadMe.txt    WebEdit\WebEdit.txt)
	$(if $(findstring Changelog.txt, $?), mv WebEdit\Source\Changelog.txt WebEdit)
	7z a -mx9 -r -tzip WebEdit WebEdit/*
	rd /s /q WebEdit

%.md5: %
	md5sum $< > $@

dist: WebEdit.zip.md5
	md5sum --check $<
