<*+main*> (* This marks the main module of a program or library.               *)
<*heaplimit="0"*> (* Maximum heap size should be set in the main module,
because the changes do not take effect until the main module is recompiled.    *)

MODULE WebEdit;

(* ---------------------------------------------------------------------------
 * (C) 2008 - 2011 by Alexander Iljin
 * --------------------------------------------------------------------------- *)

IMPORT
   SYSTEM,Win:=Windows,Sci:=Scintilla,Npp:=NotepadPP,oberonRTS,Str,Tags,
   Ver:=WebEditVer,Ini:=IniFiles,Settings;

(* ---------------------------------------------------------------------------
 * This is a simple Notepad++ plugin (XDS Oberon module). It can surround a
 * stretch of selected text with a pair of strings, e.g. HTML tags.
 *
 * If you want this plugin to support more than 30 commands, do the following:
 * - set MaxFuncs constant to the desired value;
 * - create new FuncXX functions up to the required number (last XX =
 *   MaxFuncs - 1);
 * - append the funcs array initialization in the Init procedure;
 * - recompile the project.
 *
 * For the free optimizing XDS Modula-2/Oberon-2 compiler go to:
 *   http://www.excelsior-usa.com/xdsx86win.html
 *   (6.6 Mb to download, 17 Mb installed);
 * Oberon-2 is object-oriented programming language, both powerful and simple.
 * The full language report is only 20 pages long:
 *   http://europrog.ru/paper/oberon-2.pdf
 * It was created by prof. N.Wirth, author of Pascal-family of programming
 * languages. Some of his publications (available in full text):
 *   Programming in Oberon: http://europrog.ru/book/obnw2004e.pdf
 *   Compiler Construction: http://europrog.ru/book/ccnw2005e.pdf
 *   Project Oberon — The Design of an Operating System and Compiler:
 *     http://europrog.ru/book/ponw2005e.pdf
 * --------------------------------------------------------------------------- *)

CONST
   MaxFuncs = 30; (* 0 < MaxFuncs < 100 *)

   (* Menu items *)
   NumChar = 'X'; (* this character is a placeholder for a number in NotUsedFuncStr *)
   NotUsedFuncStr = 'WebEdit Slot XX';
   ReplaceTagStr = 'Replace Tag';
   EditConfigStr = 'Edit Config';
   LoadConfigStr = 'Load Config';
   AboutStr = 'About...';

   CommandsIniSection = 'Commands';
   ToolbarIniSection  = 'Toolbar';
   TagsIniSection     = 'Tags';
   CRLF = ''+0DX+0AX;
   AboutMsg = 'This small freeware plugin allows you to wrap the selected text in tag pairs and expand abbreviations using a hotkey.'+CRLF
      +'For more information refer to '+Settings.PluginName+'.txt.'+CRLF
      +CRLF
      +'Created by Alexander Iljin (Amadeus IT Solutions) using XDS Oberon, March 2008 - March 2010.'+CRLF
      +'Contact e-mail: AlexIljin@users.SourceForge.net';

TYPE
   Pair = RECORD
      (* pair name is displayed in the plugin menu *)
      name, left, right: POINTER TO ARRAY OF CHAR
   END;

VAR
   pairs: ARRAY MaxFuncs OF Pair;
   numPairs: INTEGER;

PROCEDURE ClearPairs ();
VAR
   i: INTEGER;
BEGIN
   i := 0;
   WHILE i < MaxFuncs DO
      pairs [i].name := NIL;
      pairs [i].left := NIL;
      pairs [i].right := NIL;
      INC (i);
   END;
END ClearPairs;

PROCEDURE LoadBitmap (VAR fname: ARRAY OF CHAR): Win.HBITMAP;
(* Load a bitmap image from the given file name and return the handle. *)
BEGIN
   RETURN SYSTEM.VAL (Win.HBITMAP,
      Win.LoadImage (
         NIL, SYSTEM.VAL (Win.PSTR, SYSTEM.ADR (fname)), Win.IMAGE_BITMAP, 0, 0,
         Win.LR_DEFAULTSIZE + Win.LR_LOADMAP3DCOLORS + Win.LR_LOADFROMFILE
      )
   )
END LoadBitmap;

PROCEDURE SurroundSelection (sc: Sci.Handle; VAR leftText, rightText: ARRAY OF CHAR);
VAR
   start, end, i: LONGINT;
   bool: BOOLEAN;
BEGIN
   Sci.BeginUndoAction (sc);
   Sci.GetSelectionExtent (sc, start, end, bool);
   Sci.InsertText (sc, end, rightText);
   Sci.InsertText (sc, start, leftText);
   i := Str.Length (leftText);
   INC (start, i);
   INC (end, i);
   Sci.SetSelectionExtent (sc, start, end, bool);
   Sci.EndUndoAction (sc)
END SurroundSelection;

PROCEDURE ApplyPair (VAR pair: Pair);
(* Surround currently selected text in the current Scintilla view with a pair of tags. *)
VAR sci: Sci.Handle;
BEGIN
   sci := Npp.GetCurrentScintilla ();
   SurroundSelection (sci, pair.left^, pair.right^)
END ApplyPair;

PROCEDURE ['C'] Func00 ();
BEGIN ApplyPair (pairs [00])
END Func00;

PROCEDURE ['C'] Func01 ();
BEGIN ApplyPair (pairs [01])
END Func01;

PROCEDURE ['C'] Func02 ();
BEGIN ApplyPair (pairs [02])
END Func02;

PROCEDURE ['C'] Func03 ();
BEGIN ApplyPair (pairs [03])
END Func03;

PROCEDURE ['C'] Func04 ();
BEGIN ApplyPair (pairs [04])
END Func04;

PROCEDURE ['C'] Func05 ();
BEGIN ApplyPair (pairs [05])
END Func05;

PROCEDURE ['C'] Func06 ();
BEGIN ApplyPair (pairs [06])
END Func06;

PROCEDURE ['C'] Func07 ();
BEGIN ApplyPair (pairs [07])
END Func07;

PROCEDURE ['C'] Func08 ();
BEGIN ApplyPair (pairs [08])
END Func08;

PROCEDURE ['C'] Func09 ();
BEGIN ApplyPair (pairs [09])
END Func09;

PROCEDURE ['C'] Func10 ();
BEGIN ApplyPair (pairs [10])
END Func10;

PROCEDURE ['C'] Func11 ();
BEGIN ApplyPair (pairs [11])
END Func11;

PROCEDURE ['C'] Func12 ();
BEGIN ApplyPair (pairs [12])
END Func12;

PROCEDURE ['C'] Func13 ();
BEGIN ApplyPair (pairs [13])
END Func13;

PROCEDURE ['C'] Func14 ();
BEGIN ApplyPair (pairs [14])
END Func14;

PROCEDURE ['C'] Func15 ();
BEGIN ApplyPair (pairs [15])
END Func15;

PROCEDURE ['C'] Func16 ();
BEGIN ApplyPair (pairs [16])
END Func16;

PROCEDURE ['C'] Func17 ();
BEGIN ApplyPair (pairs [17])
END Func17;

PROCEDURE ['C'] Func18 ();
BEGIN ApplyPair (pairs [18])
END Func18;

PROCEDURE ['C'] Func19 ();
BEGIN ApplyPair (pairs [19])
END Func19;

PROCEDURE ['C'] Func20 ();
BEGIN ApplyPair (pairs [20])
END Func20;

PROCEDURE ['C'] Func21 ();
BEGIN ApplyPair (pairs [21])
END Func21;

PROCEDURE ['C'] Func22 ();
BEGIN ApplyPair (pairs [22])
END Func22;

PROCEDURE ['C'] Func23 ();
BEGIN ApplyPair (pairs [23])
END Func23;

PROCEDURE ['C'] Func24 ();
BEGIN ApplyPair (pairs [24])
END Func24;

PROCEDURE ['C'] Func25 ();
BEGIN ApplyPair (pairs [25])
END Func25;

PROCEDURE ['C'] Func26 ();
BEGIN ApplyPair (pairs [26])
END Func26;

PROCEDURE ['C'] Func27 ();
BEGIN ApplyPair (pairs [27])
END Func27;

PROCEDURE ['C'] Func28 ();
BEGIN ApplyPair (pairs [28])
END Func28;

PROCEDURE ['C'] Func29 ();
BEGIN ApplyPair (pairs [29])
END Func29;

PROCEDURE ['C'] About ();
(* Show info about this plugin. *)
BEGIN
   Win.MessageBox (Npp.handle, AboutMsg, Settings.PluginName + ' ' + Ver.String, Win.MB_OK)
END About;

PROCEDURE ['C'] ReplaceTag ();
(* Replace current tag with a replacement text. *)
BEGIN
   Tags.Do (Npp.GetCurrentScintilla ());
END ReplaceTag;

PROCEDURE IsDigit (ch: CHAR): BOOLEAN;
BEGIN
   RETURN ('0' <= ch) & (ch <= '9')
END IsDigit;

PROCEDURE CharToDigit (ch: CHAR): SHORTINT;
BEGIN
   ASSERT (IsDigit (ch), 20);
   RETURN SHORT (ORD (ch) - ORD ('0'))
END CharToDigit;

PROCEDURE DigitToChar (digit: INTEGER): CHAR;
(* Return the last decimal digit  *)
BEGIN
   RETURN CHR ((digit MOD 10) + ORD ('0'))
END DigitToChar;

PROCEDURE ReadConfig (VAR numRead: INTEGER; initToolbar: BOOLEAN);
VAR
   fname: ARRAY Win.MAX_PATH OF CHAR;
   maxFnameLen: INTEGER;
   file: Ini.File;

   PROCEDURE LineToPair (VAR pair: Pair): BOOLEAN;
   (* Initialize pair with data from file.line, return TRUE on success. *)
   VAR eqPos, selPos, len: INTEGER;

      PROCEDURE UnescapeStr (VAR str: ARRAY OF CHAR);
      (* Process line replacing escaped characters with their literal equivalents.
       * Unescaped string is shorter or of equal length, null-terminated. *)
      VAR i, c: INTEGER;
      BEGIN
         i := 0;
         c := 0;
         WHILE str [i] # Str.Null DO
            IF str [i] = '\' THEN
               CASE str [i + 1] OF
               |  't': str [c] := 09X; INC (i)
               |  'n': str [c] := 0AX; INC (i)
               |  'r': str [c] := 0DX; INC (i)
               |  '\': str [c] := '\'; INC (i)
               ELSE str [c] := str [i]
               END
            ELSE
               str [c] := str [i]
            END;
            INC (i); INC (c)
         END;
         str [c] := Str.Null
      END UnescapeStr;

   BEGIN
      eqPos := 0;
      WHILE (file.line [eqPos] # Str.Null) & (file.line [eqPos] # '=') DO
         INC (eqPos)
      END;
      IF file.line [eqPos] = Str.Null THEN
         RETURN FALSE
      END;
      selPos := eqPos + 1;
      WHILE (file.line [selPos] # Str.Null) & (file.line [selPos] # '|') DO
         INC (selPos)
      END;
      IF file.line [selPos] = Str.Null THEN
         RETURN FALSE
      END;
      len := selPos + 1;
      WHILE file.line [len] # Str.Null DO
         INC (len)
      END;
      NEW (pair.name, eqPos + 1);
      NEW (pair.left, selPos - eqPos);
      NEW (pair.right, len - selPos);
      Str.CopyTo (file.line, pair.name^, 0, eqPos, 0);
      Str.CopyTo (file.line, pair.left^, eqPos + 1, selPos, 0);
      Str.CopyTo (file.line, pair.right^, selPos + 1, len, 0);
      UnescapeStr (pair.left^);
      UnescapeStr (pair.right^);
      RETURN TRUE
   END LineToPair;

   PROCEDURE LineToToolbar ();
   VAR i, num, len: INTEGER;
   BEGIN
      i := 0;
      len := SHORT (Str.Length (file.line));
      WHILE (i < len) & (file.line [i] # '=') DO
         INC (i)
      END;
      ASSERT ((0 < MaxFuncs) & (MaxFuncs < 100), 20);
      IF (i > 0) & (i <= 2) (* 2 digits maximum *)
         & IsDigit (file.line [0]) & ((i = 1) OR (IsDigit (file.line [1])))
      THEN
         num := CharToDigit (file.line [0]);
         IF i = 2 THEN
            num := num * 10 + CharToDigit (file.line [1])
         END;
         IF (0 < num) & (num <= numRead) THEN
            DEC (num); (* items are numbered from 1, in ini-file *)
            INC (i); (* skip '=' *)
            IF (i < len) & (len - i <= maxFnameLen) THEN
               COPY (Settings.configDir, fname);
               Str.CopyTo (file.line, fname, i, len, Settings.configDirLen);
               Npp.MenuItemToToolbar (num, LoadBitmap (fname), NIL)
            END
         END
      END
   END LineToToolbar;

   PROCEDURE LineToTag ();
   (* Create new tag with data from file.line. *)
   VAR
      eqPos, len: INTEGER;
      key: Tags.KeyStr;
      value: Str.Ptr;
   BEGIN
      eqPos := 0;
      WHILE (file.line [eqPos] # Str.Null) & ~(file.line [eqPos] = '=') DO
         INC (eqPos);
      END;
      IF (file.line [eqPos] # Str.Null) & (eqPos <= Tags.MaxKeyLen) THEN
         len := eqPos + 1;
         WHILE file.line [len] # Str.Null DO
            INC (len);
         END;
         IF len > eqPos + 1 THEN
            NEW (value, len - eqPos);
            Str.CopyTo (file.line, key, 0, eqPos, 0);
            Str.CopyTo (file.line, value^, eqPos + 1, len, 0);
            Tags.Add (key, value);
         END;
      END;
   END LineToTag;

BEGIN
   Tags.Clear;
   ClearPairs;
   oberonRTS.Collect;
   numRead := 0;
   maxFnameLen := LEN (Settings.configDir) - Settings.configDirLen - 1;
   Settings.GetIniFileName (fname);
   Ini.Open (file, fname);
   IF Ini.IsOpen (file) THEN
      WHILE Ini.ReadLine (file) DO
      END;
      WHILE file.section DO
         IF file.line = '[' + CommandsIniSection + ']' THEN
            (* read menu items *)
            WHILE (numRead < MaxFuncs) & Ini.ReadLine (file) DO
               IF LineToPair (pairs [numRead]) THEN
                  INC (numRead)
               END
            END;
            IF ~(numRead < MaxFuncs) THEN
               WHILE Ini.ReadLine (file) DO
               END
            END
         ELSIF initToolbar & (file.line = '[' + ToolbarIniSection + ']') THEN
            (* read toolbar items *)
            WHILE Ini.ReadLine (file) DO
               LineToToolbar ()
            END
         ELSIF file.line = '[' + TagsIniSection + ']' THEN
            (* read tags *)
            WHILE Ini.ReadLine (file) DO
               LineToTag ()
            END
         ELSE
            WHILE Ini.ReadLine (file) DO
            END
         END
      END;
      Ini.Close (file)
   END
END ReadConfig;

PROCEDURE GetCharPos (VAR str: ARRAY OF CHAR; ch: CHAR): INTEGER;
(* Return index of the first occurence of the ch character in str, -1 if none found. *)
VAR res: INTEGER;
BEGIN
   res := 0;
   WHILE (str [res] # Str.Null) & (str [res] # ch) DO
      INC (res)
   END;
   IF str [res] # ch THEN
      res := -1;
   END;
   RETURN res
END GetCharPos;

PROCEDURE MakeDummyFuncName (VAR str: ARRAY OF CHAR; pos, num: INTEGER);
(* Replace characters at pos and (pos+1) in str with num in decimal notation.
 * If pos < 0, do nothing. *)
BEGIN
   ASSERT ((0 <= num) & (num < 100), 20);
   IF pos >= 0 THEN
      str [pos] := DigitToChar (num DIV 10);
      str [pos + 1] := DigitToChar (num)
   END
END MakeDummyFuncName;

PROCEDURE UpdateMenuItems (forShortcutMapper: BOOLEAN);
VAR
   i, numPos: INTEGER;
   fname: ARRAY Npp.MenuItemNameLength OF CHAR;
BEGIN
   (* enable and update text for loaded menu items *)
   i := 0;
   WHILE i < numPairs DO
      IF forShortcutMapper THEN
         fname := Settings.PluginName;
         Str.AppendC (fname, ' - ')
      ELSE
         fname := ''
      END;
      Str.Append (fname, pairs [i].name^);
      Npp.SetMenuItemName (i, fname);
      Npp.EnableMenuItem (i, TRUE);
      INC (i)
   END;
   (* disable and reset text for the rest *)
   IF i < MaxFuncs THEN
      fname := NotUsedFuncStr;
      numPos := GetCharPos (fname, NumChar);
      REPEAT
         MakeDummyFuncName (fname, numPos, i + 1);
         Npp.SetMenuItemName (i, fname);
         Npp.EnableMenuItem (i, FALSE);
         INC (i)
      UNTIL i >= MaxFuncs
   END
END UpdateMenuItems;

PROCEDURE ['C'] EditConfig ();
(* Open ini-file for editing in Notepad++. *)
VAR fname: ARRAY Win.MAX_PATH OF Npp.Char;
BEGIN
   Settings.GetIniFileName (fname);
   IF ~Npp.OpenFile (fname) THEN
      -- just ignore the result
   END;
END EditConfig;

PROCEDURE ['C'] LoadConfig ();
BEGIN
   ReadConfig (numPairs, FALSE);
   UpdateMenuItems (FALSE)
END LoadConfig;

PROCEDURE OnReady ();
BEGIN
   UpdateMenuItems (FALSE)
END OnReady;

PROCEDURE OnSetInfo ();
BEGIN
   Settings.Init;
   ReadConfig (numPairs, TRUE);
   UpdateMenuItems (TRUE)
END OnSetInfo;

PROCEDURE Init ();
CONST
   AdditionalMenuItems = 5; (* Number of item added to MaxFuncs *)
   EnterKey = 0DX;
VAR
   i, numPos: INTEGER;
   funcs: ARRAY MaxFuncs OF Npp.Function;
   fname: ARRAY LEN (NotUsedFuncStr) OF CHAR;
   shortcut: Npp.Shortcut;
BEGIN
   IF MaxFuncs + AdditionalMenuItems > Npp.DefNumMenuItems THEN
      Npp.SetNumMenuItems (MaxFuncs + AdditionalMenuItems)
   END;
   funcs [00] := Func00;
   funcs [01] := Func01;
   funcs [02] := Func02;
   funcs [03] := Func03;
   funcs [04] := Func04;
   funcs [05] := Func05;
   funcs [06] := Func06;
   funcs [07] := Func07;
   funcs [08] := Func08;
   funcs [09] := Func09;
   funcs [10] := Func10;
   funcs [11] := Func11;
   funcs [12] := Func12;
   funcs [13] := Func13;
   funcs [14] := Func14;
   funcs [15] := Func15;
   funcs [16] := Func16;
   funcs [17] := Func17;
   funcs [18] := Func18;
   funcs [19] := Func19;
   funcs [20] := Func20;
   funcs [21] := Func21;
   funcs [22] := Func22;
   funcs [23] := Func23;
   funcs [24] := Func24;
   funcs [25] := Func25;
   funcs [26] := Func26;
   funcs [27] := Func27;
   funcs [28] := Func28;
   funcs [29] := Func29;
   Npp.PluginName := Settings.PluginName;
   Npp.onReady := OnReady;
   Npp.onSetInfo := OnSetInfo;
   fname := NotUsedFuncStr;
   numPos := GetCharPos (fname, NumChar);
   i := 0;
   WHILE i < MaxFuncs DO
      MakeDummyFuncName (fname, numPos, i + 1);
      Npp.AddMenuItem (fname, funcs [i], FALSE, NIL);
      INC (i)
   END;
   NEW (shortcut);
   shortcut.alt := TRUE;
   shortcut.key := EnterKey;
   Npp.AddMenuItem (ReplaceTagStr, ReplaceTag, FALSE, shortcut);
   Npp.AddMenuSeparator;
   Npp.AddMenuItem (EditConfigStr, EditConfig, FALSE, NIL);
   Npp.AddMenuItem (LoadConfigStr, LoadConfig, FALSE, NIL);
   Npp.AddMenuItem (AboutStr, About, FALSE, NIL)
END Init;

BEGIN Init
END WebEdit.
