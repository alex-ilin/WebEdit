using Kbg.NppPluginNET.PluginInfrastructure;
using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Text;
using WebEdit.PluginInfraestructureCustom;

namespace WebEdit
{
    public class Actions
    {
        private StackTrace _stackTrace;
        private IDictionary<int, String> _commands;

        public Actions(String[] keys, String iniFilePath)
        {
            this._stackTrace = new StackTrace();
            this._commands = new Dictionary<int, String>();
            int i = 0;
            foreach(var key in keys)
            {
                byte[] text = new byte[255];
                Win32Custom.GetPrivateProfileString("Commands", key, "", text, 255, iniFilePath);
                String value = Encoding.ASCII.GetString(text);
                _commands.Add(i++, value);
            }
        }

        private void ExecuteCommand(String command)
        {
            IntPtr currentScint = PluginBase.GetCurrentScintilla();
            ScintillaGateway scintillaGateway = new ScintillaGateway(currentScint);
            string selectedText = scintillaGateway.GetSelText();
            int positionStar = scintillaGateway.GetSelectionStart();
            int positionEnd = scintillaGateway.GetSelectionEnd();
            String newText = command.Replace("|", selectedText);
            scintillaGateway.ReplaceSel(newText);
            scintillaGateway.SetSelection(positionStar + command.Substring(0, command.IndexOf('|')).Length, positionEnd + command.Substring(0, command.IndexOf('|')).Length);
            //scintillaGateway.SetSelectionEnd(position + command.Substring(0, command.IndexOf('|')).Length);
        }

        public void ExecuteCommand0() => this.ExecuteCommand(_commands[0]);
        public void ExecuteCommand1() => this.ExecuteCommand(_commands[1]);
        public void ExecuteCommand2() => this.ExecuteCommand(_commands[2]);
        public void ExecuteCommand3() => this.ExecuteCommand(_commands[3]);
        public void ExecuteCommand4() => this.ExecuteCommand(_commands[4]);
        public void ExecuteCommand5() => this.ExecuteCommand(_commands[5]);
        public void ExecuteCommand6() => this.ExecuteCommand(_commands[6]);
        public void ExecuteCommand7() => this.ExecuteCommand(_commands[7]);
        public void ExecuteCommand8() => this.ExecuteCommand(_commands[8]);
        public void ExecuteCommand9() => this.ExecuteCommand(_commands[9]);
        public void ExecuteCommand10() => this.ExecuteCommand(_commands[10]);
        public void ExecuteCommand11() => this.ExecuteCommand(_commands[11]);
        public void ExecuteCommand12() => this.ExecuteCommand(_commands[12]);
        public void ExecuteCommand13() => this.ExecuteCommand(_commands[13]);
        public void ExecuteCommand14() => this.ExecuteCommand(_commands[14]);
        public void ExecuteCommand15() => this.ExecuteCommand(_commands[15]);
        public void ExecuteCommand16() => this.ExecuteCommand(_commands[16]);
        public void ExecuteCommand17() => this.ExecuteCommand(_commands[17]);
        public void ExecuteCommand18() => this.ExecuteCommand(_commands[18]);
        public void ExecuteCommand19() => this.ExecuteCommand(_commands[19]);
        public void ExecuteCommand20() => this.ExecuteCommand(_commands[20]);
        public void ExecuteCommand21() => this.ExecuteCommand(_commands[21]);
        public void ExecuteCommand22() => this.ExecuteCommand(_commands[22]);
        public void ExecuteCommand23() => this.ExecuteCommand(_commands[23]);
        public void ExecuteCommand24() => this.ExecuteCommand(_commands[24]);
        public void ExecuteCommand25() => this.ExecuteCommand(_commands[25]);
        public void ExecuteCommand26() => this.ExecuteCommand(_commands[26]);
        public void ExecuteCommand27() => this.ExecuteCommand(_commands[27]);
        public void ExecuteCommand28() => this.ExecuteCommand(_commands[28]);
        public void ExecuteCommand29() => this.ExecuteCommand(_commands[29]);
        public void ExecuteCommand30() => this.ExecuteCommand(_commands[30]);
        public void ExecuteCommand31() => this.ExecuteCommand(_commands[31]);
        public void ExecuteCommand32() => this.ExecuteCommand(_commands[32]);
        public void ExecuteCommand33() => this.ExecuteCommand(_commands[33]);
        public void ExecuteCommand34() => this.ExecuteCommand(_commands[34]);
        public void ExecuteCommand35() => this.ExecuteCommand(_commands[35]);
        public void ExecuteCommand36() => this.ExecuteCommand(_commands[36]);
        public void ExecuteCommand37() => this.ExecuteCommand(_commands[37]);
        public void ExecuteCommand38() => this.ExecuteCommand(_commands[38]);
        public void ExecuteCommand39() => this.ExecuteCommand(_commands[39]);
        public void ExecuteCommand40() => this.ExecuteCommand(_commands[40]);
        public void ExecuteCommand41() => this.ExecuteCommand(_commands[41]);
        public void ExecuteCommand42() => this.ExecuteCommand(_commands[42]);
        public void ExecuteCommand43() => this.ExecuteCommand(_commands[43]);
        public void ExecuteCommand44() => this.ExecuteCommand(_commands[44]);
        public void ExecuteCommand45() => this.ExecuteCommand(_commands[45]);
        public void ExecuteCommand46() => this.ExecuteCommand(_commands[46]);
        public void ExecuteCommand47() => this.ExecuteCommand(_commands[47]);
        public void ExecuteCommand48() => this.ExecuteCommand(_commands[48]);
        public void ExecuteCommand49() => this.ExecuteCommand(_commands[49]);
        public void ExecuteCommand50() => this.ExecuteCommand(_commands[50]);

    }
}
