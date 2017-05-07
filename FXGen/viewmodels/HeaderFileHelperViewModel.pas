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
  protected
  public
    property DataAccess: IDataAccess;

    constructor(aDataAccess: IDataAccess);
    begin
      DataAccess := aDataAccess;
      Messenger.Default.Register<ShowHeaderFileHelperMessage>(self, method(aMessage: ShowHeaderFileHelperMessage)
      begin
        
      end);

    end;
  end;

end.
