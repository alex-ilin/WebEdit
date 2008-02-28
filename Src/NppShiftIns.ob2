<*+main*> (* This marks the main module of a program or library.               *)
<*heaplimit="1000000"*> (* Maximum heap size should be set in the main module,
because the changes do not take effect until the main module is recompiled.    *)
MODULE NppShiftIns;

(* ---------------------------------------------------------------------------
 * (C) 2008 by Alexander Iljin
 * --------------------------------------------------------------------------- *)

IMPORT
   SYSTEM,Win:=Windows;

(* ---------------------------------------------------------------------------
 * This is a simple Notepad++ plugin (XDS Oberon module).
 * --------------------------------------------------------------------------- *)

CONST
   PluginName = 'NppShiftIns';
   AboutMsg = 'This small plugin adds the standard Ctrl+INS, Shift+INS and Shift+DEL'
         +' key combinations to Scintilla.'+0DX+0AX
      +'Freeware for Notepad++ v.4.8 and later.'+0DX+0AX
      +0DX+0AX
      +'Created by Alexander Iljin (Amadeus IT Solutions) using XDS Oberon, 28 Feb 2007.';

   (* Scintilla keyboard constants *)
   SCK_DELETE = 308;
   SCK_INSERT = 309;
   SCMOD_SHIFT = 1;
   SCMOD_CTRL = 2;

   (* Scintilla command codes *)
   SCI_ASSIGNCMDKEY = 2070;
   SCI_CUT = 2177;
   SCI_COPY = 2178;
   SCI_PASTE = 2179;
   
   (* Notepad++ notification codes *)
   NPPN_FIRST = 1000;
   NPPN_READY = NPPN_FIRST + 1;

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
   FI: ARRAY 1 OF FuncItem;

PROCEDURE ['C'] About ();
BEGIN
   Win.MessageBox (nppHandle, AboutMsg, PluginName, Win.MB_OK);
END About;

PROCEDURE RegisterHotkeys (scintillaHandle: Win.HWND);
BEGIN
   Win.SendMessage (scintillaHandle, SCI_ASSIGNCMDKEY, SCMOD_SHIFT * 65536 + SCK_DELETE, SCI_CUT);
   Win.SendMessage (scintillaHandle, SCI_ASSIGNCMDKEY, SCMOD_CTRL  * 65536 + SCK_INSERT, SCI_COPY);
   Win.SendMessage (scintillaHandle, SCI_ASSIGNCMDKEY, SCMOD_SHIFT * 65536 + SCK_INSERT, SCI_PASTE);
END RegisterHotkeys;

PROCEDURE ['C'] setInfo* (npp, scintillaMain, scintillaSecond: Win.HWND);
BEGIN
   nppHandle := npp;
   scintillaMainHandle := scintillaMain;
   scintillaSecondHandle := scintillaSecond;
END setInfo;

PROCEDURE ['C'] getName* (): Win.PCHAR;
BEGIN
   RETURN SYSTEM.VAL (Win.PCHAR, SYSTEM.ADR (PluginName [0]));
END getName;

PROCEDURE ['C'] beNotified* (VAR note: SCNotification);
BEGIN
   IF (note.nmhdr.hwndFrom = nppHandle) & (note.nmhdr.code = NPPN_READY) THEN
      RegisterHotkeys (scintillaMainHandle);
      RegisterHotkeys (scintillaSecondHandle);
   END
END beNotified;

PROCEDURE ['C'] messageProc* (msg: Win.UINT; wParam: Win.WPARAM; lParam: Win.LPARAM): Win.LRESULT;
BEGIN
   RETURN 0
END messageProc;

PROCEDURE ['C'] getFuncsArray* (VAR nFuncs: LONGINT): LONGINT;
BEGIN
   nFuncs := LEN (FI);
   RETURN SYSTEM.ADR (FI);
END getFuncsArray;

PROCEDURE Init ();
BEGIN
   COPY ('About...', FI [0].itemName);
   FI [0].pFunc := About;
   FI [0].cmdID := 0;
   FI [0].initChk := 0;
   FI [0].shortcut := NIL;
END Init;

BEGIN
   Init;
END NppShiftIns.
