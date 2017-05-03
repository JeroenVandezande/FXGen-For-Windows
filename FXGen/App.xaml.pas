namespace FXGen;

interface

uses
  System.Windows,
  System.Data,
  System.Xml,
  System.Configuration;

type
  App = public partial class(System.Windows.Application)
  assembly
    class property Navigator: FXGen.Utilities.Navigator;
  end;
  
implementation

end.
