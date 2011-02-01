MODULE Settings;

(* ---------------------------------------------------------------------------
 * (C) 2008 - 2011 by Alexander Iljin
 * --------------------------------------------------------------------------- *)

IMPORT
   Npp:=NotepadPP, Str, Win:=Windows;

CONST
   PluginName* = 'WebEdit';
   IniFileName* = PluginName + '.ini';

VAR
   configDir-: ARRAY Win.MAX_PATH OF CHAR;
   configDirLen-: INTEGER;

PROCEDURE GetIniFileName* (VAR res: ARRAY OF CHAR);
BEGIN
   COPY (configDir, res);
   Str.AppendC (res, IniFileName);
END GetIniFileName;

PROCEDURE Init;
BEGIN
   Npp.GetPluginConfigDir (configDir);
   Str.AppendC (configDir, '\');
   configDirLen := SHORT (Str.Length (configDir));
END Init;

BEGIN
   Init;
END Settings.
