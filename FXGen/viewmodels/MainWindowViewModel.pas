namespace FXGen.ViewModels;

uses
  System.Linq,
  System.Collections.ObjectModel,
  MVVM,
  FXGen,
  FXGen.Utilities,
  FXGen.Messages;

type

  MainWindowViewModel = public class
  private
  protected
  public
    //data bindings
    property Platforms: ObservableCollection<String>; notify;
    property Platform: String; notify;
    property Achitectures: ObservableCollection<String>; notify;
    property Achitecture: String; notify;
    property LibraryName: String; notify;
    property HeaderFiles: String; notify;
    property OnlyImportExplicitHeaders: Boolean; notify;
    //commands
    property InvokeHeaderFilesHelperCommand := new RelayCommand(method; begin
      App.Navigator.ShowOpenFileDialog('*.h');
    end); readonly;

    constructor;
    begin
      var hi := new HeaderImporter;
      //fill Platform List
      Platforms := new ObservableCollection<String>(['BareMetal-ARM']);
      //fill achitectures List
      Achitectures := new ObservableCollection<String>(['any', 'i386', 'x86_64',
                                                        'armv6', 'armv7', 'armv7s', 'armv8', 'arm64', 'armv7k',
                                                        'asmjs', 'mipsel', 'mips64el', 'armv5', 'Gotham', 'Discord']);
    end;
  end;

end.
