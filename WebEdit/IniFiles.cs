using System.Runtime.InteropServices;
using System.Text;

namespace WebEdit.IniFiles {
  class IniFile {

    private const int maxValueLength = 256;
    private const int maxKeysBuffer = 1024;

    [DllImport("kernel32.dll", EntryPoint = "GetPrivateProfileString")]
    public static extern int GetPrivateProfileString(
      string lpAppName, string lpKeyName, string lpDefault,
      byte[] lpReturnedString, int nSize, string lpFileName);

    private readonly string _FileName;

    public IniFile(string fileName) => _FileName = fileName;

    /// <summary>
    /// Return a UTF8 string value of the given section's key.
    /// </summary>
    /// <param name="section">The [section] name that contains the key in the ini-file.</param>
    /// <param name="key">The key name in the ini-file, whose value is to be retrieved.</param>
    /// <param name="maxLength">The buffer allocated for the value data.</param>
    /// <returns>A UTF8 string value of the given section's key.</returns>
    public string Get(string section, string key, int maxLength = maxValueLength)
    {
      byte[] res = new byte[maxLength];
      _ = GetPrivateProfileString(section, key, "", res, res.Length, _FileName);
      return Encoding.UTF8.GetString(res);
    }

    public string[] GetKeys(string section, int maxBuffer = maxKeysBuffer)
      => Get(section, null, maxBuffer).Trim('\0').Split('\0');
  }
}
