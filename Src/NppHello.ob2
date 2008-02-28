<*+main*> (* This marks the main module of a program or library.               *)
<*heaplimit="1000000"*> (* Maximum heap size should be set in the main module,
because the changes do not take effect until the main module is recompiled.    *)
MODULE NppHello;

(* ---------------------------------------------------------------------------
 * (C) 2008 by Alexander Iljin
 * --------------------------------------------------------------------------- *)

IMPORT
   SYSTEM,Win:=Windows;

(* ---------------------------------------------------------------------------
 * This is a simple Notepad++ plugin (XDS Oberon module).
 * --------------------------------------------------------------------------- *)

CONST
   PluginName = 'NppHello';

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

VAR
   nppHandle: Win.HWND;
   scintillaMainHandle: Win.HWND;
   scintillaSecondHandle: Win.HWND;
   FI: ARRAY 2 OF FuncItem;

PROCEDURE ['C'] MyProc ();
BEGIN
   Win.MessageBox (nppHandle, 'MyProc', PluginName, Win.MB_OK);
END MyProc;

PROCEDURE ['C'] MyProc2 ();
BEGIN
   Win.MessageBox (nppHandle, 'MyProc2', PluginName, Win.MB_OK);
END MyProc2;

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

PROCEDURE ['C'] beNotified* ();
BEGIN
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

PROCEDURE NewShortcut (VAR s: Shortcut; key: CHAR);
BEGIN
   NEW (s);
   s.shift := FALSE;
   s.ctrl := FALSE;
   s.alt := FALSE;
   s.key := key;
END NewShortcut;

PROCEDURE Init ();
VAR s: Shortcut;
BEGIN
   COPY ('MyProc', FI [0].itemName);
   FI [0].pFunc := MyProc;
   FI [0].cmdID := 0;
   FI [0].initChk := 0;
   NewShortcut (s, '9');
   s.ctrl := TRUE;
   FI [0].shortcut := s;

   COPY ('MyProc2', FI [1].itemName);
   FI [1].pFunc := MyProc2;
   FI [1].cmdID := 0;
   FI [1].initChk := 1;
   NewShortcut (s, '0');
   s.ctrl := TRUE;
   FI [1].shortcut := s;
END Init;

BEGIN
   Init;
END NppHello.
