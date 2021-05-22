using System.Runtime.InteropServices;

namespace WebEdit.IniFiles {
  class IniFile {

    [DllImport("kernel32.dll", EntryPoint = "GetPrivateProfileString")]
    public static extern int GetPrivateProfileString(
      string lpAppName, string lpKeyName, string lpDefault,
      byte[] lpReturnedString, int nSize, string lpFileName);

  }
}
