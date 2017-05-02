namespace FXGen;

interface

uses
  System.Collections.Generic,
  System.Linq,
  System.Windows,
  System.Windows.Controls,
  System.Windows.Data,
  System.Windows.Documents,
  System.Windows.Media,
  System.Windows.Navigation,
  System.Windows.Shapes;

type

  MainView = public partial class(System.Windows.Window)
  private
  public
    constructor;
  end;
  
implementation

constructor MainView;
begin
  InitializeComponent();
end;
  
end.
