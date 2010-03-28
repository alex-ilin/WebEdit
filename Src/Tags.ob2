MODULE Tags;

(* ---------------------------------------------------------------------------
 * (C) 2010 by Alexander Iljin
 * --------------------------------------------------------------------------- *)

IMPORT
   Sci:=Scintilla;

(* ---------------------------------------------------------------------------
 * This module deals with tag replacements. It was made as a substitute for
 * the very good, but unsupported QuickText plugin.
 * --------------------------------------------------------------------------- *)

TYPE
   Tag = POINTER TO TagDesc;
   TagDesc = RECORD
      key, value: POINTER TO ARRAY OF CHAR;
      next: Tag;
   END;

VAR
   root: Tag;

PROCEDURE Do* (sci: Sci.Handle);
(** Either replace the current tag or jump to the next hotspot. *)
BEGIN
END Do;

PROCEDURE Clear*;
(** Forget all tags. *)
BEGIN
   root := NIL;
END Clear;

BEGIN
   Clear;
END Tags.
