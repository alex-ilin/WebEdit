MODULE Tags;

(* ---------------------------------------------------------------------------
 * (C) 2010 by Alexander Iljin
 * --------------------------------------------------------------------------- *)

IMPORT
   Sci:=Scintilla, Str;

(* ---------------------------------------------------------------------------
 * This module deals with tag replacements. It was made as a substitute for
 * the very good, but unsupported QuickText plugin.
 * --------------------------------------------------------------------------- *)

CONST
   MaxKeyLen*     = 32; (* When changing, update the MaxKeyMsg message. *)
   MaxKeyMsg      = 'Maximum tag length is 32 characters.';
   KeyNotFoundMsg = 'Undefined tag: ';
   NoKeyMsg       = 'No tag here.';
   NoTagsMsg      = 'No tags defined.';

TYPE
   KeyStr* = ARRAY MaxKeyLen + 1 OF CHAR;
   Tag = POINTER TO TagDesc;
   TagDesc = RECORD
      key: KeyStr;
      value: Str.Ptr;
      next: Tag;
   END;

VAR
   root: Tag;

PROCEDURE ValidKeyChar (char: CHAR): BOOLEAN;
(* Return TRUE if 'char' is valid in a tag key. *)
BEGIN
   CASE char OF
   | 'a'..'z', 'A'..'Z', '0'..'9':
      RETURN TRUE
   ELSE
      RETURN FALSE
   END;
END ValidKeyChar;

PROCEDURE ValidKey (VAR key: KeyStr): BOOLEAN;
(* Return TRUE if 'key' consists of valid tag keys only. *)
VAR
   i: LONGINT;
BEGIN
   i := 0;
   WHILE (i <= MaxKeyLen) & (key [i] # Str.Null) & ValidKeyChar (key [i]) DO
      INC (i);
   END;
   RETURN (i <= MaxKeyLen) & (key [i] = Str.Null)
END ValidKey;

PROCEDURE Find (VAR key: KeyStr): Tag;
(* Find Tag with the given key, return NIL if not found. *)
VAR
   res: Tag;
BEGIN
   res := root;
   WHILE (res # NIL) & (res.key # key) DO
      res := res.next;
   END;
   RETURN res
END Find;

PROCEDURE Do* (sci: Sci.Handle);
(** Either replace the current tag or jump to the next hotspot. *)
VAR
   pos: LONGINT;
   key: KeyStr;
   tag: Tag;
   msg: ARRAY LEN (KeyNotFoundMsg) + MaxKeyLen OF CHAR; (* Error message *)
   posLeft, posRight: LONGINT;

   PROCEDURE ShowMsg (msg: ARRAY OF CHAR);
   BEGIN
      Sci.CallTipShow (sci, pos, msg);
   END ShowMsg;

   PROCEDURE GetKey (): BOOLEAN;
   (* Copy key from sci [pos]. On error show message and return false. *)
   VAR
      stop: LONGINT;
      res: BOOLEAN;
   BEGIN
      posLeft := pos;
      stop := pos - MaxKeyLen - 1;
      IF stop < 0 THEN
         stop := 0;
      END;
      WHILE (posLeft > stop) & ValidKeyChar (Sci.GetCharAt (sci, posLeft - 1)) DO
         DEC (posLeft);
      END;
      posRight := pos;
      stop := Sci.GetTextLength (sci);
      IF stop > pos + MaxKeyLen + 1 THEN
         stop := pos + MaxKeyLen + 1;
      END;
      WHILE (posRight < stop) & ValidKeyChar (Sci.GetCharAt (sci, posRight)) DO
         INC (posRight);
      END;
      res := FALSE;
      IF posRight - posLeft <= 0 THEN
         ShowMsg (NoKeyMsg);
      ELSIF posRight - posLeft <= MaxKeyLen THEN
         stop := Sci.GetTextRange (sci, posLeft, posRight, key);
         res := stop = posRight - posLeft;
         IF res THEN
            key [stop] := Str.Null;
         END;
      ELSE
         ShowMsg (MaxKeyMsg);
      END;
      RETURN res
   END GetKey;

   PROCEDURE PasteValue (pastePos: LONGINT; VAR value: ARRAY OF CHAR);
   CONST
      MaxIndent = 80;
      TabChar = 09X;
   VAR
      linePos: LONGINT; (* Line start position. *)
      indent: ARRAY MaxIndent + 1 OF CHAR; (* Indentation at line start. *)
      indentLen: LONGINT; (* Really required length. Can be > MaxIndent. *)
      i, c: LONGINT;
      pos: LONGINT; (* Current text insertion position. *)
      caretPos: LONGINT; (* Caret position after the operation. *)

      PROCEDURE PasteChar (VAR to: LONGINT; char: CHAR);
      VAR
         str: ARRAY 2 OF CHAR;
      BEGIN
         str [0] := char;
         str [1] := Str.Null;
         Sci.InsertText (sci, to, str);
         INC (to);
      END PasteChar;

      PROCEDURE PasteIndent (VAR to: LONGINT);
      (* Paste indentation characters. 'to' is increased by the pasted amount. *)
      VAR from, endPos: LONGINT;
      BEGIN
         IF indentLen < MaxIndent THEN
            Sci.InsertText (sci, to, indent);
            INC (to, indentLen);
         ELSE (* pump sci [linePos..pastePos] to 'to' using 'indent' as buffer *)
            endPos := to + indentLen;
            from := linePos;
            WHILE ~(pastePos - from < LEN (indent) - 1) DO
               indent [Sci.GetTextRange (sci, from, from + MaxIndent, indent)] := Str.Null;
               Sci.InsertText (sci, to, indent);
               INC (from, MaxIndent);
               INC (to, MaxIndent);
            END;
            indent [Sci.GetTextRange (sci, from, pastePos, indent)] := Str.Null;
            Sci.InsertText (sci, to, indent);
            INC (to, pastePos - from);
            ASSERT (to = endPos, 60);
         END;
      END PasteIndent;

   BEGIN (* PasteValue *)
      caretPos := -1;
      linePos := Sci.PositionFromLine (sci, Sci.LineFromPosition (sci, pastePos));
      indentLen := pastePos - linePos;
      IF indentLen < MaxIndent THEN (* init indent once and for all *)
         indent [Sci.GetTextRange (sci, linePos, pastePos, indent)] := Str.Null;
      END;
      i := 0;
      c := 0; (* value [c] is the next character to be pasted to 'sci' *)
      pos := pastePos;
      WHILE value [i] # Str.Null DO
         IF value [i] = '\' THEN (* paste value [c..i - 1] to 'sci' *)
            Sci.InsertBuff (sci, pos, value, c, i);
            INC (pos, i - c);
            INC (i);
            (* handle escaped characters *)
            IF value [i] = 'n' THEN         (* eol *)
               INC (pos, Sci.InsertEol (sci, pos));
               PasteIndent (pos);
            ELSIF value [i] = '\' THEN      (* backslash *)
               PasteChar (pos, '\');
            ELSIF value [i] = 't' THEN      (* tab *)
               PasteChar (pos, TabChar);
            ELSIF value [i] = '|' THEN      (* pipe *)
               PasteChar (pos, '|');
            ELSIF value [i] = Str.Null THEN (* null? yes, it can happen *)
               DEC (i); (* step back to terminate the outer loop *)
            END;
            c := i + 1;
         ELSIF value [i] = '|' THEN
            Sci.InsertBuff (sci, pos, value, c, i);
            INC (pos, i - c);
            caretPos := pos;
            c := i + 1;
         END;
         INC (i);
      END;
      Sci.InsertBuff (sci, pos, value, c, i); (* c = i is no problem *)
      INC (pos, i - c);
      IF caretPos = -1 THEN
         caretPos := pos;
      END;
      Sci.GotoPos (sci, caretPos);
   END PasteValue;

BEGIN (* Do *)
   pos := Sci.GetCurrentPos (sci);
   IF root = NIL THEN
      ShowMsg (NoTagsMsg);
   ELSIF GetKey () THEN
      tag := Find (key);
      IF tag # NIL THEN
         Sci.BeginUndoAction (sci);
         msg := ''; (* msg is just a temp variable here *)
         Sci.SetSel (sci, posLeft, posRight);
         Sci.ReplaceSel (sci, msg);
         PasteValue (posLeft, tag.value^);
         Sci.EndUndoAction (sci);
      ELSE
         msg := KeyNotFoundMsg;
         Str.Append (msg, key);
         ShowMsg (msg);
      END;
   END;
END Do;

PROCEDURE Clear*;
(** Forget all tags. *)
BEGIN
   root := NIL;
END Clear;

PROCEDURE Add* (VAR key: KeyStr; value: Str.Ptr);
(** Add key-value pair to the global tag list. *)
VAR
   tag: Tag;
BEGIN
   ASSERT (value # NIL, 21);
   IF ValidKey (key) THEN (* otherwise it won't be recognized in text *)
      NEW (tag);
      tag.key := key;
      tag.value := value;
      tag.next := root;
      root := tag;
   END;
END Add;

BEGIN
   Clear;
END Tags.
