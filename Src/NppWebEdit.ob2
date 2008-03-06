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
 * This is a simple Notepad++ plugin (XDS Oberon module). It can wrap a stretch
 * of selected text with a pair of strings, e.g. HTML tags.
 *
 * For the free XDS Modula-2/Oberon-2 compiler go to:
 *   http://www.excelsior-usa.com/xdsx86win.html
 * Oberon-2 is object-oriented programming language, both powerful and simple.
 * The full language report is only 20 pages long:
 *   http://europrog.ru/paper/oberon-2.pdf
 * It was created by prof. N.Wirth. Some of his publications:
 *   Programming in Oberon: http://europrog.ru/book/obnw2004e.pdf
 *   Compiler Construction: http://europrog.ru/book/ccnw2005e.pdf
 *   Project Oberon — The Design of an Operating System and Compiler:
 *     http://europrog.ru/book/ponw2005e.pdf
 * --------------------------------------------------------------------------- *)

CONST
   PluginName = 'NppWebEdit';
   (* Menu items *)
   RegisterStr = 'Register shortcuts';
   AboutStr = 'About...';

   AboutMsg = 'This is a freeware plugin for Notepad++ v.4.8 and later.'+0DX+0AX
      +'This small plugin adds the standard Ctrl+INS, Shift+INS and Shift+DEL'
         +' key combinations to Scintilla on startup.'+0DX+0AX
      +0DX+0AX
      +'Known problem: the Shortcut Mapper does not preserve shortcuts registered by this plugin.'+0DX+0AX
      +"After you've used the Shortcut Mapper you may want to manually register those again using menu:"+0DX+0AX
      +'   Plugins -> '+PluginName+' -> '+RegisterStr+0DX+0AX
      +'or simply restart Notepad++.'+0DX+0AX
      +0DX+0AX
      +'Created by Alexander Iljin (Amadeus IT Solutions) using XDS Oberon, 28 Feb 2008.';

   (* Scintilla keyboard constants *)
   SCK_DELETE = 308;
   SCK_INSERT = 309;
   SCMOD_SHIFT = 1;
   SCMOD_CTRL = 2;

   (* Scintilla command codes - get more from Scintilla.h *)
   SCI_INSERTTEXT = 2003;
   SCI_ASSIGNCMDKEY = 2070;
   SCI_GETSELECTIONSTART = 2143;
   SCI_GETSELECTIONEND = 2145;
   SCI_CUT = 2177;
   SCI_COPY = 2178;
   SCI_PASTE = 2179;
   
   (* Notepad++ notification codes *)
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
   FI: ARRAY 2 OF FuncItem;

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

PROCEDURE RegisterHotkeys (scintillaHandle: Win.HWND);
BEGIN
   Win.SendMessage (scintillaHandle, SCI_ASSIGNCMDKEY, SCMOD_SHIFT * 65536 + SCK_DELETE, SCI_CUT);
   Win.SendMessage (scintillaHandle, SCI_ASSIGNCMDKEY, SCMOD_CTRL  * 65536 + SCK_INSERT, SCI_COPY);
   Win.SendMessage (scintillaHandle, SCI_ASSIGNCMDKEY, SCMOD_SHIFT * 65536 + SCK_INSERT, SCI_PASTE);
END RegisterHotkeys;

PROCEDURE RegisterAll ();
BEGIN
   RegisterHotkeys (scintillaMainHandle);
   RegisterHotkeys (scintillaSecondHandle);
END RegisterAll;

PROCEDURE ['C'] Register ();
BEGIN
   RegisterAll;
END Register;

PROCEDURE ['C'] About ();
BEGIN
   Win.MessageBox (nppHandle, AboutMsg, PluginName, Win.MB_OK);
END About;

PROCEDURE ['C'] setInfo* (npp, scintillaMain, scintillaSecond: Win.HWND);
BEGIN
   nppHandle := npp;
   scintillaMainHandle := scintillaMain;
   scintillaSecondHandle := scintillaSecond;
END setInfo;

PROCEDURE ['C'] getName* (): Win.PCHAR;
BEGIN
   RETURN SYSTEM.VAL (Win.PCHAR, SYSTEM.ADR (PluginName));
END getName;

PROCEDURE ['C'] beNotified* (VAR note: SCNotification);
BEGIN
   IF (note.nmhdr.hwndFrom = nppHandle) & (note.nmhdr.code = NPPN_READY) THEN
      RegisterAll;
   END
END beNotified;

PROCEDURE ['C'] messageProc* (msg: Win.UINT; wParam: Win.WPARAM; lParam: Win.LPARAM): Win.LRESULT;
BEGIN
   RETURN 0
END messageProc;

PROCEDURE Init ();
BEGIN
   COPY (RegisterStr, FI [0].itemName);
   FI [0].pFunc := Register;
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
BEGIN
   Init;
   nFuncs := LEN (FI);
   RETURN SYSTEM.ADR (FI);
END getFuncsArray;

END NppWebEdit.
