namespace FXGen.Utilities;

uses
  FXGen.DataAccess,
  FXGen.ViewModels;

type

  ViewModelLocator = public class
  private
    fDataAccess: IDataAccess := new DataAccess;
  protected
  public
    property MainWindowViewModel := new MainWindowViewModel(fDataAccess); lazy;
    property HeaderFileHelperViewModel := new HeaderFileHelperViewModel(fDataAccess); lazy;
  end;

end.
