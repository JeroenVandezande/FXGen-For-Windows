namespace FXGen.Utilities;

uses
  FXGen.viewmodels;

type

  ViewModelLocator = public class
  private
  protected
  public
    property MainWindowViewModel := new MainWindowViewModel(); lazy;
  end;

end.
