# ============================================================================
# This file is part of GNUmakefile
# Some hidden rules (template rules) and internal variables are declared here
# to help you make your Amadeus project(s)
#
# The XDS/BIN directory should be in the PATH environment variable.
#
# ============================================================================

SHELL := cmd.exe

.PHONY: dist clean

.PRECIOUS: %Ver.res

%Ver.ob2: %Ver %Ver.obt
	sed --file=$< -e "s/\.0';/';/" -e "s/\.0';/';/" < $<.obt > $@
# The additional regex removes two trailing zeroes from the version string.

%Ver.rc: %Ver %Ver.rct
	sed --file=$< < $<.rct > $@

%Ver.res: %Ver.rc
	gorc /r $<

%.dll: %.prj %Ver.res %Ver.ob2 %.ob2 *.ob2
	xc =project $<
	-@echo off && mkdir obj 2> NUL
	-@echo off && mv *.obj *.sym tmp.lnk obj 2> NUL

install: WebEdit.dll
	-"d:\Program Files\System\SysInt\pskill.exe" notepad++
	sleep 1
	cp -f $< "d:/Program Files/Utils/Notepad++/plugins"
	start "" "d:\Program Files\Utils\Notepad++\Notepad++.exe"

WebEdit.zip: Changelog.txt compile.bat ..\..\ReadMe.txt \
  *.ob2 WebEdit.dll WebEditU.dll WebEdit.prj WebEditU.prj \
  WebEditVer.res WebEditVer.ob2 WebEditUVer.res WebEditUVer.ob2 \
  Config/WebEdit.ini Config/*.bmp
	if exist WebEdit rd /s /q WebEdit
	md WebEdit\Config
	md WebEdit\Source
	cp $? WebEdit\Source
	$(if $(filter Config/%,          $?), mv $(subst Config/, WebEdit/Source/, $(filter Config/%, $?)) WebEdit/Config)
	$(if $(findstring WebEdit.dll,   $?), mv WebEdit\Source\WebEdit.dll   WebEdit\WebEdit-ansi.dll)
	$(if $(findstring WebEditU.dll,  $?), mv WebEdit\Source\WebEditU.dll  WebEdit\WebEdit.dll)
	$(if $(findstring ReadMe.txt,    $?), mv WebEdit\Source\ReadMe.txt    WebEdit\WebEdit.txt)
	$(if $(findstring Changelog.txt, $?), mv WebEdit\Source\Changelog.txt WebEdit)
	cd WebEdit && 7z a -mx9 -r -tzip WebEdit *.* && mv WebEdit.zip ..
	rd /s /q WebEdit

# Create the MD5 sum only after verifying the archive contents are compilable.
# This way we don't need to unpack and verify it if the MD5 file is up to date.
%.md5: %
	md WebEdit
	cd WebEdit && 7z x -y ..\$<
	cd WebEdit\Source && compile.bat
	md5sum $< > $@
	@rd /s /q WebEdit

dist: WebEdit.zip.md5
	md5sum --check $<

clean:
	-rd /s /q obj WebEdit
	del *.dll *.md5 *.zip
