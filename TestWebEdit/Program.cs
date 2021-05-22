using System;
using System.Collections.Generic;
using System.Runtime.InteropServices;
using System.Text;

namespace TestWebEdit
{
    class Program
    {

        [DllImport("kernel32.dll", EntryPoint = "GetPrivateProfileString")]
        public static extern int GetPrivateProfileString(string lpAppName, string lpKeyName, string lpDefault, byte[] lpReturnedString, int nSize, string lpFileName);

        public static void Main()
        {

            string section = "Commands";
            string filename = @"D:\Proyectos\Freelancer\Miguel\WebEdit\webedit\WebEdit\TestWebEdit\WebEdit.ini";

            byte[] buffer = new byte[1048];
            GetPrivateProfileString(section, null, "", buffer, 1048, filename);

            String[] tmp = Encoding.ASCII.GetString(buffer).Trim('\0').Split('\0');

            List<string> result = new List<string>();

            foreach (String entry in tmp)
            {
                byte[] text = new byte[255];
                int resText = GetPrivateProfileString(section, entry, "", buffer, 255, filename);

                String tmpText = Encoding.ASCII.GetString(buffer);
            }
        }

    }
}
