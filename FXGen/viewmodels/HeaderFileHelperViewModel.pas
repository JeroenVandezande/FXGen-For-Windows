namespace FXGen.ViewModels;

uses
  System.Linq,
  System.Collections.ObjectModel,
  MVVM,
  FXGen,
  FXGen.Utilities,
  FXGen.Messages,
  FXGen.DataAccess;

type

  HeaderFileHelperViewModel = public class
  private
    fDataAccess: IDataAccess;
  protected
  public
    property HeaderFiles: ObservableCollection<String>; notify;

    constructor(aDataAccess: IDataAccess);
    begin
      fDataAccess := aDataAccess;
      Messenger.Default.Register<ShowHeaderFileHelperMessage>(self, method(aMessage: ShowHeaderFileHelperMessage)
      begin
        if fDataAccess.ImporterJsonData.Imports:Count > 0 then
        begin
          var hfa := fDataAccess.ImporterJsonData.Imports[0].HeaderFiles.Split([';',',']);
          HeaderFiles := new ObservableCollection<String>(hfa);
        end;
      end);

    end;
  end;

end.
