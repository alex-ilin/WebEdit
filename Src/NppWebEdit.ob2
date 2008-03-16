<*+main*> (* This marks the main module of a program or library.               *)
<*heaplimit="10000"*> (* Maximum heap size should be set in the main module,
because the changes do not take effect until the main module is recompiled.    *)

MODULE NppWebEdit;

(* ---------------------------------------------------------------------------
 * (C) 2008 by Alexander Iljin
 * --------------------------------------------------------------------------- *)

IMPORT
   SYSTEM,Win:=Windows,Sci:=Scintilla,Npp:=NotepadPP;

(* ---------------------------------------------------------------------------
 * This is a simple Notepad++ plugin (XDS Oberon module). It can surround a
 * stretch of selected text with a pair of strings, e.g. HTML tags.
 *
 * HOW TO add a new function:
 *   make a copy of the MakePBlock procedure, rename it and edit its contents;
 *   add a new call to Npp.AddFunction to the Init procedure.
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
 * --------------------------------------------------------------------------- *)

CONST
   PluginName = 'NppWebEdit';

   (* Menu items *)
   MakePBlockStr = '<p>...</p>';
   AboutStr = 'About...';

   CRLF = ''+0DX+0AX;
   AboutMsg = 'This small freeware plugin allows you to wrap the selected text in tag pairs.'+CRLF
      +'Assign shortcuts via Settings - Shortcut Mapper - Plugin commands.'+CRLF
      +CRLF
      +'Created by Alexander Iljin (Amadeus IT Solutions) using XDS Oberon, 06-08 Mar 2008.';

PROCEDURE SurroundSelection (sc: Sci.Handle; leftText, rightText: ARRAY OF CHAR);
VAR
   start, end, i: LONGINT;
   bool: BOOLEAN;
BEGIN
   Sci.BeginUndoAction (sc);
   Sci.GetSelectionExtent (sc, start, end, bool);
   Sci.InsertText (sc, end, rightText);
   Sci.InsertText (sc, start, leftText);
   i := LEN (leftText) - 1;
   INC (start, i);
   INC (end, i);
   Sci.SetSelectionExtent (sc, start, end, bool);
   Sci.EndUndoAction (sc)
END SurroundSelection;

PROCEDURE ['C'] MakePBlock ();
(* Surround currently selected text in the current Scintilla view with a pair
 * of <p>...</p> tags. *)
VAR sci: Win.HWND;
BEGIN
   sci := Npp.GetCurrentScintilla ();
   SurroundSelection (sci, '<p>', '</p>')
END MakePBlock;

PROCEDURE ['C'] About ();
(* Show info about this plugin. *)
BEGIN
   Win.MessageBox (Npp.handle, AboutMsg, PluginName, Win.MB_OK)
END About;

PROCEDURE Init ();
(* Initialize the list of exported functions. *)
BEGIN
   Npp.PluginName := PluginName;
   Npp.AddFunction (MakePBlockStr, MakePBlock, 0, FALSE, NIL);
   Npp.AddFunction (AboutStr, About, 0, FALSE, NIL)
END Init;

BEGIN Init
END NppWebEdit.
