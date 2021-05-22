using Kbg.NppPluginNET.PluginInfrastructure;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.InteropServices;
using System.Text;

namespace WebEdit.PluginInfraestructureCustom
{
    class Win32Custom : Win32
    {

        [DllImport("kernel32.dll", EntryPoint = "GetPrivateProfileString")]
        public static extern int GetPrivateProfileString(string lpAppName, string lpKeyName, string lpDefault, byte[] lpReturnedString, int nSize, string lpFileName);

    }
}
