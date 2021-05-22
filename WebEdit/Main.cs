using Kbg.NppPluginNET.PluginInfrastructure;
using System;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Runtime.InteropServices;
using System.Text;
using System.Text.RegularExpressions;
using System.Windows.Forms;
using WebEdit;
using WebEdit.PluginInfraestructureCustom;

namespace Kbg.NppPluginNET
{
    class Main
    {
        internal const string PluginName = "WebEdit";
        static string iniDirectory, iniFilePath, nppPath = null;

        public static void OnNotification(ScNotification notification)
        {
        }

        /// <summary>
        /// Load Menu section
        /// </summary>
        internal static void CommandMenuInit()
        {
            int i = 0;

            StringBuilder npath = new StringBuilder(Win32.MAX_PATH);
            Win32.SendMessage(PluginBase.nppData._nppHandle, (uint)NppMsg.NPPM_GETNPPDIRECTORY, 0, npath);
            nppPath=npath.ToString();

            StringBuilder sbIniFilePath = new StringBuilder(Win32.MAX_PATH);
            Win32.SendMessage(PluginBase.nppData._nppHandle, (uint)NppMsg.NPPM_GETPLUGINSCONFIGDIR, Win32.MAX_PATH, sbIniFilePath);
            iniDirectory = sbIniFilePath.ToString();
            if (!Directory.Exists(iniDirectory)) Directory.CreateDirectory(iniDirectory);
            iniFilePath = Path.Combine(iniDirectory, PluginName + ".ini");

            if (!File.Exists(iniFilePath))
            {
                LoadConfig();
            }
            byte[] buffer = new byte[1048];
            Win32Custom.GetPrivateProfileString("Commands", null, "", buffer, 1048, iniFilePath);
            String[] keys = Encoding.ASCII.GetString(buffer).Trim('\0').Split('\0');

            var actions = new Actions(keys, iniFilePath);
            foreach (String key in keys)
            {
                var methodInfo = typeof(Actions).GetMethod("ExecuteCommand" + i);
                PluginBase.SetCommand(i++, key.Replace("&", ""), (NppFuncItemDelegate)Delegate.CreateDelegate(typeof(NppFuncItemDelegate), actions, methodInfo.Name), new ShortcutKey(false, false, false, Keys.None));
            }
            PluginBase.SetCommand(i++, "Replace Tag", ChangeModule, new ShortcutKey(false, true, false, Keys.Enter));

            PluginBase.SetCommand(i++, "Edit Config", EditConfig, new ShortcutKey(false, false, false, Keys.None));
            PluginBase.SetCommand(i++, "Load Config", LoadConfig, new ShortcutKey(false, false, false, Keys.None));
            PluginBase.SetCommand(i++, "About..", About, new ShortcutKey(false, false, false, Keys.None));
        }

        /// <summary>
        /// Edit config file in notepad ++
        /// </summary>
        internal static void EditConfig()
        {
            if (!String.IsNullOrEmpty(iniFilePath))
            {
                System.Diagnostics.Process process = new System.Diagnostics.Process();
                System.Diagnostics.ProcessStartInfo startInfo = new System.Diagnostics.ProcessStartInfo();
                startInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Hidden;
                startInfo.FileName = "cmd.exe";
                //MessageBox.Show("/C \"\"" + nppPath + "\\notepad++.exe\"" + " \"" + iniFilePath + "\"\"");
                startInfo.Arguments = "/C \"\"" + nppPath + "\\notepad++.exe\"" + " \"" + iniFilePath + "\"\"";
                process.StartInfo = startInfo;
                process.Start();
            }

        }

        /// <summary>
        /// Load Config File to setting
        /// </summary>
        unsafe internal static void LoadConfig()
        {
            if (!File.Exists(iniFilePath))
            {
                using (FileStream fs = File.Create(iniFilePath))
                {
                    byte[] info = new UTF8Encoding(true).GetBytes(@"[Commands]
; Syntax: <Item name>=<Left text>|<Right text>
; Known escape sequences: \\ \t \n \r
&A=<a href=""#"">|</a>
Div&Class =<div class="""">|</div>
Div&Id=<div id="""">|</div>
&Em=<em>|</em>
H&1=<h1>|</h1>
H&2=<h2>|</h2>
H&3=<h3>|</h3>
H&4=<h4>|</h4>
H&5=<h5>|</h5>
H&6=<h6>|</h6>
&Li=<li>|</li>
&Ol=<ol>|</ol>
&P=<p>|</p>
Spa&n=<span>|</span>
&Strong=<strong>|</strong>
St&yle=<style>|</style>
&Table=<table>|</table>
T&d=<td>|</td>
T&r=<tr>|</tr>
&Ul=<ul>|</ul>

; Free accelerators: bfghjkmqvwxz0789

[Toolbar]
; Syntax: <slot number>=<fileName>.bmp
; The bitmap files should be placed in to the plugins\Config folder.
; Example:
1=a.bmp
2=dc.bmp
3=di.bmp
4=em.bmp
5=h1.bmp
6=h2.bmp
7=h3.bmp
8=h4.bmp
9=h5.bmp
10=h6.bmp
11=li.bmp
12=ol.bmp
13=p.bmp
14=sp.bmp
15=s.bmp
16=st.bmp
17=t.bmp
18=td.bmp
19=tr.bmp
20=ul.bmp

[Tags]
; Tags are replaced with their Replacement when you select the
; WebEdit\Replace Tag menu item (Alt+Enter by default).
; Syntax: <Tag>=<Replacement>
; Tags can contain characters a-z, A-Z, 0-9. Maximum length of a tag is 32
; characters. The number of Tags is not limited. The pipe character | marks
; the caret position after the tag replacement.
; Known escape sequences:
; \c = system clipboard contents
; \i = indentation
; \n = new line
; \t = tab character
; \| = |
; \\ = \
m=MODULE \c;\n\n(* ------------------------------------------------------------------------\n * (C) 2010 by Alexander Iljin\n * ------------------------------------------------------------------------ *)\n\nIMPORT\n\i|;\n\n(** ------------------------------------------------------------------------\n  * TODO: Add module description\n  * ----------------------------------------------------------------------- *)\n\nEND \c.\n
rep=REPEAT\n\i\nUNTIL |;
a=ASSERT (|);
c=CASE | OF\n\|\i:\nEND;
d=DEC (|);\n
di=DEC (i);\n|
if=IF | THEN\n\i\nEND;
ife=IF | THEN\n\i\nELSE\n\i\nEND;
i=INC (|);\n
ii=INC (i);\n|
rec=RECORD\n\i|\nEND;
whi=i := 0;\nWHILE i < c DO\n\i|\n\iINC (i);\nEND;
r=RETURN res
w=WHILE | DO\n\i\n\iINC (i);\nEND;
p=PROCEDURE \c|;\nBEGIN\n\i\nEND \c;\n");
                    // Add some information to the file.
                    fs.Write(info, 0, info.Length);
                }
                System.Diagnostics.Process process = new System.Diagnostics.Process();
                System.Diagnostics.ProcessStartInfo startInfo = new System.Diagnostics.ProcessStartInfo();
                startInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Hidden;
                startInfo.FileName = "cmd.exe";
                startInfo.Arguments = "/C taskkill /pid notepad++.exe";
                process.StartInfo = startInfo;
                process.Start();
            }
        }

        /// <summary>
        /// Show internal information.
        /// </summary>
        internal static void About()
        {
            MessageBox.Show(@"This small freeware plugin allows you to wrap the selected text in tag pairs and expand abbreviations using a hotkey.
for more information refer to WebEdit.txt

Created by Alexander lljin(Amadeus IT Solutions), March 2008 - March 2021.
Contact e-mail: Alexlljin @user.SourceForge.net", "WebEdit 2.7");
        }

        /// <summary>
        /// Set toolbar icons.
        /// </summary>
        internal static void SetToolBarIcon()
        {
            if (File.Exists(iniFilePath))
            {
                toolbarIcons tbIcons = new toolbarIcons();
                byte[] buffer = new byte[1048];
                Win32Custom.GetPrivateProfileString("Toolbar", null, "", buffer, 1048, iniFilePath);
                String[] keys = Encoding.ASCII.GetString(buffer).Trim('\0').Split('\0');
                foreach (String key in keys)
                {
                    byte[] text = new byte[255];
                    Win32Custom.GetPrivateProfileString("Toolbar", key, "", text, 255, iniFilePath);
                    String value = Encoding.ASCII.GetString(text);
                    var pathIcon = Path.Combine(iniDirectory, PluginName, value.Trim('\0').Replace("\0", ""));
                    if (File.Exists(pathIcon))
                    {
                        try
                        {
                            Bitmap icon = new Bitmap(pathIcon);
                            tbIcons.hToolbarBmp = icon.GetHbitmap();
                            IntPtr pTbIcons = Marshal.AllocHGlobal(Marshal.SizeOf(tbIcons));
                            Marshal.StructureToPtr(tbIcons, pTbIcons, false);
                            Win32.SendMessage(PluginBase.nppData._nppHandle, (uint) NppMsg.NPPM_ADDTOOLBARICON,
                                PluginBase._funcItems.Items[Convert.ToInt32(key) - 1]._cmdID, pTbIcons);
                            Marshal.FreeHGlobal(pTbIcons);
                        }
                        catch
                        {

                        }
                    }
                }
            }
        }

    internal static void PluginCleanUp()
    {
      // This method is called when the plugin is notified about Npp shutdown.
    }

        ///// <summary>
        ///// Change text for module
        ///// </summary>
        internal static void ChangeModule()
        {
            IntPtr currentScint = PluginBase.GetCurrentScintilla();
            ScintillaGateway scintillaGateway = new ScintillaGateway(currentScint);
            int position = scintillaGateway.GetSelectionEnd();

            string selectedText = scintillaGateway.GetSelText();
            if (string.IsNullOrEmpty(selectedText))
            {
                scintillaGateway.SetSelection(position > 10 ? (position - 10) : (position - position), position);
                selectedText = scintillaGateway.GetSelText();
                var reges = Regex.Matches(scintillaGateway.GetSelText(), @"(\w+)");
                if(reges.Count > 0)
                {
                    selectedText = reges.Cast<Match>().Select(m => m.Value).LastOrDefault();
                    scintillaGateway.SetSelection(position - selectedText.Length, position);
                    selectedText = scintillaGateway.GetSelText();
                }
            }
            try
            {
                if (string.IsNullOrEmpty(selectedText))
                {
                    throw new Exception("No tag here.");
                }
                byte[] buffer = new byte[1048];

                Win32Custom.GetPrivateProfileString("Tags", selectedText, "", buffer, 1048, iniFilePath);
                String value = Encoding.ASCII.GetString(buffer);
                if (string.IsNullOrEmpty(value.Trim('\0')))
                {
                    throw new Exception("No tag here.");
                }
                value = TransformTags(value);
                scintillaGateway.ReplaceSel(value.Replace("|", null));
                scintillaGateway.SetSelectionEnd(position + value.Substring(0, value.IndexOf('|')).Length - selectedText.Length);
            }catch(Exception ex){
                scintillaGateway.CallTipShow(position, ex.Message);
            }
        }

        /// <summary>
        /// Transform string to uncode
        /// </summary>
        /// <param name="value"></param>
        /// <returns></returns>
        private static string TransformTags(String value)
        {
            if (value.Contains("\\n"))
            {
                value = value.Replace("\\n", "\n");
            }
            if(value.Contains("\\c"))
            {
                value = value.Replace("\\c", "ScintillaGateway scintillaGateway = new ScintillaGateway(currentScint)");
            }
            if (value.Contains("\\i"))
            {
                value = value.Replace("\\i", "  ");
            }
            return value;
        }

    }
}
