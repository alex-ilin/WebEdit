<*+main*> (* This marks the main module of a program or library.               *)
<*heaplimit="10000"*> (* Maximum heap size should be set in the main module,
because the changes do not take effect until the main module is recompiled.    *)
MODULE NppWebEdit;

(* ---------------------------------------------------------------------------
 * (C) 2008 by Alexander Iljin
 * --------------------------------------------------------------------------- *)

IMPORT
   SYSTEM,Win:=Windows;

(* ---------------------------------------------------------------------------
 * This is a simple Notepad++ plugin (XDS Oberon module). It can surround a
 * stretch of selected text with a pair of strings, e.g. HTML tags.
 *
 * HOW TO add a new function:
 *   increase NumFuncs constant;
 *   make a copy of the MakePBlock procedure, rename it and edit its contents;
 *   add a new block to the Init procedure.
 *
 * For the free XDS Modula-2/Oberon-2 compiler go to:
 *   http://www.excelsior-usa.com/xdsx86win.html
 *   (6.6 Mb to download, 17 Mb installed);
 * Oberon-2 is object-oriented programming language, both powerful and simple.
 * The full language report is only 20 pages long:
 *   http://europrog.ru/paper/oberon-2.pdf
 * It was created by prof. N.Wirth, author of Pascal and Modula. Some of his
 * publications:
 *   Programming in Oberon: http://europrog.ru/book/obnw2004e.pdf
 *   Compiler Construction: http://europrog.ru/book/ccnw2005e.pdf
 *   Project Oberon — The Design of an Operating System and Compiler:
 *     http://europrog.ru/book/ponw2005e.pdf
 *
 * Note: in order to keep the DLL size as small as possible I did not use any
 * of the advanced language features like automatic memory management (Garbage
 * Collector), array bounds checking, etc. These features require linking of
 * the runtime library, which increases the DLL size by 39 Kb.
 * If you get link-time errors like:
 *   Error (54): Name 'X2C_...' not found ...
 * your code requires the runtime library. You can allow linking it by
 * commenting or deleting the NoRuntimeLibs option from NppWebEdit.prj.
 *
 * PS: All procedures to be called from Notepad must be declared with ['C']
 * calling convention.
 * --------------------------------------------------------------------------- *)

CONST
   PluginName = 'NppWebEdit';
   NumFuncs = 2;

   (* Menu items *)
   MakePBlockStr = '<p>...</p>';
   AboutStr = 'About...';

   CRLF = ''+0DX+0AX;
   AboutMsg = 'This small freeware plugin allows you to wrap the selected text in tag pairs.'+CRLF
      +'Assign shortcuts via Settings - Shortcut Mapper - Plugin commands.'+CRLF
      +CRLF
      +'Created by Alexander Iljin (Amadeus IT Solutions) using XDS Oberon, 06 Mar 2008.';

   (* Scintilla command codes - get more from Scintilla.h *)
   SCI_INSERTTEXT = 2003;
   SCI_GETSELECTIONSTART = 2143;
   SCI_GETSELECTIONEND = 2145;

   (* Notepad++ notification codes - not used *)
   NPPN_FIRST = 1000;
   NPPN_READY = NPPN_FIRST + 1;

   (* Notepad++ command codes *)
   NPPMSG = Win.WM_USER + 1000;
   NPPM_GETCURRENTSCINTILLA = NPPMSG + 4;

TYPE
   Shortcut = POINTER TO ShortcutDesc;
   ShortcutDesc = RECORD
      ctrl : BOOLEAN;
      alt  : BOOLEAN;
      shift: BOOLEAN;
      key  : CHAR;
   END;

   FuncItem = RECORD
      itemName: ARRAY 64 OF CHAR;
      pFunc   : PROCEDURE ['C'];
      cmdID   : LONGINT;
      initChk : LONGINT;
      shortcut: Shortcut;
   END;

   SCNotification = RECORD
      nmhdr: Win.NMHDR;
      (* other fields are not used in this plugin *)
   END;

VAR
   nppHandle: Win.HWND;
   scintillaMainHandle: Win.HWND;
   scintillaSecondHandle: Win.HWND;
   FI: ARRAY NumFuncs OF FuncItem;

PROCEDURE GetCurrentScintilla (): Win.HWND;
(* Return handle of the currently active Scintilla view or NIL on error. *)
VAR res: LONGINT;
BEGIN
   Win.SendMessage (nppHandle, NPPM_GETCURRENTSCINTILLA, 0, SYSTEM.ADR (res));
   IF res = 0 THEN
      RETURN scintillaMainHandle
   ELSIF res = 1 THEN
      RETURN scintillaSecondHandle
   END;
   RETURN NIL
END GetCurrentScintilla;

PROCEDURE InsertText (scintilla: Win.HWND; pos: LONGINT; VAR text: ARRAY OF CHAR);
BEGIN
   Win.SendMessage (scintilla, SCI_INSERTTEXT, pos, SYSTEM.ADR (text));
END InsertText;

PROCEDURE GetSelectionExtent (scintilla: Win.HWND; VAR start, end: LONGINT);
(* Return the current selection extent (start < end). If there is no selection,
 * start = end = curent caret position. *)
BEGIN
   start := Win.SendMessage (scintilla, SCI_GETSELECTIONSTART, 0, 0);
   end := Win.SendMessage (scintilla, SCI_GETSELECTIONEND, 0, 0);
END GetSelectionExtent;

PROCEDURE SurroundSelection (scintilla: Win.HWND; leftText, rightText: ARRAY OF CHAR);
VAR start, end: LONGINT;
BEGIN
   GetSelectionExtent (scintilla, start, end);
   InsertText (scintilla, start, leftText);
   INC (end, LEN (leftText) - 1);
   InsertText (scintilla, end, rightText);
END SurroundSelection;

PROCEDURE ['C'] MakePBlock ();
(* Surround currently selected text in the current Scintilla view with a pair
 * of <p>...</p> tags. *)
VAR sci: Win.HWND;
BEGIN
   sci := GetCurrentScintilla ();
   SurroundSelection (sci, '<p>', '</p>');
END MakePBlock;

PROCEDURE ['C'] About ();
(* Show info about this plugin. *)
BEGIN
   Win.MessageBox (nppHandle, AboutMsg, PluginName, Win.MB_OK);
END About;

(* --- Notepad++ required plugin functions --- *)

PROCEDURE ['C'] setInfo* (npp, scintillaMain, scintillaSecond: Win.HWND);
(** Notepad++ gives the main window handles, we'll need them later. *)
BEGIN
   nppHandle := npp;
   scintillaMainHandle := scintillaMain;
   scintillaSecondHandle := scintillaSecond;
END setInfo;

PROCEDURE ['C'] getName* (): Win.PCHAR;
(** Return the name of this plugin *)
BEGIN
   RETURN SYSTEM.VAL (Win.PCHAR, SYSTEM.ADR (PluginName));
END getName;

PROCEDURE ['C'] beNotified* (VAR note: SCNotification);
(** Receive various notifications from Notepad++. *)
BEGIN
   IF (note.nmhdr.hwndFrom = nppHandle) & (note.nmhdr.code = NPPN_READY) THEN
      (* the startup of Notepad++ is complete, you may perform additional
       * plugin initialization here *)
   END
END beNotified;

PROCEDURE ['C'] messageProc* (msg: Win.UINT; wParam: Win.WPARAM; lParam: Win.LPARAM): Win.LRESULT;
BEGIN
   RETURN 0
END messageProc;

PROCEDURE Init ();
(* Initialize the global FI array - list of exported functions. *)
BEGIN
   COPY (MakePBlockStr, FI [0].itemName); (* string assignment is performed via COPY *)
   FI [0].pFunc := MakePBlock;
   FI [0].cmdID := 0;
   FI [0].initChk := 0;
   FI [0].shortcut := NIL;

   COPY (AboutStr, FI [1].itemName);
   FI [1].pFunc := About;
   FI [1].cmdID := 0;
   FI [1].initChk := 0;
   FI [1].shortcut := NIL;
END Init;

PROCEDURE ['C'] getFuncsArray* (VAR nFuncs: LONGINT): LONGINT;
(** Notepad++ requests the list of exported functions. *)
BEGIN
   Init;
   nFuncs := LEN (FI);
   RETURN SYSTEM.ADR (FI);
END getFuncsArray;

END NppWebEdit.
