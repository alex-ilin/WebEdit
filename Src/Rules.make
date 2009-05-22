# ============================================================================
# This file is part of GNUmakefile
# Some hidden rules (template rules) and internal variables are declared here
# to help you make your Amadeus project(s)
#
# The XDS/BIN directory should be in the PATH environment variable.
#

# ============================================================================
# Common rules for building Amadeus-based applications

include ../A3Lib/Rules.make

.PHONY: dist

.PRECIOUS: %Ver.res

%Ver.rc: %Ver %Ver.rct
	cte $< $<.rct $@

%Ver.res: %Ver.rc
	gorc /r $<

%.dll: %.prj %Ver.res ../Lib/*.ob2 %.ob2 $(sym_files)
	xc =project $<
	-@echo off && mkdir obj 2> NUL
	-@echo off && mv *.obj *.sym tmp.lnk obj 2> NUL

WebEdit.zip: Changelog.txt compile.bat ..\Lib\NotepadPP.ob2 ..\Lib\NotepadPPU.ob2 ..\Lib\Scintilla.ob2 WebEdit.dll WebEditU.dll WebEdit.ob2 WebEditU.ob2 WebEdit.prj WebEditU.prj WebEdit.txt WebEditVer.res WebEditUVer.res Config/WebEdit.ini Config/*.bmp
	md WebEdit\Config
	md WebEdit\Source
	cp $? WebEdit\Source
	$(if $(filter Config/%,             $?), mv $(subst Config/, WebEdit/Source/, $(filter Config/%, $?)) WebEdit/Config)
	$(if $(findstring WebEdit.dll,      $?), cmd /c move WebEdit\Source\WebEdit.dll   WebEdit\)
	$(if $(findstring WebEditU.dll,     $?), cmd /c move WebEdit\Source\WebEditU.dll  WebEdit\)
	$(if $(findstring WebEdit.txt,      $?), cmd /c move WebEdit\Source\WebEdit.txt   WebEdit\)
	$(if $(findstring Changelog.txt,    $?), cmd /c move WebEdit\Source\Changelog.txt WebEdit\)
	zip -m -9 -r WebEdit WebEdit/*
	rd WebEdit

%.md5: %
	md5sum $< > $@

dist: WebEdit.zip.md5
	md5sum --check $<
