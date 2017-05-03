namespace FXGen.Utilities;

uses
  System.Collections.Generic,
  System.Windows,
  MVVM,
  MahApps.Metro.Controls,
  MahApps.Metro.Controls.Dialogs,
  FXGen.Messages;

type

  Navigator = assembly class
  private
    fViewStack := new Stack<Window>;
  protected
  public

    method ShowOpenFileDialog(aInitialFolder: String; aFilePattern: String): String;
    begin
      using dlg := new Microsoft.Win32.OpenFileDialog() do
      begin
        var curWin := fViewStack.Peek();
        curWin.Opacity := 0.3;
        dlg.InitialDirectory := aInitialFolder;
        dlg.DefaultExt := aFilePattern;
        if dlg.ShowDialog(curWin) then result := dlg.FileName;
        curWin.Opacity := 1;
      end;
    end;

    method ShowSaveFileDialog(aInitialFolder: String; aFileName: String): String;
    begin
      using dlg := new Microsoft.Win32.SaveFileDialog() do
      begin
        var curWin := fViewStack.Peek();
        curWin.Opacity := 0.3;
        dlg.FileName := aFileName;
        dlg.InitialDirectory := aInitialFolder;                
        if dlg.ShowDialog(curWin) then result := dlg.FileName;
        curWin.Opacity := 1;
      end;
    end;

    constructor(aMainWindow: Window);
    begin
      fViewStack.Push(aMainWindow);
      
      Messenger.Default.Register<CloseCurrentWindowMessage>(self, method
      begin
        var curWin := fViewStack.Pop();
        var cls: Action := method 
        begin
          curWin.Close();
          curWin := fViewStack.Peek();
          curWin.Opacity := 1;
        end;
        if System.Windows.Threading.DispatcherObject(curWin).CheckAccess() then
          cls()
        else
          System.Windows.Threading.DispatcherObject(curWin).Invoke(cls);      
      end); 

    end;
  end;

end.
