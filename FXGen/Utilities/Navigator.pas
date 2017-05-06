namespace FXGen.Utilities;

uses
  System.Collections.Generic,
  System.Windows,
  MVVM,
  MahApps.Metro.Controls,
  FXGen.Messages;

type

  Navigator = assembly class
  private
    fViewStack := new Stack<Window>;
  protected
  public

    method ShowOpenFileDialog(aFilePattern: String): String;
    begin
      using dlg := new Ookii.Dialogs.Wpf.VistaOpenFileDialog do
      begin
        var curWin := fViewStack.Peek();
        curWin.Opacity := 0.3;
        dlg.DefaultExt := aFilePattern;
        if dlg.ShowDialog(curWin) then result := dlg.FileName;
        curWin.Opacity := 1;
      end;
    end;

    method ShowOpenFolderDialog(): String;
    begin
      using dlg := new Ookii.Dialogs.Wpf.VistaFolderBrowserDialog do
      begin
        var curWin := fViewStack.Peek();
        curWin.Opacity := 0.3;
        if dlg.ShowDialog(curWin) then result := dlg.SelectedPath;
        curWin.Opacity := 1;
      end;
    end;

    method ShowSaveFileDialog(aFileName: String): String;
    begin
      using dlg := new Ookii.Dialogs.Wpf.VistaSaveFileDialog do
      begin
        var curWin := fViewStack.Peek();
        curWin.Opacity := 0.3;
        dlg.FileName := aFileName;             
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

      Messenger.Default.Register<ShowHeaderFileHelperMessage>(self, method(aMessage: ShowHeaderFileHelperMessage)
      begin
        var curWin := fViewStack.Peek();
        curWin.Opacity := 0.3;
        using dlg := new FXGen.Views.HeaderFileHelperView do
        begin
          dlg.Owner := curWin;
          fViewStack.Push(dlg);
          dlg.ShowDialog();
          fViewStack.Pop();
        end;
        curWin.Opacity := 1;
      end);

    end;
  end;

end.
