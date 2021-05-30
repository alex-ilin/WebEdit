MODULE Scintilla;

(* --------------------------------------------------------------------------------
 * (C) 2008 - 2010 by Alexander Iljin
 * -------------------------------------------------------------------------------- *)

IMPORT SYSTEM,Win:=Windows;

(** --------------------------------------------------------------------------------
  * This module provides convenient interface to the Scintilla text editing
  * component. For documentation refer to:
  * http://scintilla.sourceforge.net/ScintillaDoc.html
  * and Scintilla.iface file (cf. Scintilla sources).
  * The file is manually created section by section. The order of sections and
  * commands within sections mirrors the order of the ScintillaDoc.html.
  * -------------------------------------------------------------------------------- *)

CONST
   (* Text retrieval and modification *)
   SCI_GETTEXT = 2182;
   SCI_SETTEXT = 2181;
   SCI_SETSAVEPOINT = 2014;
   SCI_GETLINE = 2153;
   SCI_REPLACESEL = 2170;
   SCI_SETREADONLY = 2171;
   SCI_GETREADONLY = 2140;
   SCI_GETTEXTRANGE = 2162;
   SCI_ALLOCATE = 2446;
   SCI_ADDTEXT = 2001;
   SCI_ADDSTYLEDTEXT = 2002;
   SCI_APPENDTEXT = 2282;
   SCI_INSERTTEXT = 2003;
   SCI_CLEARALL = 2004;
   SCI_CLEARDOCUMENTSTYLE = 2005;
   SCI_GETCHARAT = 2007;
   SCI_GETSTYLEAT = 2010;
   SCI_SETSTYLEBITS = 2090;
   SCI_GETSTYLEBITS = 2091;

   (* Cut, copy and paste *)
   SCI_CUT = 2177;
   SCI_COPY = 2178;
   SCI_PASTE = 2179;
   SCI_CLEAR = 2180;
   SCI_CANPASTE = 2173;
   SCI_COPYRANGE = 2419;
   SCI_COPYTEXT = 2420;
   SCI_COPYALLOWLINE = 2519;
   SCI_SETPASTECONVERTENDINGS = 2467;
   SCI_GETPASTECONVERTENDINGS = 2468;

   (* Undo and Redo *)
   SCI_UNDO = 2176;
   SCI_CANUNDO = 2174;
   SCI_EMPTYUNDOBUFFER = 2175;
   SCI_REDO = 2011;
   SCI_CANREDO = 2016;
   SCI_SETUNDOCOLLECTION = 2012;
   SCI_GETUNDOCOLLECTION = 2019;
   SCI_BEGINUNDOACTION = 2078;
   SCI_ENDUNDOACTION = 2079;

   (* Selection and information *)
   SCI_GETTEXTLENGTH = 2183;
   SCI_GETLENGTH = 2006;
   SCI_GETLINECOUNT = 2154;
   SCI_GETFIRSTVISIBLELINE = 2152;
   SCI_LINESONSCREEN = 2370;
   SCI_GETMODIFY = 2159;
   SCI_SETSEL = 2160;
   SCI_GOTOPOS = 2025;
   SCI_GOTOLINE = 2024;
   SCI_SETCURRENTPOS = 2141;
   SCI_GETCURRENTPOS = 2008;
   SCI_SETANCHOR = 2026;
   SCI_GETANCHOR = 2009;
   SCI_SETSELECTIONSTART = 2142;
   SCI_GETSELECTIONSTART = 2143;
   SCI_SETSELECTIONEND = 2144;
   SCI_GETSELECTIONEND = 2145;
   SCI_SELECTALL = 2013;
   SCI_LINEFROMPOSITION = 2166;
   SCI_POSITIONFROMLINE = 2167;
   SCI_GETLINEENDPOSITION = 2136;
   SCI_LINELENGTH = 2350;
   SCI_GETSELTEXT = 2161;
   SCI_GETCURLINE = 2027;
   SCI_SELECTIONISRECTANGLE = 2372;
   SCI_SETSELECTIONMODE = 2422;
   SCI_GETSELECTIONMODE = 2423;
   SCI_GETLINESELSTARTPOSITION = 2424;
   SCI_GETLINESELENDPOSITION = 2425;
   SCI_MOVECARETINSIDEVIEW = 2401;
   SCI_WORDSTARTPOSITION = 2266;
   SCI_WORDENDPOSITION = 2267;
   SCI_POSITIONBEFORE = 2417;
   SCI_POSITIONAFTER = 2418;
   SCI_TEXTWIDTH = 2276;
   SCI_TEXTHEIGHT = 2279;
   SCI_GETCOLUMN = 2129;
   SCI_FINDCOLUMN = 2456;
   SCI_POSITIONFROMPOINT = 2022;
   SCI_POSITIONFROMPOINTCLOSE = 2023;
   SCI_POINTXFROMPOSITION = 2164;
   SCI_POINTYFROMPOSITION = 2165;
   SCI_HIDESELECTION = 2163;
   SCI_CHOOSECARETX = 2399;

   (* Multiple Selection and Virtual Space *)
   SCI_SETMULTIPLESELECTION = 2563;
   SCI_GETMULTIPLESELECTION = 2564;
   SCI_SETADDITIONALSELECTIONTYPING = 2565;
   SCI_GETADDITIONALSELECTIONTYPING = 2566;
   SCI_SETVIRTUALSPACEOPTIONS = 2596;
   SCI_GETVIRTUALSPACEOPTIONS = 2597;
   SCI_SETRECTANGULARSELECTIONMODIFIER = 2598;
   SCI_GETRECTANGULARSELECTIONMODIFIER = 2599;
   SCI_GETSELECTIONS = 2570;
   SCI_CLEARSELECTIONS = 2571;
   SCI_SETSELECTION = 2572;
   SCI_ADDSELECTION = 2573;
   SCI_SETMAINSELECTION = 2574;
   SCI_GETMAINSELECTION = 2575;
   SCI_SETSELECTIONNCARET = 2576;
   SCI_GETSELECTIONNCARET = 2577;
   SCI_SETSELECTIONNCARETVIRTUALSPACE = 2580;
   SCI_GETSELECTIONNCARETVIRTUALSPACE = 2581;
   SCI_SETSELECTIONNANCHOR = 2578;
   SCI_GETSELECTIONNANCHOR = 2579;
   SCI_SETSELECTIONNANCHORVIRTUALSPACE = 2582;
   SCI_GETSELECTIONNANCHORVIRTUALSPACE = 2583;
   SCI_SETSELECTIONNSTART = 2584;
   SCI_GETSELECTIONNSTART = 2585;
   SCI_SETSELECTIONNEND = 2586;
   SCI_GETSELECTIONNEND = 2587;
   SCI_SETRECTANGULARSELECTIONCARET = 2588;
   SCI_GETRECTANGULARSELECTIONCARET = 2589;
   SCI_SETRECTANGULARSELECTIONCARETVIRTUALSPACE = 2592;
   SCI_GETRECTANGULARSELECTIONCARETVIRTUALSPACE = 2593;
   SCI_SETRECTANGULARSELECTIONANCHOR = 2590;
   SCI_GETRECTANGULARSELECTIONANCHOR = 2591;
   SCI_SETRECTANGULARSELECTIONANCHORVIRTUALSPACE = 2594;
   SCI_GETRECTANGULARSELECTIONANCHORVIRTUALSPACE = 2595;
   SCI_SETADDITIONALSELALPHA = 2602;
   SCI_GETADDITIONALSELALPHA = 2603;
   SCI_SETADDITIONALSELFORE = 2600;
   SCI_SETADDITIONALSELBACK = 2601;
   SCI_SETADDITIONALCARETFORE = 2604;
   SCI_GETADDITIONALCARETFORE = 2605;
   SCI_SETADDITIONALCARETSBLINK = 2567;
   SCI_GETADDITIONALCARETSBLINK = 2568;
   SCI_SWAPMAINANCHORCARET = 2607;
   SCI_ROTATESELECTION = 2606;

   (* Scrolling and automatic scrolling *)
   SCI_LINESCROLL = 2168;
   SCI_SCROLLCARET = 2169;
   SCI_SETXCARETPOLICY = 2402;
   SCI_SETYCARETPOLICY = 2403;
   SCI_SETVISIBLEPOLICY = 2394;
   SCI_SETHSCROLLBAR = 2130;
   SCI_GETHSCROLLBAR = 2131;
   SCI_SETVSCROLLBAR = 2280;
   SCI_GETVSCROLLBAR = 2281;
   SCI_SETXOFFSET = 2397;
   SCI_GETXOFFSET = 2398;
   SCI_SETSCROLLWIDTH = 2274;
   SCI_GETSCROLLWIDTH = 2275;
   SCI_SETSCROLLWIDTHTRACKING = 2516;
   SCI_GETSCROLLWIDTHTRACKING = 2517;
   SCI_SETENDATLASTLINE = 2277;
   SCI_GETENDATLASTLINE = 2278;

   (* Line endings *)
   SCI_SETEOLMODE = 2031;
   SCI_GETEOLMODE = 2030;
   SCI_CONVERTEOLS = 2029;
   SCI_SETVIEWEOL = 2356;
   SCI_GETVIEWEOL = 2355;

   (* Styling *)
   SCI_GETENDSTYLED = 2028;
   SCI_STARTSTYLING = 2032;
   SCI_SETSTYLING = 2033;
   SCI_SETSTYLINGEX = 2073;
   SCI_SETLINESTATE = 2092;
   SCI_GETLINESTATE = 2093;
   SCI_GETMAXLINESTATE = 2094;

   (* Tabs and Indentation Guides *)
   SCI_SETTABWIDTH = 2036;
   SCI_GETTABWIDTH = 2121;
   SCI_SETUSETABS = 2124;
   SCI_GETUSETABS = 2125;
   SCI_SETINDENT = 2122;
   SCI_GETINDENT = 2123;
   SCI_SETTABINDENTS = 2260;
   SCI_GETTABINDENTS = 2261;
   SCI_SETBACKSPACEUNINDENTS = 2262;
   SCI_GETBACKSPACEUNINDENTS = 2263;
   SCI_SETLINEINDENTATION = 2126;
   SCI_GETLINEINDENTATION = 2127;
   SCI_GETLINEINDENTPOSITION = 2128;
   SCI_SETINDENTATIONGUIDES = 2132;
   SCI_GETINDENTATIONGUIDES = 2133;
   SCI_SETHIGHLIGHTGUIDE = 2134;
   SCI_GETHIGHLIGHTGUIDE = 2135;

   (* Autocompletion *)
   SCI_AUTOCSHOW = 2100;
   SCI_AUTOCCANCEL = 2101;
   SCI_AUTOCACTIVE = 2102;
   SCI_AUTOCPOSSTART = 2103;
   SCI_AUTOCCOMPLETE = 2104;
   SCI_AUTOCSTOPS = 2105;
   SCI_AUTOCSETSEPARATOR = 2106;
   SCI_AUTOCGETSEPARATOR = 2107;
   SCI_AUTOCSELECT = 2108;
   SCI_AUTOCSETCANCELATSTART = 2110;
   SCI_AUTOCGETCANCELATSTART = 2111;
   SCI_AUTOCSETFILLUPS = 2112;
   SCI_AUTOCSETCHOOSESINGLE = 2113;
   SCI_AUTOCGETCHOOSESINGLE = 2114;
   SCI_AUTOCSETIGNORECASE = 2115;
   SCI_AUTOCGETIGNORECASE = 2116;
   SCI_AUTOCSETAUTOHIDE = 2118;
   SCI_AUTOCGETAUTOHIDE = 2119;
   SCI_AUTOCSETDROPRESTOFWORD = 2270;
   SCI_AUTOCGETDROPRESTOFWORD = 2271;
   SCI_REGISTERIMAGE = 2405;
   SCI_CLEARREGISTEREDIMAGES = 2408;
   SCI_AUTOCGETTYPESEPARATOR = 2285;
   SCI_AUTOCSETTYPESEPARATOR = 2286;
   SCI_AUTOCSETMAXWIDTH = 2208;
   SCI_AUTOCGETMAXWIDTH = 2209;
   SCI_AUTOCSETMAXHEIGHT = 2210;
   SCI_AUTOCGETMAXHEIGHT = 2211;
   SCI_AUTOCGETCURRENT = 2445;
   SCN_AUTOCSELECTION = 2022;

   (* User lists *)
   SCI_USERLISTSHOW = 2117;
   SCN_USERLISTSELECTION = 2014;

   (* Call tips *)
   SCI_CALLTIPSHOW = 2200;
   SCI_CALLTIPCANCEL = 2201;
   SCI_CALLTIPACTIVE = 2202;
   SCI_CALLTIPPOSSTART = 2203;
   SCI_CALLTIPSETHLT = 2204;
   SCI_CALLTIPSETBACK = 2205;
   SCI_CALLTIPSETFORE = 2206;
   SCI_CALLTIPSETFOREHLT = 2207;
   SCI_CALLTIPUSESTYLE = 2212;
   SCN_CALLTIPCLICK = 2021;

   (* Keyboard commands *)
   SCI_LINEDOWN = 2300;
   SCI_LINEDOWNEXTEND = 2301;
   SCI_LINEDOWNRECTEXTEND = 2426;
   SCI_LINESCROLLDOWN = 2342;
   SCI_LINEUP = 2302;
   SCI_LINEUPEXTEND = 2303;
   SCI_LINEUPRECTEXTEND = 2427;
   SCI_LINESCROLLUP = 2343;
   SCI_PARADOWN = 2413;
   SCI_PARADOWNEXTEND = 2414;
   SCI_PARAUP = 2415;
   SCI_PARAUPEXTEND = 2416;
   SCI_CHARLEFT = 2304;
   SCI_CHARLEFTEXTEND = 2305;
   SCI_CHARLEFTRECTEXTEND = 2428;
   SCI_CHARRIGHT = 2306;
   SCI_CHARRIGHTEXTEND = 2307;
   SCI_CHARRIGHTRECTEXTEND = 2429;
   -- TODO: add the missing commands
   SCI_NEWLINE = 2329;
   SCI_FORMFEED = 2330;
   SCI_TAB = 2327;
   SCI_BACKTAB = 2328;
   SCI_SELECTIONDUPLICATE = 2469;

   (* Direct access *)
   SCI_GETDIRECTFUNCTION = 2184;
   SCI_GETDIRECTPOINTER = 2185;

   (* Folding *)
   SCI_VISIBLEFROMDOCLINE = 2220;
   SCI_DOCLINEFROMVISIBLE = 2221;
   SCI_SHOWLINES = 2226;
   SCI_HIDELINES = 2227;
   SCI_GETLINEVISIBLE = 2228;
   SCI_SETFOLDLEVEL = 2222;
   SCI_GETFOLDLEVEL = 2223;
   SCI_SETFOLDFLAGS = 2233;
   SCI_GETLASTCHILD = 2224;
   SCI_GETFOLDPARENT = 2225;
   SCI_SETFOLDEXPANDED = 2229;
   SCI_GETFOLDEXPANDED = 2230;
   SCI_TOGGLEFOLD = 2231;
   SCI_ENSUREVISIBLE = 2232;
   SCI_ENSUREVISIBLEENFORCEPOLICY = 2234;

   (** Constants for SetFoldLevel and GetFoldLevel *)
   FoldLevelBase*          = 00400H;
   FoldLevelNumberMask*    = 00FFFH;
   FoldLevelWhiteFlag*     = 01000H;
   FoldLevelHeaderFlag*    = 02000H;
   FoldLevelBoxHeaderFlag* = 04000H;
   FoldLevelBoxFooterFlag* = 08000H;
   FoldLevelContracted*    = 10000H;
   FoldLevelUnindent*      = 20000H;

   (** Flags for SetFoldFlags *)
   ffBox*                  = {0}; (* Experimental - draw boxes if expanded *)
   ffLineBeforeExpanded*   = {1}; (* Draw above if expanded *)
   ffLineBeforeContracted* = {2}; (* Draw above if not expanded *)
   ffLineAfterExpanded*    = {3}; (* Draw below if expanded *)
   ffLineAfterContracted*  = {4}; (* Draw below if not expanded *)
                          (* {5};  * Value is not used *)
   ffLevelNumbers*         = {6}; (* Display hexadecimal fold levels in line margin to aid debugging of folding. This feature needs to be redesigned to be sensible. *)

   (** Selection modes for SetSelectionMode and GetSelectionMode *)
   selModeStream* = 0;
   selModeRectangle* = 1;
   selModeLines* = 2;

   (** CaretPolicy modes for SetXCaretPolicy, SetYCaretPolicy and SetVisiblePolicy *)
   caretSlop* = {0};
   caretStrict* = {2};
   caretEven* = {3};
   caretJumps* = {4};

   (** VirtualSpace modes for GetVirtualSpaceOptions, SetVirtualSpaceOptions *)
   vsNone* = {};
   vsRectangularSelection* = {0};
   vsUserAccessible* = {1};

   (** Modifiers for SetRectangularSelectionModifier, GetRectangularSelectionModifier *)
   modNorm* = {};
   modShift* = {0};
   modCtrl* = {1};
   modAlt* = {2};
   modSuper* = {3};

   (** Constants for GetEolMode, SetEolMode, ConvertEols *)
   eolCRLF* = 0;
   eolCR* = 1;
   eolLF* = 2;

   (** Constants for GetIndentationGuides, SetIndentationGuides *)
   ivNone = 0;
   ivReal = 1;
   ivLookForward = 2;
   ivLookBoth = 3;

TYPE
   SendFunction = PROCEDURE ['C'] (hnd, msg, par1, par2: LONGINT): LONGINT;
   Handle* = RECORD
      hnd: LONGINT; (* = DirectPointer iff Send = DirectFunction, Win.HWND otherwise *)
      Send: SendFunction; (* either DirectFunction or Win.SendMessage *)
   END;
   Cell* = RECORD style: SYSTEM.BYTE; ch: CHAR END;
   TextPtr = POINTER TO ARRAY OF CHAR;
   TextRange = RECORD
      from, to: LONGINT;
      text: TextPtr
   END;

(* Text retrieval and modification *)

PROCEDURE GetText* (scintilla: Handle; length: LONGINT; VAR text: ARRAY OF CHAR): LONGINT;
BEGIN RETURN scintilla.Send (scintilla.hnd, SCI_GETTEXT, length, SYSTEM.ADR (text))
END GetText;

PROCEDURE SetText* (scintilla: Handle; VAR text: ARRAY OF CHAR);
BEGIN scintilla.Send (scintilla.hnd, SCI_SETTEXT, 0, SYSTEM.ADR (text))
END SetText;

PROCEDURE SetSavePoint* (scintilla: Handle);
BEGIN scintilla.Send (scintilla.hnd, SCI_SETSAVEPOINT, 0, 0)
END SetSavePoint;

PROCEDURE GetLine* (scintilla: Handle; line: LONGINT; VAR text: ARRAY OF CHAR): LONGINT;
BEGIN RETURN scintilla.Send (scintilla.hnd, SCI_GETLINE, line, SYSTEM.ADR (text))
END GetLine;

PROCEDURE ReplaceSel* (scintilla: Handle; VAR text: ARRAY OF CHAR);
BEGIN scintilla.Send (scintilla.hnd, SCI_REPLACESEL, 0, SYSTEM.ADR (text))
END ReplaceSel;

PROCEDURE SetReadOnly* (scintilla: Handle; readOnly: BOOLEAN);
BEGIN scintilla.Send (scintilla.hnd, SCI_SETREADONLY, ORD (readOnly), 0)
END SetReadOnly;

PROCEDURE GetReadOnly* (scintilla: Handle): BOOLEAN;
BEGIN RETURN scintilla.Send (scintilla.hnd, SCI_GETREADONLY, 0, 0) # 0
END GetReadOnly;

PROCEDURE GetTextRange* (scintilla: Handle; from, to: LONGINT; VAR text: ARRAY OF CHAR): LONGINT;
VAR tr: TextRange;
BEGIN
   tr.from := from; tr.to := to; tr.text := SYSTEM.VAL (TextPtr, SYSTEM.ADR (text));
   RETURN scintilla.Send (scintilla.hnd, SCI_GETTEXTRANGE, 0, SYSTEM.ADR (tr))
END GetTextRange;

PROCEDURE Allocate* (scintilla: Handle; bytes: LONGINT);
BEGIN scintilla.Send (scintilla.hnd, SCI_ALLOCATE, bytes, 0)
END Allocate;

PROCEDURE AddText* (scintilla: Handle; length: LONGINT; VAR text: ARRAY OF CHAR);
BEGIN scintilla.Send (scintilla.hnd, SCI_ADDTEXT, length, SYSTEM.ADR (text))
END AddText;

PROCEDURE AddStyledText* (scintilla: Handle; length: LONGINT; VAR cells: ARRAY OF Cell);
BEGIN scintilla.Send (scintilla.hnd, SCI_ADDSTYLEDTEXT, length, SYSTEM.ADR (cells))
END AddStyledText;

PROCEDURE AppendText* (scintilla: Handle; length: LONGINT; VAR text: ARRAY OF CHAR);
BEGIN scintilla.Send (scintilla.hnd, SCI_APPENDTEXT, length, SYSTEM.ADR (text))
END AppendText;

PROCEDURE InsertText* (scintilla: Handle; pos: LONGINT; VAR text: ARRAY OF CHAR);
BEGIN scintilla.Send (scintilla.hnd, SCI_INSERTTEXT, pos, SYSTEM.ADR (text))
END InsertText;

PROCEDURE ClearAll* (scintilla: Handle);
BEGIN scintilla.Send (scintilla.hnd, SCI_CLEARALL, 0, 0)
END ClearAll;

PROCEDURE ClearDocumentStyle* (scintilla: Handle);
BEGIN scintilla.Send (scintilla.hnd, SCI_CLEARDOCUMENTSTYLE, 0, 0)
END ClearDocumentStyle;

PROCEDURE GetCharAt* (scintilla: Handle; pos: LONGINT): CHAR;
BEGIN RETURN SYSTEM.VAL (CHAR, scintilla.Send (scintilla.hnd, SCI_GETCHARAT, pos, 0))
END GetCharAt;

PROCEDURE GetStyleAt* (scintilla: Handle; pos: LONGINT): SYSTEM.BYTE;
BEGIN RETURN SYSTEM.VAL (SYSTEM.BYTE, scintilla.Send (scintilla.hnd, SCI_GETSTYLEAT, pos, 0))
END GetStyleAt;

PROCEDURE SetStyleBits* (scintilla: Handle; bits: LONGINT);
BEGIN scintilla.Send (scintilla.hnd, SCI_SETSTYLEBITS, bits, 0)
END SetStyleBits;

PROCEDURE GetStyleBits* (scintilla: Handle): LONGINT;
BEGIN RETURN scintilla.Send (scintilla.hnd, SCI_GETSTYLEBITS, 0, 0)
END GetStyleBits;

(* Cut, copy and paste *)

PROCEDURE Cut* (scintilla: Handle);
BEGIN scintilla.Send (scintilla.hnd, SCI_CUT, 0, 0)
END Cut;

PROCEDURE Copy* (scintilla: Handle);
BEGIN scintilla.Send (scintilla.hnd, SCI_COPY, 0, 0)
END Copy;

PROCEDURE Paste* (scintilla: Handle);
BEGIN scintilla.Send (scintilla.hnd, SCI_PASTE, 0, 0)
END Paste;

PROCEDURE Clear* (scintilla: Handle);
BEGIN scintilla.Send (scintilla.hnd, SCI_CLEAR, 0, 0)
END Clear;

PROCEDURE CanPaste* (scintilla: Handle): BOOLEAN;
BEGIN RETURN scintilla.Send (scintilla.hnd, SCI_CANPASTE, 0, 0) # 0
END CanPaste;

PROCEDURE CopyRange* (scintilla: Handle; start, end: LONGINT);
BEGIN scintilla.Send (scintilla.hnd, SCI_COPYRANGE, start, end)
END CopyRange;

PROCEDURE CopyText* (scintilla: Handle; len: LONGINT; VAR text: ARRAY OF CHAR);
BEGIN scintilla.Send (scintilla.hnd, SCI_COPYTEXT, len, SYSTEM.ADR (text))
END CopyText;

PROCEDURE CopyAllowLine* (scintilla: Handle);
BEGIN scintilla.Send (scintilla.hnd, SCI_COPYALLOWLINE, 0, 0)
END CopyAllowLine;

PROCEDURE SetPasteConvertEndings* (scintilla: Handle; convert: BOOLEAN);
BEGIN scintilla.Send (scintilla.hnd, SCI_SETPASTECONVERTENDINGS, ORD (convert), 0)
END SetPasteConvertEndings;

PROCEDURE GetPasteConvertEndings* (scintilla: Handle): BOOLEAN;
BEGIN RETURN scintilla.Send (scintilla.hnd, SCI_GETPASTECONVERTENDINGS, 0, 0) # 0
END GetPasteConvertEndings;

(* Undo and Redo *)

PROCEDURE Undo* (scintilla: Handle);
BEGIN scintilla.Send (scintilla.hnd, SCI_UNDO, 0, 0)
END Undo;

PROCEDURE CanUndo* (scintilla: Handle): BOOLEAN;
BEGIN RETURN scintilla.Send (scintilla.hnd, SCI_CANUNDO, 0, 0) # 0
END CanUndo;

PROCEDURE EmptyUndoBuffer* (scintilla: Handle);
BEGIN scintilla.Send (scintilla.hnd, SCI_EMPTYUNDOBUFFER, 0, 0)
END EmptyUndoBuffer;

PROCEDURE Redo* (scintilla: Handle);
BEGIN scintilla.Send (scintilla.hnd, SCI_REDO, 0, 0)
END Redo;

PROCEDURE CanRedo* (scintilla: Handle): BOOLEAN;
BEGIN RETURN scintilla.Send (scintilla.hnd, SCI_CANREDO, 0, 0) # 0
END CanRedo;

PROCEDURE SetUndoCollection* (scintilla: Handle; collectUndo: BOOLEAN);
BEGIN scintilla.Send (scintilla.hnd, SCI_SETUNDOCOLLECTION, ORD (collectUndo), 0)
END SetUndoCollection;

PROCEDURE GetUndoCollection* (scintilla: Handle): BOOLEAN;
BEGIN RETURN scintilla.Send (scintilla.hnd, SCI_GETUNDOCOLLECTION, 0, 0) # 0
END GetUndoCollection;

PROCEDURE BeginUndoAction* (scintilla: Handle);
BEGIN scintilla.Send (scintilla.hnd, SCI_BEGINUNDOACTION, 0, 0)
END BeginUndoAction;

PROCEDURE EndUndoAction* (scintilla: Handle);
BEGIN scintilla.Send (scintilla.hnd, SCI_ENDUNDOACTION, 0, 0)
END EndUndoAction;

(* Selection and information *)

PROCEDURE GetLength* (scintilla: Handle): LONGINT;
BEGIN RETURN scintilla.Send (scintilla.hnd, SCI_GETLENGTH, 0, 0)
END GetLength;

PROCEDURE GetTextLength* (scintilla: Handle): LONGINT;
BEGIN RETURN scintilla.Send (scintilla.hnd, SCI_GETTEXTLENGTH, 0, 0)
END GetTextLength;

PROCEDURE GetLineCount* (scintilla: Handle): LONGINT;
BEGIN RETURN scintilla.Send (scintilla.hnd, SCI_GETLINECOUNT, 0, 0)
END GetLineCount;

PROCEDURE GetFirstVisibleLine* (scintilla: Handle): LONGINT;
BEGIN RETURN scintilla.Send (scintilla.hnd, SCI_GETFIRSTVISIBLELINE, 0, 0)
END GetFirstVisibleLine;

PROCEDURE LinesOnScreen* (scintilla: Handle): LONGINT;
BEGIN RETURN scintilla.Send (scintilla.hnd, SCI_LINESONSCREEN, 0, 0)
END LinesOnScreen;

PROCEDURE GetModify* (scintilla: Handle): BOOLEAN;
BEGIN RETURN scintilla.Send (scintilla.hnd, SCI_GETMODIFY, 0, 0) # 0
END GetModify;

PROCEDURE SetSel* (scintilla: Handle; start, end: LONGINT);
BEGIN scintilla.Send (scintilla.hnd, SCI_SETSEL, start, end)
END SetSel;

PROCEDURE GotoPos* (scintilla: Handle; pos: LONGINT);
BEGIN scintilla.Send (scintilla.hnd, SCI_GOTOPOS, pos, 0)
END GotoPos;

PROCEDURE GotoLine* (scintilla: Handle; line: LONGINT);
BEGIN scintilla.Send (scintilla.hnd, SCI_GOTOLINE, line, 0)
END GotoLine;

PROCEDURE SetCurrentPos* (scintilla: Handle; pos: LONGINT);
BEGIN scintilla.Send (scintilla.hnd, SCI_SETCURRENTPOS, pos, 0)
END SetCurrentPos;

PROCEDURE GetCurrentPos* (scintilla: Handle): LONGINT;
BEGIN RETURN scintilla.Send (scintilla.hnd, SCI_GETCURRENTPOS, 0, 0)
END GetCurrentPos;

PROCEDURE SetAnchor* (scintilla: Handle; pos: LONGINT);
BEGIN scintilla.Send (scintilla.hnd, SCI_SETANCHOR, pos, 0)
END SetAnchor;

PROCEDURE GetAnchor* (scintilla: Handle): LONGINT;
BEGIN RETURN scintilla.Send (scintilla.hnd, SCI_GETANCHOR, 0, 0)
END GetAnchor;

PROCEDURE SetSelectionStart* (scintilla: Handle; pos: LONGINT);
BEGIN scintilla.Send (scintilla.hnd, SCI_SETSELECTIONSTART, pos, 0)
END SetSelectionStart;

PROCEDURE GetSelectionStart* (scintilla: Handle): LONGINT;
BEGIN RETURN scintilla.Send (scintilla.hnd, SCI_GETSELECTIONSTART, 0, 0)
END GetSelectionStart;

PROCEDURE SetSelectionEnd* (scintilla: Handle; pos: LONGINT);
BEGIN scintilla.Send (scintilla.hnd, SCI_SETSELECTIONEND, pos, 0)
END SetSelectionEnd;

PROCEDURE GetSelectionEnd* (scintilla: Handle): LONGINT;
BEGIN RETURN scintilla.Send (scintilla.hnd, SCI_GETSELECTIONEND, 0, 0)
END GetSelectionEnd;

PROCEDURE SelectAll* (scintilla: Handle);
BEGIN scintilla.Send (scintilla.hnd, SCI_SELECTALL, 0, 0)
END SelectAll;

PROCEDURE LineFromPosition* (scintilla: Handle; pos: LONGINT): LONGINT;
BEGIN RETURN scintilla.Send (scintilla.hnd, SCI_LINEFROMPOSITION, pos, 0)
END LineFromPosition;

PROCEDURE PositionFromLine* (scintilla: Handle; line: LONGINT): LONGINT;
BEGIN RETURN scintilla.Send (scintilla.hnd, SCI_POSITIONFROMLINE, line, 0)
END PositionFromLine;

PROCEDURE GetLineEndPosition* (scintilla: Handle; line: LONGINT): LONGINT;
BEGIN RETURN scintilla.Send (scintilla.hnd, SCI_GETLINEENDPOSITION, line, 0)
END GetLineEndPosition;

PROCEDURE LineLength* (scintilla: Handle; line: LONGINT): LONGINT;
BEGIN RETURN scintilla.Send (scintilla.hnd, SCI_LINELENGTH, line, 0)
END LineLength;

PROCEDURE GetSelText* (scintilla: Handle; VAR text: ARRAY OF CHAR): LONGINT;
BEGIN RETURN scintilla.Send (scintilla.hnd, SCI_GETSELTEXT, 0, SYSTEM.ADR (text))
END GetSelText;

PROCEDURE GetCurLine* (scintilla: Handle; len: LONGINT; VAR text: ARRAY OF CHAR): LONGINT;
BEGIN RETURN scintilla.Send (scintilla.hnd, SCI_GETCURLINE, len, SYSTEM.ADR (text))
END GetCurLine;

PROCEDURE SelectionIsRectangle* (scintilla: Handle): BOOLEAN;
BEGIN RETURN scintilla.Send (scintilla.hnd, SCI_SELECTIONISRECTANGLE, 0, 0) # 0
END SelectionIsRectangle;

PROCEDURE SetSelectionMode* (scintilla: Handle; mode: LONGINT);
(** cf. selModeXXX contants *)
BEGIN scintilla.Send (scintilla.hnd, SCI_SETSELECTIONMODE, mode, 0)
END SetSelectionMode;

PROCEDURE GetSelectionMode* (scintilla: Handle): LONGINT;
(** cf. selModeXXX contants *)
BEGIN RETURN scintilla.Send (scintilla.hnd, SCI_GETSELECTIONMODE, 0, 0)
END GetSelectionMode;

PROCEDURE GetLineSelStartPosition* (scintilla: Handle; line: LONGINT): LONGINT;
BEGIN RETURN scintilla.Send (scintilla.hnd, SCI_GETLINESELSTARTPOSITION, line, 0)
END GetLineSelStartPosition;

PROCEDURE GetLineSelEndPosition* (scintilla: Handle; line: LONGINT): LONGINT;
BEGIN RETURN scintilla.Send (scintilla.hnd, SCI_GETLINESELENDPOSITION, line, 0)
END GetLineSelEndPosition;

PROCEDURE MoveCaretInsideView* (scintilla: Handle);
BEGIN scintilla.Send (scintilla.hnd, SCI_MOVECARETINSIDEVIEW, 0, 0)
END MoveCaretInsideView;

PROCEDURE WordStartPosition* (scintilla: Handle; pos: LONGINT; onlyWordCharacters: BOOLEAN): LONGINT;
BEGIN RETURN scintilla.Send (scintilla.hnd, SCI_WORDSTARTPOSITION, pos, ORD (onlyWordCharacters))
END WordStartPosition;

PROCEDURE WordEndPosition* (scintilla: Handle; pos: LONGINT; onlyWordCharacters: BOOLEAN): LONGINT;
BEGIN RETURN scintilla.Send (scintilla.hnd, SCI_WORDENDPOSITION, pos, ORD (onlyWordCharacters))
END WordEndPosition;

PROCEDURE PositionBefore* (scintilla: Handle; pos: LONGINT): LONGINT;
BEGIN RETURN scintilla.Send (scintilla.hnd, SCI_POSITIONBEFORE, pos, 0)
END PositionBefore;

PROCEDURE PositionAfter* (scintilla: Handle; pos: LONGINT): LONGINT;
BEGIN RETURN scintilla.Send (scintilla.hnd, SCI_POSITIONAFTER, pos, 0)
END PositionAfter;

PROCEDURE TextWidth* (scintilla: Handle; style: LONGINT; VAR text: ARRAY OF CHAR): LONGINT;
BEGIN RETURN scintilla.Send (scintilla.hnd, SCI_TEXTWIDTH, style, SYSTEM.ADR (text))
END TextWidth;

PROCEDURE TextHeight* (scintilla: Handle; line: LONGINT): LONGINT;
BEGIN RETURN scintilla.Send (scintilla.hnd, SCI_TEXTHEIGHT, line, 0)
END TextHeight;

PROCEDURE GetColumn* (scintilla: Handle; pos: LONGINT): LONGINT;
BEGIN RETURN scintilla.Send (scintilla.hnd, SCI_GETCOLUMN, pos, 0)
END GetColumn;

PROCEDURE FindColumn* (scintilla: Handle; line, column: LONGINT): LONGINT;
BEGIN RETURN scintilla.Send (scintilla.hnd, SCI_FINDCOLUMN, line, column)
END FindColumn;

PROCEDURE PositionFromPoint* (scintilla: Handle; x, y: LONGINT): LONGINT;
BEGIN RETURN scintilla.Send (scintilla.hnd, SCI_POSITIONFROMPOINT, x, y)
END PositionFromPoint;

PROCEDURE PositionFromPointClose* (scintilla: Handle; x, y: LONGINT): LONGINT;
BEGIN RETURN scintilla.Send (scintilla.hnd, SCI_POSITIONFROMPOINTCLOSE, x, y)
END PositionFromPointClose;

PROCEDURE PointXFromPosition* (scintilla: Handle; pos: LONGINT): LONGINT;
BEGIN RETURN scintilla.Send (scintilla.hnd, SCI_POINTXFROMPOSITION, 0, pos)
END PointXFromPosition;

PROCEDURE PointYFromPosition* (scintilla: Handle; pos: LONGINT): LONGINT;
BEGIN RETURN scintilla.Send (scintilla.hnd, SCI_POINTYFROMPOSITION, 0, pos)
END PointYFromPosition;

PROCEDURE HideSelection* (scintilla: Handle; normal: BOOLEAN);
BEGIN scintilla.Send (scintilla.hnd, SCI_HIDESELECTION, ORD (normal), 0)
END HideSelection;

PROCEDURE ChooseCaretX* (scintilla: Handle);
BEGIN scintilla.Send (scintilla.hnd, SCI_CHOOSECARETX, 0, 0)
END ChooseCaretX;

(* Multiple Selection and Virtual Space *)

PROCEDURE SetMultipleSelection* (scintilla: Handle; value: BOOLEAN);
BEGIN scintilla.Send (scintilla.hnd, SCI_SETMULTIPLESELECTION, ORD (value), 0)
END SetMultipleSelection;

PROCEDURE GetMultipleSelection* (scintilla: Handle): BOOLEAN;
BEGIN RETURN scintilla.Send (scintilla.hnd, SCI_GETMULTIPLESELECTION, 0, 0) # 0
END GetMultipleSelection;

PROCEDURE SetAdditionalSelectionTyping* (scintilla: Handle; value: BOOLEAN);
BEGIN scintilla.Send (scintilla.hnd, SCI_SETADDITIONALSELECTIONTYPING, ORD (value), 0)
END SetAdditionalSelectionTyping;

PROCEDURE GetAdditionalSelectionTyping* (scintilla: Handle): BOOLEAN;
BEGIN RETURN scintilla.Send (scintilla.hnd, SCI_GETADDITIONALSELECTIONTYPING, 0, 0) # 0
END GetAdditionalSelectionTyping;

PROCEDURE SetVirtualSpaceOptions* (scintilla: Handle; virtualSpaceOptions: SET);
BEGIN scintilla.Send (scintilla.hnd, SCI_SETVIRTUALSPACEOPTIONS, SYSTEM.VAL (LONGINT, virtualSpaceOptions), 0)
END SetVirtualSpaceOptions;

PROCEDURE GetVirtualSpaceOptions* (scintilla: Handle): SET;
VAR res: LONGINT;
BEGIN res := scintilla.Send (scintilla.hnd, SCI_GETVIRTUALSPACEOPTIONS, 0, 0); RETURN SYSTEM.VAL (SET, res)
END GetVirtualSpaceOptions;

PROCEDURE SetRectangularSelectionModifier* (scintilla: Handle; modifier: SET);
BEGIN scintilla.Send (scintilla.hnd, SCI_SETRECTANGULARSELECTIONMODIFIER, SYSTEM.VAL (LONGINT, modifier), 0)
END SetRectangularSelectionModifier;

PROCEDURE GetRectangularSelectionModifier* (scintilla: Handle): SET;
VAR res: LONGINT;
BEGIN res := scintilla.Send (scintilla.hnd, SCI_GETRECTANGULARSELECTIONMODIFIER, 0, 0); RETURN SYSTEM.VAL (SET, res)
END GetRectangularSelectionModifier;

PROCEDURE GetSelections* (scintilla: Handle): LONGINT;
BEGIN RETURN scintilla.Send (scintilla.hnd, SCI_GETSELECTIONS, 0, 0)
END GetSelections;

PROCEDURE ClearSelections* (scintilla: Handle);
BEGIN scintilla.Send (scintilla.hnd, SCI_CLEARSELECTIONS, 0, 0)
END ClearSelections;

PROCEDURE SetSelection* (scintilla: Handle; caret, anchor: LONGINT): LONGINT;
BEGIN RETURN scintilla.Send (scintilla.hnd, SCI_SETSELECTION, caret, anchor)
END SetSelection;

PROCEDURE AddSelection* (scintilla: Handle; caret, anchor: LONGINT): LONGINT;
BEGIN RETURN scintilla.Send (scintilla.hnd, SCI_ADDSELECTION, caret, anchor)
END AddSelection;

PROCEDURE SetMainSelection* (scintilla: Handle; selection: LONGINT);
BEGIN scintilla.Send (scintilla.hnd, SCI_SETMAINSELECTION, selection, 0)
END SetMainSelection;

PROCEDURE GetMainSelection* (scintilla: Handle): LONGINT;
BEGIN RETURN scintilla.Send (scintilla.hnd, SCI_GETMAINSELECTION, 0, 0)
END GetMainSelection;

PROCEDURE SetSelectionNCaret* (scintilla: Handle; selection, position: LONGINT);
BEGIN scintilla.Send (scintilla.hnd, SCI_SETSELECTIONNCARET, selection, position)
END SetSelectionNCaret;

PROCEDURE GetSelectionNCaret* (scintilla: Handle; selection: LONGINT): LONGINT;
BEGIN RETURN scintilla.Send (scintilla.hnd, SCI_GETSELECTIONNCARET, selection, 0)
END GetSelectionNCaret;

PROCEDURE SetSelectionNCaretVirtualSpace* (scintilla: Handle; selection, space: LONGINT);
BEGIN scintilla.Send (scintilla.hnd, SCI_SETSELECTIONNCARETVIRTUALSPACE, selection, space)
END SetSelectionNCaretVirtualSpace;

PROCEDURE GetSelectionNCaretVirtualSpace* (scintilla: Handle; selection: LONGINT): LONGINT;
BEGIN RETURN scintilla.Send (scintilla.hnd, SCI_GETSELECTIONNCARETVIRTUALSPACE, selection, 0)
END GetSelectionNCaretVirtualSpace;

PROCEDURE SetSelectionNAnchor* (scintilla: Handle; selection, posAnchor: LONGINT);
BEGIN scintilla.Send (scintilla.hnd, SCI_SETSELECTIONNANCHOR, selection, posAnchor)
END SetSelectionNAnchor;

PROCEDURE GetSelectionNAnchor* (scintilla: Handle; selection: LONGINT): LONGINT;
BEGIN RETURN scintilla.Send (scintilla.hnd, SCI_GETSELECTIONNANCHOR, selection, 0)
END GetSelectionNAnchor;

PROCEDURE SetSelectionNAnchorVirtualSpace* (scintilla: Handle; selection, space: LONGINT);
BEGIN scintilla.Send (scintilla.hnd, SCI_SETSELECTIONNANCHORVIRTUALSPACE, selection, space)
END SetSelectionNAnchorVirtualSpace;

PROCEDURE GetSelectionNAnchorVirtualSpace* (scintilla: Handle; selection: LONGINT): LONGINT;
BEGIN RETURN scintilla.Send (scintilla.hnd, SCI_GETSELECTIONNANCHORVIRTUALSPACE, selection, 0)
END GetSelectionNAnchorVirtualSpace;

PROCEDURE SetSelectionNStart* (scintilla: Handle; selection, position: LONGINT);
BEGIN scintilla.Send (scintilla.hnd, SCI_SETSELECTIONNSTART, selection, position)
END SetSelectionNStart;

PROCEDURE GetSelectionNStart* (scintilla: Handle; selection: LONGINT): LONGINT;
BEGIN RETURN scintilla.Send (scintilla.hnd, SCI_GETSELECTIONNSTART, selection, 0)
END GetSelectionNStart;

PROCEDURE SetSelectionNEnd* (scintilla: Handle; selection, position: LONGINT);
BEGIN scintilla.Send (scintilla.hnd, SCI_SETSELECTIONNEND, selection, position)
END SetSelectionNEnd;

PROCEDURE GetSelectionNEnd* (scintilla: Handle; selection: LONGINT): LONGINT;
BEGIN RETURN scintilla.Send (scintilla.hnd, SCI_GETSELECTIONNEND, selection, 0)
END GetSelectionNEnd;

PROCEDURE SetRectangularSelectionCaret* (scintilla: Handle; position: LONGINT);
BEGIN scintilla.Send (scintilla.hnd, SCI_SETRECTANGULARSELECTIONCARET, position, 0)
END SetRectangularSelectionCaret;

PROCEDURE GetRectangularSelectionCaret* (scintilla: Handle): LONGINT;
BEGIN RETURN scintilla.Send (scintilla.hnd, SCI_GETRECTANGULARSELECTIONCARET, 0, 0)
END GetRectangularSelectionCaret;

PROCEDURE SetRectangularSelectionCaretVirtualSpace* (scintilla: Handle; space: LONGINT);
BEGIN scintilla.Send (scintilla.hnd, SCI_SETRECTANGULARSELECTIONCARETVIRTUALSPACE, space, 0)
END SetRectangularSelectionCaretVirtualSpace;

PROCEDURE GetRectangularSelectionCaretVirtualSpace* (scintilla: Handle): LONGINT;
BEGIN RETURN scintilla.Send (scintilla.hnd, SCI_GETRECTANGULARSELECTIONCARETVIRTUALSPACE, 0, 0)
END GetRectangularSelectionCaretVirtualSpace;

PROCEDURE SetRectangularSelectionAnchor* (scintilla: Handle; posAnchor: LONGINT);
BEGIN scintilla.Send (scintilla.hnd, SCI_SETRECTANGULARSELECTIONANCHOR, posAnchor, 0)
END SetRectangularSelectionAnchor;

PROCEDURE GetRectangularSelectionAnchor* (scintilla: Handle): LONGINT;
BEGIN RETURN scintilla.Send (scintilla.hnd, SCI_GETRECTANGULARSELECTIONANCHOR, 0, 0)
END GetRectangularSelectionAnchor;

PROCEDURE SetRectangularSelectionAnchorVirtualSpace* (scintilla: Handle; space: LONGINT);
BEGIN scintilla.Send (scintilla.hnd, SCI_SETRECTANGULARSELECTIONANCHORVIRTUALSPACE, space, 0)
END SetRectangularSelectionAnchorVirtualSpace;

PROCEDURE GetRectangularSelectionAnchorVirtualSpace* (scintilla: Handle): LONGINT;
BEGIN RETURN scintilla.Send (scintilla.hnd, SCI_GETRECTANGULARSELECTIONANCHORVIRTUALSPACE, 0, 0)
END GetRectangularSelectionAnchorVirtualSpace;

PROCEDURE SetAdditionalSelAlpha* (scintilla: Handle; alpha: LONGINT);
BEGIN scintilla.Send (scintilla.hnd, SCI_SETADDITIONALSELALPHA, alpha, 0)
END SetAdditionalSelAlpha;

PROCEDURE GetAdditionalSelAlpha* (scintilla: Handle): LONGINT;
BEGIN RETURN scintilla.Send (scintilla.hnd, SCI_GETADDITIONALSELALPHA, 0, 0)
END GetAdditionalSelAlpha;

PROCEDURE SetAdditionalSelFore* (scintilla: Handle; fore: LONGINT);
BEGIN scintilla.Send (scintilla.hnd, SCI_SETADDITIONALSELFORE, fore, 0)
END SetAdditionalSelFore;

PROCEDURE SetAdditionalSelBack* (scintilla: Handle; back: LONGINT);
BEGIN scintilla.Send (scintilla.hnd, SCI_SETADDITIONALSELBACK, back, 0)
END SetAdditionalSelBack;

PROCEDURE SetAdditionalCaretFore* (scintilla: Handle; fore: LONGINT);
BEGIN scintilla.Send (scintilla.hnd, SCI_SETADDITIONALCARETFORE, fore, 0)
END SetAdditionalCaretFore;

PROCEDURE GetAdditionalCaretFore* (scintilla: Handle): LONGINT;
BEGIN RETURN scintilla.Send (scintilla.hnd, SCI_GETADDITIONALCARETFORE, 0, 0)
END GetAdditionalCaretFore;

PROCEDURE SetAdditionalCaretsBlink* (scintilla: Handle; value: BOOLEAN);
BEGIN scintilla.Send (scintilla.hnd, SCI_SETADDITIONALCARETSBLINK, ORD (value), 0)
END SetAdditionalCaretsBlink;

PROCEDURE GetAdditionalCaretsBlink* (scintilla: Handle): BOOLEAN;
BEGIN RETURN scintilla.Send (scintilla.hnd, SCI_GETADDITIONALCARETSBLINK, 0, 0) # 0
END GetAdditionalCaretsBlink;

PROCEDURE SwapMainAnchorCaret* (scintilla: Handle);
BEGIN scintilla.Send (scintilla.hnd, SCI_SWAPMAINANCHORCARET, 0, 0)
END SwapMainAnchorCaret;

PROCEDURE RotateSelection* (scintilla: Handle);
BEGIN scintilla.Send (scintilla.hnd, SCI_ROTATESELECTION, 0, 0)
END RotateSelection;

(* Scrolling and automatic scrolling *)

PROCEDURE LineScroll* (scintilla: Handle; column, line: LONGINT);
BEGIN scintilla.Send (scintilla.hnd, SCI_LINESCROLL, column, line)
END LineScroll;

PROCEDURE ScrollCaret* (scintilla: Handle);
BEGIN scintilla.Send (scintilla.hnd, SCI_SCROLLCARET, 0, 0)
END ScrollCaret;

PROCEDURE SetXCaretPolicy* (scintilla: Handle; caretPolicy: SET; caretSlop: LONGINT);
BEGIN scintilla.Send (scintilla.hnd, SCI_SETXCARETPOLICY, SYSTEM.VAL (LONGINT, caretPolicy), caretSlop)
END SetXCaretPolicy;

PROCEDURE SetYCaretPolicy* (scintilla: Handle; caretPolicy: SET; caretSlop: LONGINT);
BEGIN scintilla.Send (scintilla.hnd, SCI_SETYCARETPOLICY, SYSTEM.VAL (LONGINT, caretPolicy), caretSlop)
END SetYCaretPolicy;

PROCEDURE SetVisiblePolicy* (scintilla: Handle; caretPolicy: SET; caretSlop: LONGINT);
BEGIN scintilla.Send (scintilla.hnd, SCI_SETVISIBLEPOLICY, SYSTEM.VAL (LONGINT, caretPolicy), caretSlop)
END SetVisiblePolicy;

PROCEDURE SetHScrollBar* (scintilla: Handle; visible: BOOLEAN);
BEGIN scintilla.Send (scintilla.hnd, SCI_SETHSCROLLBAR, ORD (visible), 0)
END SetHScrollBar;

PROCEDURE GetHScrollBar* (scintilla: Handle): BOOLEAN;
BEGIN RETURN scintilla.Send (scintilla.hnd, SCI_GETHSCROLLBAR, 0, 0) # 0
END GetHScrollBar;

PROCEDURE SetVScrollBar* (scintilla: Handle; visible: BOOLEAN);
BEGIN scintilla.Send (scintilla.hnd, SCI_SETVSCROLLBAR, ORD (visible), 0)
END SetVScrollBar;

PROCEDURE GetVScrollBar* (scintilla: Handle): BOOLEAN;
BEGIN RETURN scintilla.Send (scintilla.hnd, SCI_GETVSCROLLBAR, 0, 0) # 0
END GetVScrollBar;

PROCEDURE SetXOffset* (scintilla: Handle; xOffset: LONGINT);
BEGIN scintilla.Send (scintilla.hnd, SCI_SETXOFFSET, xOffset, 0)
END SetXOffset;

PROCEDURE GetXOffset* (scintilla: Handle): LONGINT;
BEGIN RETURN scintilla.Send (scintilla.hnd, SCI_GETXOFFSET, 0, 0)
END GetXOffset;

PROCEDURE SetScrollWidth* (scintilla: Handle; pixelWidth: LONGINT);
BEGIN scintilla.Send (scintilla.hnd, SCI_SETSCROLLWIDTH, pixelWidth, 0)
END SetScrollWidth;

PROCEDURE GetScrollWidth* (scintilla: Handle): LONGINT;
BEGIN RETURN scintilla.Send (scintilla.hnd, SCI_GETSCROLLWIDTH, 0, 0)
END GetScrollWidth;

PROCEDURE SetScrollWidthTracking* (scintilla: Handle; tracking: BOOLEAN);
BEGIN scintilla.Send (scintilla.hnd, SCI_SETSCROLLWIDTHTRACKING, ORD (tracking), 0)
END SetScrollWidthTracking;

PROCEDURE GetScrollWidthTracking* (scintilla: Handle): BOOLEAN;
BEGIN RETURN scintilla.Send (scintilla.hnd, SCI_GETSCROLLWIDTHTRACKING, 0, 0) # 0
END GetScrollWidthTracking;

PROCEDURE SetEndAtLastLine* (scintilla: Handle; endAtLastLine: BOOLEAN);
BEGIN scintilla.Send (scintilla.hnd, SCI_SETENDATLASTLINE, ORD (endAtLastLine), 0)
END SetEndAtLastLine;

PROCEDURE GetEndAtLastLine* (scintilla: Handle): BOOLEAN;
BEGIN RETURN scintilla.Send (scintilla.hnd, SCI_GETENDATLASTLINE, 0, 0) # 0
END GetEndAtLastLine;

(* Line endings *)

PROCEDURE SetEolMode* (scintilla: Handle; eolMode: LONGINT);
BEGIN scintilla.Send (scintilla.hnd, SCI_SETEOLMODE, eolMode, 0)
END SetEolMode;

PROCEDURE GetEolMode* (scintilla: Handle): LONGINT;
BEGIN RETURN scintilla.Send (scintilla.hnd, SCI_GETEOLMODE, 0, 0)
END GetEolMode;

PROCEDURE ConvertEols* (scintilla: Handle; eolMode: LONGINT);
BEGIN scintilla.Send (scintilla.hnd, SCI_CONVERTEOLS, eolMode, 0)
END ConvertEols;

PROCEDURE SetViewEol* (scintilla: Handle; view: BOOLEAN);
BEGIN scintilla.Send (scintilla.hnd, SCI_SETVIEWEOL, ORD (view), 0)
END SetViewEol;

PROCEDURE GetViewEol* (scintilla: Handle): BOOLEAN;
BEGIN RETURN scintilla.Send (scintilla.hnd, SCI_GETVIEWEOL, 0, 0) # 0
END GetViewEol;

(* Styling *)

PROCEDURE GetEndStyled* (scintilla: Handle): LONGINT;
BEGIN RETURN scintilla.Send (scintilla.hnd, SCI_GETENDSTYLED, 0, 0)
END GetEndStyled;

PROCEDURE StartStyling* (scintilla: Handle; pos, mask: LONGINT);
BEGIN scintilla.Send (scintilla.hnd, SCI_STARTSTYLING, pos, mask)
END StartStyling;

PROCEDURE SetStyling* (scintilla: Handle; length, style: LONGINT);
BEGIN scintilla.Send (scintilla.hnd, SCI_SETSTYLING, length, style)
END SetStyling;

PROCEDURE SetStylingEx* (scintilla: Handle; length: LONGINT; VAR styles: ARRAY OF CHAR);
BEGIN scintilla.Send (scintilla.hnd, SCI_SETSTYLINGEX, length, SYSTEM.ADR (styles))
END SetStylingEx;

PROCEDURE SetLineState* (scintilla: Handle; line, state: LONGINT);
BEGIN scintilla.Send (scintilla.hnd, SCI_SETLINESTATE, line, state)
END SetLineState;

PROCEDURE GetLineState* (scintilla: Handle; line: LONGINT): LONGINT;
BEGIN RETURN scintilla.Send (scintilla.hnd, SCI_GETLINESTATE, line, 0)
END GetLineState;

PROCEDURE GetMaxLineState* (scintilla: Handle): LONGINT;
BEGIN RETURN scintilla.Send (scintilla.hnd, SCI_GETMAXLINESTATE, 0, 0)
END GetMaxLineState;

(* Tabs and Indentation Guides *)

PROCEDURE SetTabWidth* (scintilla: Handle; widthInChars: LONGINT);
BEGIN scintilla.Send (scintilla.hnd, SCI_SETTABWIDTH, widthInChars, 0)
END SetTabWidth;

PROCEDURE GetTabWidth* (scintilla: Handle): LONGINT;
BEGIN RETURN scintilla.Send (scintilla.hnd, SCI_GETTABWIDTH, 0, 0)
END GetTabWidth;

PROCEDURE SetUseTabs* (scintilla: Handle; useTabs: BOOLEAN);
BEGIN scintilla.Send (scintilla.hnd, SCI_SETUSETABS, ORD (useTabs), 0)
END SetUseTabs;

PROCEDURE GetUseTabs* (scintilla: Handle): BOOLEAN;
BEGIN RETURN scintilla.Send (scintilla.hnd, SCI_GETUSETABS, 0, 0) # 0
END GetUseTabs;

PROCEDURE SetIndent* (scintilla: Handle; indentSize: LONGINT);
BEGIN scintilla.Send (scintilla.hnd, SCI_SETINDENT, indentSize, 0)
END SetIndent;

PROCEDURE GetIndent* (scintilla: Handle): LONGINT;
BEGIN RETURN scintilla.Send (scintilla.hnd, SCI_GETINDENT, 0, 0)
END GetIndent;

PROCEDURE SetTabIndents* (scintilla: Handle; tabIndents: BOOLEAN);
BEGIN scintilla.Send (scintilla.hnd, SCI_SETTABINDENTS, ORD (tabIndents), 0)
END SetTabIndents;

PROCEDURE GetTabIndents* (scintilla: Handle): BOOLEAN;
BEGIN RETURN scintilla.Send (scintilla.hnd, SCI_GETTABINDENTS, 0, 0) # 0
END GetTabIndents;

PROCEDURE SetBackSpaceUnIndents* (scintilla: Handle; bsUnIndents: BOOLEAN);
BEGIN scintilla.Send (scintilla.hnd, SCI_SETBACKSPACEUNINDENTS, ORD (bsUnIndents), 0)
END SetBackSpaceUnIndents;

PROCEDURE GetBackSpaceUnIndents* (scintilla: Handle): BOOLEAN;
BEGIN RETURN scintilla.Send (scintilla.hnd, SCI_GETBACKSPACEUNINDENTS, 0, 0) # 0
END GetBackSpaceUnIndents;

PROCEDURE SetLineIndentation* (scintilla: Handle; line, indentSize: LONGINT);
BEGIN scintilla.Send (scintilla.hnd, SCI_SETLINEINDENTATION, line, indentSize)
END SetLineIndentation;

PROCEDURE GetLineIndentation* (scintilla: Handle; line: LONGINT): LONGINT;
BEGIN RETURN scintilla.Send (scintilla.hnd, SCI_GETLINEINDENTATION, line, 0)
END GetLineIndentation;

PROCEDURE GetLineIndentPosition* (scintilla: Handle; line: LONGINT): LONGINT;
BEGIN RETURN scintilla.Send (scintilla.hnd, SCI_GETLINEINDENTPOSITION, line, 0)
END GetLineIndentPosition;

PROCEDURE SetIndentationGuides* (scintilla: Handle; indentView: LONGINT);
BEGIN scintilla.Send (scintilla.hnd, SCI_SETINDENTATIONGUIDES, indentView, 0)
END SetIndentationGuides;

PROCEDURE GetIndentationGuides* (scintilla: Handle): LONGINT;
BEGIN RETURN scintilla.Send (scintilla.hnd, SCI_GETINDENTATIONGUIDES, 0, 0)
END GetIndentationGuides;

PROCEDURE SetHighlightGuide* (scintilla: Handle; column: LONGINT);
BEGIN scintilla.Send (scintilla.hnd, SCI_SETHIGHLIGHTGUIDE, column, 0)
END SetHighlightGuide;

PROCEDURE GetHighlightGuide* (scintilla: Handle): LONGINT;
BEGIN RETURN scintilla.Send (scintilla.hnd, SCI_GETHIGHLIGHTGUIDE, 0, 0)
END GetHighlightGuide;

(* Autocompletion *)

PROCEDURE AutoCShow* (scintilla: Handle; lenEntered: LONGINT; VAR itemList: ARRAY OF CHAR);
BEGIN scintilla.Send (scintilla.hnd, SCI_AUTOCSHOW, lenEntered, SYSTEM.ADR (itemList))
END AutoCShow;

PROCEDURE AutoCCancel* (scintilla: Handle);
BEGIN scintilla.Send (scintilla.hnd, SCI_AUTOCCANCEL, 0, 0)
END AutoCCancel;

PROCEDURE AutoCActive* (scintilla: Handle): BOOLEAN;
BEGIN RETURN scintilla.Send (scintilla.hnd, SCI_AUTOCACTIVE, 0, 0) # 0
END AutoCActive;

PROCEDURE AutoCPosStart* (scintilla: Handle): LONGINT;
BEGIN RETURN scintilla.Send (scintilla.hnd, SCI_AUTOCPOSSTART, 0, 0)
END AutoCPosStart;

PROCEDURE AutoCComplete* (scintilla: Handle);
BEGIN scintilla.Send (scintilla.hnd, SCI_AUTOCCOMPLETE, 0, 0)
END AutoCComplete;

PROCEDURE AutoCStops* (scintilla: Handle; VAR characterSet: ARRAY OF CHAR);
BEGIN scintilla.Send (scintilla.hnd, SCI_AUTOCSTOPS, 0, SYSTEM.ADR (characterSet))
END AutoCStops;

PROCEDURE AutoCSetSeparator* (scintilla: Handle; separator: CHAR);
BEGIN scintilla.Send (scintilla.hnd, SCI_AUTOCSETSEPARATOR, ORD (separator), 0)
END AutoCSetSeparator;

PROCEDURE AutoCGetSeparator* (scintilla: Handle): CHAR;
BEGIN RETURN CHR (scintilla.Send (scintilla.hnd, SCI_AUTOCGETSEPARATOR, 0, 0))
END AutoCGetSeparator;

PROCEDURE AutoCSelect* (scintilla: Handle; VAR text: ARRAY OF CHAR);
BEGIN scintilla.Send (scintilla.hnd, SCI_AUTOCSELECT, 0, SYSTEM.ADR (text))
END AutoCSelect;

PROCEDURE AutoCGetCurrent* (scintilla: Handle): LONGINT;
BEGIN RETURN scintilla.Send (scintilla.hnd, SCI_AUTOCGETCURRENT, 0, 0)
END AutoCGetCurrent;

PROCEDURE AutoCSetCancelAtStart* (scintilla: Handle; cancel: BOOLEAN);
BEGIN scintilla.Send (scintilla.hnd, SCI_AUTOCSETCANCELATSTART, ORD (cancel), 0)
END AutoCSetCancelAtStart;

PROCEDURE AutoCGetCancelAtStart* (scintilla: Handle): BOOLEAN;
BEGIN RETURN scintilla.Send (scintilla.hnd, SCI_AUTOCGETCANCELATSTART, 0, 0) # 0
END AutoCGetCancelAtStart;

PROCEDURE AutoCSetFillUps* (scintilla: Handle; VAR characterSet: ARRAY OF CHAR);
BEGIN scintilla.Send (scintilla.hnd, SCI_AUTOCSETFILLUPS, 0, SYSTEM.ADR (characterSet))
END AutoCSetFillUps;

PROCEDURE AutoCSetChooseSingle* (scintilla: Handle; chooseSingle: BOOLEAN);
BEGIN scintilla.Send (scintilla.hnd, SCI_AUTOCSETCHOOSESINGLE, ORD (chooseSingle), 0)
END AutoCSetChooseSingle;

PROCEDURE AutoCGetChooseSingle* (scintilla: Handle): BOOLEAN;
BEGIN RETURN scintilla.Send (scintilla.hnd, SCI_AUTOCGETCHOOSESINGLE, 0, 0) # 0
END AutoCGetChooseSingle;

PROCEDURE AutoCSetIgnoreCase* (scintilla: Handle; value: BOOLEAN);
BEGIN scintilla.Send (scintilla.hnd, SCI_AUTOCSETIGNORECASE, ORD (value), 0)
END AutoCSetIgnoreCase;

PROCEDURE AutoCGetIgnoreCase* (scintilla: Handle): BOOLEAN;
BEGIN RETURN scintilla.Send (scintilla.hnd, SCI_AUTOCGETIGNORECASE, 0, 0) # 0
END AutoCGetIgnoreCase;

PROCEDURE AutoCSetAutoHide* (scintilla: Handle; value: BOOLEAN);
BEGIN scintilla.Send (scintilla.hnd, SCI_AUTOCSETAUTOHIDE, ORD (value), 0)
END AutoCSetAutoHide;

PROCEDURE AutoCGetAutoHide* (scintilla: Handle): BOOLEAN;
BEGIN RETURN scintilla.Send (scintilla.hnd, SCI_AUTOCGETAUTOHIDE, 0, 0) # 0
END AutoCGetAutoHide;

PROCEDURE AutoCSetDropRestOfWord* (scintilla: Handle; value: BOOLEAN);
BEGIN scintilla.Send (scintilla.hnd, SCI_AUTOCSETDROPRESTOFWORD, ORD (value), 0)
END AutoCSetDropRestOfWord;

PROCEDURE AutoCGetDropRestOfWord* (scintilla: Handle): BOOLEAN;
BEGIN RETURN scintilla.Send (scintilla.hnd, SCI_AUTOCGETDROPRESTOFWORD, 0, 0) # 0
END AutoCGetDropRestOfWord;

PROCEDURE RegisterImage* (scintilla: Handle; type: LONGINT; VAR xpmData: ARRAY OF CHAR);
BEGIN scintilla.Send (scintilla.hnd, SCI_REGISTERIMAGE, type, SYSTEM.ADR (xpmData))
END RegisterImage;

PROCEDURE ClearRegisteredImages* (scintilla: Handle);
BEGIN scintilla.Send (scintilla.hnd, SCI_CLEARREGISTEREDIMAGES, 0, 0)
END ClearRegisteredImages;

PROCEDURE AutoCSetTypeSeparator* (scintilla: Handle; value: CHAR);
BEGIN scintilla.Send (scintilla.hnd, SCI_AUTOCSETTYPESEPARATOR, ORD (value), 0)
END AutoCSetTypeSeparator;

PROCEDURE AutoCGetTypeSeparator* (scintilla: Handle): CHAR;
BEGIN RETURN CHR (scintilla.Send (scintilla.hnd, SCI_AUTOCGETTYPESEPARATOR, 0, 0))
END AutoCGetTypeSeparator;

PROCEDURE AutoCSetMaxWidth* (scintilla: Handle; value: LONGINT);
BEGIN scintilla.Send (scintilla.hnd, SCI_AUTOCSETMAXWIDTH, value, 0)
END AutoCSetMaxWidth;

PROCEDURE AutoCGetMaxWidth* (scintilla: Handle): LONGINT;
BEGIN RETURN scintilla.Send (scintilla.hnd, SCI_AUTOCGETMAXWIDTH, 0, 0)
END AutoCGetMaxWidth;

PROCEDURE AutoCSetMaxHeight* (scintilla: Handle; value: LONGINT);
BEGIN scintilla.Send (scintilla.hnd, SCI_AUTOCSETMAXHEIGHT, value, 0)
END AutoCSetMaxHeight;

PROCEDURE AutoCGetMaxHeight* (scintilla: Handle): LONGINT;
BEGIN RETURN scintilla.Send (scintilla.hnd, SCI_AUTOCGETMAXHEIGHT, 0, 0)
END AutoCGetMaxHeight;

(* User lists *)

PROCEDURE UserListShow* (scintilla: Handle; type: LONGINT; VAR list: ARRAY OF CHAR);
BEGIN scintilla.Send (scintilla.hnd, SCI_USERLISTSHOW, type, SYSTEM.ADR (list))
END UserListShow;

(* Call tips *)

PROCEDURE CallTipShow* (scintilla: Handle; posStart: LONGINT; VAR definition: ARRAY OF CHAR);
BEGIN scintilla.Send (scintilla.hnd, SCI_CALLTIPSHOW, posStart, SYSTEM.ADR (definition))
END CallTipShow;

PROCEDURE CallTipCancel* (scintilla: Handle);
BEGIN scintilla.Send (scintilla.hnd, SCI_CALLTIPCANCEL, 0, 0)
END CallTipCancel;

PROCEDURE CallTipActive* (scintilla: Handle): BOOLEAN;
BEGIN RETURN scintilla.Send (scintilla.hnd, SCI_CALLTIPACTIVE, 0, 0) # 0
END CallTipActive;

PROCEDURE CallTipPosStart* (scintilla: Handle): LONGINT;
BEGIN RETURN scintilla.Send (scintilla.hnd, SCI_CALLTIPPOSSTART, 0, 0)
END CallTipPosStart;

PROCEDURE CallTipSetHlt* (scintilla: Handle; start, end: LONGINT);
BEGIN scintilla.Send (scintilla.hnd, SCI_CALLTIPSETHLT, start, end)
END CallTipSetHlt;

PROCEDURE CallTipSetBack* (scintilla: Handle; value: LONGINT);
BEGIN scintilla.Send (scintilla.hnd, SCI_CALLTIPSETBACK, value, 0)
END CallTipSetBack;

PROCEDURE CallTipSetFore* (scintilla: Handle; value: LONGINT);
BEGIN scintilla.Send (scintilla.hnd, SCI_CALLTIPSETFORE, value, 0)
END CallTipSetFore;

PROCEDURE CallTipSetForeHlt* (scintilla: Handle; value: LONGINT);
BEGIN scintilla.Send (scintilla.hnd, SCI_CALLTIPSETFOREHLT, value, 0)
END CallTipSetForeHlt;

PROCEDURE CallTipUseStyle* (scintilla: Handle; tabSize: LONGINT);
BEGIN scintilla.Send (scintilla.hnd, SCI_CALLTIPUSESTYLE, tabSize, 0)
END CallTipUseStyle;

(* Keyboard commands *)

PROCEDURE LineDown* (scintilla: Handle);
BEGIN scintilla.Send (scintilla.hnd, SCI_LINEDOWN, 0, 0)
END LineDown;

PROCEDURE LineDownExtend* (scintilla: Handle);
BEGIN scintilla.Send (scintilla.hnd, SCI_LINEDOWNEXTEND, 0, 0)
END LineDownExtend;

PROCEDURE LineDownRectExtend* (scintilla: Handle);
BEGIN scintilla.Send (scintilla.hnd, SCI_LINEDOWNRECTEXTEND, 0, 0)
END LineDownRectExtend;

PROCEDURE LineScrollDown* (scintilla: Handle);
BEGIN scintilla.Send (scintilla.hnd, SCI_LINESCROLLDOWN, 0, 0)
END LineScrollDown;

PROCEDURE LineUp* (scintilla: Handle);
BEGIN scintilla.Send (scintilla.hnd, SCI_LINEUP, 0, 0)
END LineUp;

PROCEDURE LineUpExtend* (scintilla: Handle);
BEGIN scintilla.Send (scintilla.hnd, SCI_LINEUPEXTEND, 0, 0)
END LineUpExtend;

PROCEDURE LineUpRectExtend* (scintilla: Handle);
BEGIN scintilla.Send (scintilla.hnd, SCI_LINEUPRECTEXTEND, 0, 0)
END LineUpRectExtend;

PROCEDURE LineScrollUp* (scintilla: Handle);
BEGIN scintilla.Send (scintilla.hnd, SCI_LINESCROLLUP, 0, 0)
END LineScrollUp;

PROCEDURE ParaDown* (scintilla: Handle);
BEGIN scintilla.Send (scintilla.hnd, SCI_PARADOWN, 0, 0)
END ParaDown;

PROCEDURE ParaDownExtend* (scintilla: Handle);
BEGIN scintilla.Send (scintilla.hnd, SCI_PARADOWNEXTEND, 0, 0)
END ParaDownExtend;

PROCEDURE ParaUp* (scintilla: Handle);
BEGIN scintilla.Send (scintilla.hnd, SCI_PARAUP, 0, 0)
END ParaUp;

PROCEDURE ParaUpExtend* (scintilla: Handle);
BEGIN scintilla.Send (scintilla.hnd, SCI_PARAUPEXTEND, 0, 0)
END ParaUpExtend;

PROCEDURE CharLeft* (scintilla: Handle);
BEGIN scintilla.Send (scintilla.hnd, SCI_CHARLEFT, 0, 0)
END CharLeft;

PROCEDURE CharLeftExtend* (scintilla: Handle);
BEGIN scintilla.Send (scintilla.hnd, SCI_CHARLEFTEXTEND, 0, 0)
END CharLeftExtend;

PROCEDURE CharLeftRectExtend* (scintilla: Handle);
BEGIN scintilla.Send (scintilla.hnd, SCI_CHARLEFTRECTEXTEND, 0, 0)
END CharLeftRectExtend;

PROCEDURE CharRight* (scintilla: Handle);
BEGIN scintilla.Send (scintilla.hnd, SCI_CHARRIGHT, 0, 0)
END CharRight;

PROCEDURE CharRightExtend* (scintilla: Handle);
BEGIN scintilla.Send (scintilla.hnd, SCI_CHARRIGHTEXTEND, 0, 0)
END CharRightExtend;

PROCEDURE CharRightRectExtend* (scintilla: Handle);
BEGIN scintilla.Send (scintilla.hnd, SCI_CHARRIGHTRECTEXTEND, 0, 0)
END CharRightRectExtend;

-- TODO: add the missing commands

PROCEDURE NewLine* (scintilla: Handle);
BEGIN scintilla.Send (scintilla.hnd, SCI_NEWLINE, 0, 0)
END NewLine;

PROCEDURE FormFeed* (scintilla: Handle);
BEGIN scintilla.Send (scintilla.hnd, SCI_FORMFEED, 0, 0)
END FormFeed;

PROCEDURE Tab* (scintilla: Handle);
BEGIN scintilla.Send (scintilla.hnd, SCI_TAB, 0, 0)
END Tab;

PROCEDURE BackTab* (scintilla: Handle);
BEGIN scintilla.Send (scintilla.hnd, SCI_BACKTAB, 0, 0)
END BackTab;

PROCEDURE SelectionDuplicate* (scintilla: Handle);
BEGIN scintilla.Send (scintilla.hnd, SCI_SELECTIONDUPLICATE, 0, 0)
END SelectionDuplicate;

(* Direct access *)

PROCEDURE GetDirectFunction (hwnd: Win.HWND): SendFunction;
BEGIN RETURN SYSTEM.VAL (SendFunction, Win.SendMessage (hwnd, SCI_GETDIRECTFUNCTION, 0, 0))
END GetDirectFunction;

PROCEDURE GetDirectPointer (hwnd: Win.HWND): LONGINT;
BEGIN RETURN Win.SendMessage (hwnd, SCI_GETDIRECTPOINTER, 0, 0)
END GetDirectPointer;

PROCEDURE ['C'] WinSendMessage (hnd, msg, par1, par2: LONGINT): LONGINT;
(* This procedure merely converts C calling convention to StdCall. *)
BEGIN RETURN Win.SendMessage (SYSTEM.VAL (Win.HWND, hnd), msg, par1, par2)
END WinSendMessage;

PROCEDURE Init* (VAR hnd: Handle; scintilla: Win.HWND; directMode: BOOLEAN);
(** Use directMode = TRUE if you know that Scintilla component is accessed
  * from the same thread it was created in, i.e. if no message synchronization
  * is needed. Otherwise you should use the synchronized access (via
  * Win.SendMessage), which is slower. Most of the time you want to set
  * directMode = TRUE. *)
BEGIN
   IF directMode THEN
      hnd.hnd := GetDirectPointer (scintilla);
      hnd.Send := GetDirectFunction (scintilla);
   ELSE
      hnd.hnd := SYSTEM.VAL (LONGINT, scintilla);
      hnd.Send := WinSendMessage;
   END;
END Init;

(* Folding *)

PROCEDURE VisibleFromDocLine* (scintilla: Handle; docLine: LONGINT): LONGINT;
BEGIN RETURN scintilla.Send (scintilla.hnd, SCI_VISIBLEFROMDOCLINE, docLine, 0)
END VisibleFromDocLine;

PROCEDURE DocLineFromVisible* (scintilla: Handle; displayLine: LONGINT): LONGINT;
BEGIN RETURN scintilla.Send (scintilla.hnd, SCI_DOCLINEFROMVISIBLE, displayLine, 0)
END DocLineFromVisible;

PROCEDURE ShowLines* (scintilla: Handle; lineStart, lineEnd: LONGINT);
BEGIN scintilla.Send (scintilla.hnd, SCI_SHOWLINES, lineStart, lineEnd)
END ShowLines;

PROCEDURE HideLines* (scintilla: Handle; lineStart, lineEnd: LONGINT);
BEGIN scintilla.Send (scintilla.hnd, SCI_HIDELINES, lineStart, lineEnd)
END HideLines;

PROCEDURE GetLineVisible* (scintilla: Handle; line: LONGINT): BOOLEAN;
BEGIN RETURN scintilla.Send (scintilla.hnd, SCI_GETLINEVISIBLE, line, 0) # 0
END GetLineVisible;

PROCEDURE SetFoldLevel* (scintilla: Handle; line, level: LONGINT);
BEGIN scintilla.Send (scintilla.hnd, SCI_SETFOLDLEVEL, line, level)
END SetFoldLevel;

PROCEDURE GetFoldLevel* (scintilla: Handle; line: LONGINT): LONGINT;
BEGIN RETURN scintilla.Send (scintilla.hnd, SCI_GETFOLDLEVEL, line, 0)
END GetFoldLevel;

PROCEDURE SetFoldFlags* (scintilla: Handle; flags: SET);
BEGIN scintilla.Send (scintilla.hnd, SCI_SETFOLDFLAGS, SYSTEM.VAL (LONGINT, flags), 0)
END SetFoldFlags;

PROCEDURE GetLastChild* (scintilla: Handle; line, level: LONGINT): LONGINT;
BEGIN RETURN scintilla.Send (scintilla.hnd, SCI_GETLASTCHILD, line, level)
END GetLastChild;

PROCEDURE GetFoldParent* (scintilla: Handle; line: LONGINT): LONGINT;
BEGIN RETURN scintilla.Send (scintilla.hnd, SCI_GETFOLDPARENT, line, 0)
END GetFoldParent;

PROCEDURE SetFoldExpanded* (scintilla: Handle; line: LONGINT; expanded: BOOLEAN);
BEGIN scintilla.Send (scintilla.hnd, SCI_SETFOLDEXPANDED, line, ORD (expanded))
END SetFoldExpanded;

PROCEDURE GetFoldExpanded* (scintilla: Handle; line: LONGINT): BOOLEAN;
BEGIN RETURN scintilla.Send (scintilla.hnd, SCI_GETFOLDEXPANDED, line, 0) # 0
END GetFoldExpanded;

PROCEDURE ToggleFold* (scintilla: Handle; line: LONGINT);
BEGIN scintilla.Send (scintilla.hnd, SCI_TOGGLEFOLD, line, 0)
END ToggleFold;

PROCEDURE EnsureVisible* (scintilla: Handle; line: LONGINT);
BEGIN scintilla.Send (scintilla.hnd, SCI_ENSUREVISIBLE, line, 0)
END EnsureVisible;

PROCEDURE EnsureVisibleEnforcePolicy* (scintilla: Handle; line: LONGINT);
BEGIN scintilla.Send (scintilla.hnd, SCI_ENSUREVISIBLEENFORCEPOLICY, line, 0)
END EnsureVisibleEnforcePolicy;

(* Custom procedures *)

PROCEDURE GetSelectionExtent* (scintilla: Handle; VAR start, end: LONGINT; VAR cursorAtEnd: BOOLEAN);
(* Return the current selection extent (start < end). If there is no selection,
 * start = end = curent caret position. cursorAtEnd = TRUE if the cursor is at
 * the end of the selected text stretch. *)
BEGIN
   start := GetSelectionStart (scintilla);
   end := GetSelectionEnd (scintilla);
   cursorAtEnd := (start = end) OR (end = GetCurrentPos (scintilla))
END GetSelectionExtent;

PROCEDURE SetSelectionExtent* (scintilla: Handle; start, end: LONGINT; cursorAtEnd: BOOLEAN);
BEGIN
   IF cursorAtEnd THEN
      SetAnchor (scintilla, start);
      SetCurrentPos (scintilla, end);
   ELSE
      SetCurrentPos (scintilla, start);
      SetAnchor (scintilla, end);
   END
END SetSelectionExtent;

PROCEDURE InsertBuff* (scintilla: Handle; pos: LONGINT; VAR text: ARRAY OF CHAR; from, to: LONGINT);
(** Same as InsertText, but only insert text [from..to - 1].
  * Pre: 0 <= from <= to < LEN (text) *)
VAR
   saved: CHAR;
BEGIN
   ASSERT ((0 <= from) & (from < LEN (text)), 20);
   ASSERT ((0 <= to) & (to < LEN (text)), 21);
   ASSERT (from <= to, 22);
   saved := text [to];
   text [to] := 0X;
   scintilla.Send (scintilla.hnd, SCI_INSERTTEXT, pos, SYSTEM.ADR (text [from]));
   text [to] := saved;
END InsertBuff;

PROCEDURE InsertEol* (scintilla: Handle; pos: LONGINT): SHORTINT;
(** Insert EOL at 'pos' according to the current GetEolMode setting. Return
  * the number of characters inserted: 0..2 (0 means error). *)
CONST
   CRLF = '' + 0DX + 0AX;
   CR = '' + 0DX;
   LF = '' + 0AX;
VAR
   eol: ARRAY 3 OF CHAR;
   res: SHORTINT;
BEGIN
   CASE GetEolMode (scintilla) OF
   | eolCRLF: eol := CRLF; res := 2;
   | eolCR  : eol := CR  ; res := 1;
   | eolLF  : eol := LF  ; res := 1;
   ELSE
      eol := ''; res := 0;
   END;
   InsertText (scintilla, pos, eol);
   RETURN res
END InsertEol;

END Scintilla.
