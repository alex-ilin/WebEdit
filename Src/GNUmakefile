# ============================================================================
# This is GNU makefile
#
# type:
#   'make'          to make your project(s)

# ============================================================================
# Default rule: make *.prj into *.dll

# space-separated list of .prj files to compile into *.dll
PROJECT := NppShiftIns.prj

PRJ_EXE := $(patsubst %.prj,%.dll,$(PROJECT))

default: $(PRJ_EXE)

# ============================================================================
# Include common hidden rules and some variables (see Rules.make)

include Rules.make
