namespace FXGen.DataAccess;

uses
   System.Collections.ObjectModel,
   System.IO,
   Newtonsoft.Json;

type

  IDataAccess = public interface
    //data bindings
    property Platforms: ObservableCollection<String> read write;    
    property TargetStrings: ObservableCollection<String> read write;  
    property ImporterJsonData: HeaderImporterJSONData read write;
    //methods
    method RequestOpenFileName(): String;
    method LoadFromFile(aFileName: String);
  end;

  [JsonObject]
  HeaderImporterJSONData = public class
  public
    property Platform: String; notify;
    property TargetString: String; notify;
    property Imports: ObservableCollection<HeaderImport> := new ObservableCollection<HeaderImport>([new HeaderImport]); notify;
  end;

  [JsonObject(MemberSerialization.OptIn)]
  HeaderImport = public class
  public
    [JsonProperty("Name")]
    property LibraryName: String; notify;
    [JsonProperty("Files")]
    property HeaderFiles: String; notify;
    [JsonProperty("Explicit")]
    property OnlyImportExplicitHeaders: Boolean; notify;
  end;

  [JsonObject(MemberSerialization.OptIn)]
  DataAccess = public class(IDataAccess)
  private
    fNavigator := new FXGen.Utilities.Navigator(System.Windows.Application.Current.MainWindow);
  public
    property Platforms: ObservableCollection<String>; notify;
    property TargetStrings: ObservableCollection<String>; notify;
    property ImporterJsonData: HeaderImporterJSONData := new HeaderImporterJSONData; notify;

    method RequestOpenFileName(): String;
    begin
      exit fNavigator.ShowOpenFileDialog('*.json');
    end;

    method LoadFromFile(aFileName: String);
    begin
      var json := File.ReadAllText(aFileName);
      ImporterJsonData := JsonConvert.DeserializeObject<HeaderImporterJSONData>(json);
    end;
      
    constructor;
    begin
      //fill Platform List
      Platforms := new ObservableCollection<String>(['BareMetal-ARM']);
      //fill achitectures List
      TargetStrings := new ObservableCollection<String>(['any', 'i386', 'x86_64',
                                                        'armv6', 'armv7', 'armv7s', 'armv8', 'arm64', 'armv7k',
                                                        'asmjs', 'mipsel', 'mips64el', 'armv5', 'Gotham', 'Discord', 'thumbv7m-none-eabi']);
    end;
  end;

end.
