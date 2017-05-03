namespace FXGen;

uses
  System.IO,
  Microsoft.Win32;

type

  HeaderImporter = public class
  private
  protected
  public
    property AppFolder: String;
    property ExeName: String;
    constructor;
    begin
      AppFolder := String(Registry.GetValue('HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\RemObjects\Elements', 'InstallDir', nil));
      if not String.IsNullOrEmpty(AppFolder) then AppFolder := AppFolder + Path.DirectorySeparatorChar + 'Bin';
      if Directory.Exists(AppFolder) then ExeName := AppFolder + Path.DirectorySeparatorChar + 'HeaderImporter.exe';
    end;
  end;

end.
