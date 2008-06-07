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

%.dll: %.prj ../Lib/*.ob2 *.ob2 $(sym_files)
	xc =project $<
	-@echo off && mkdir obj 2> NUL
	-@echo off && mv *.obj *.sym tmp.lnk obj 2> NUL

WebEdit.zip: Changelog.txt compile.bat ..\Lib\NotepadPP.ob2 ..\Lib\Scintilla.ob2 WebEdit.dll WebEdit.ini WebEdit.ob2 WebEdit.prj WebEdit.txt
	md WebEdit
	cp $? WebEdit
	zip -m -9 WebEdit WebEdit/*
	rd WebEdit

dist: WebEdit.zip
