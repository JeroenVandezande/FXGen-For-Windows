namespace LampSchedulerManager.Utilities;

uses
  System.Collections.Generic,
  System.Windows,
  MVVM,
  MahApps.Metro.Controls,
  MahApps.Metro.Controls.Dialogs,
  LampSchedulerManager.Messages;

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
      Messenger.Default.Register<InvokeLogOnMessage>(self, method 
      begin
        using dlg := new LampSchedulerManager.Views.LogOnWindowView() do
        begin
          var curWin := fViewStack.Peek();
          curWin.Opacity := 0.3;
          fViewStack.Push(dlg);
          dlg.Owner := curWin;
          dlg.Show();    
        end;
      end);

      Messenger.Default.Register<AbortLogonMessage>(self, method
      begin
        Application.Current.Shutdown();
      end); 

      Messenger.Default.Register<LogOnSuccessfullMessage>(self, method
      begin
        var curwin := fViewStack.Pop();
        curwin.Close();
        curwin := fViewStack.Peek();
        curwin.Opacity := 1;
      end); 

      Messenger.Default.Register<ShowAddEditCronScheduleMessage>(self, method
      begin
        using dlg := new LampSchedulerManager.Views.AddEditScheduleView() do
        begin
          var curWin := fViewStack.Peek();
          curWin.Opacity := 0.3;
          fViewStack.Push(dlg);
          dlg.Owner := curWin;
          dlg.Show();    
        end; 
      end); 

      Messenger.Default.Register<ShowAddEditSimpleScheduleMessage>(self, method
      begin
        using dlg := new LampSchedulerManager.Views.AddEditSimpleScheduleView() do
        begin
          var curWin := fViewStack.Peek();
          curWin.Opacity := 0.3;
          fViewStack.Push(dlg);
          dlg.Owner := curWin;
          dlg.Show();    
        end; 
      end); 

      Messenger.Default.Register<ShowAddEditLampGroupMessage>(self, method
      begin
        using dlg := new LampSchedulerManager.Views.AddEditGroupView() do
        begin
          var curWin := fViewStack.Peek();
          curWin.Opacity := 0.3;
          fViewStack.Push(dlg);
          dlg.Owner := curWin;
          dlg.Show();    
        end; 
      end); 
      
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

      Messenger.Default.Register<DeleteItemConfimationMessage>(self, method(aMessage: DeleteItemConfimationMessage)
      begin
        var curWin := fViewStack.Peek() as MetroWindow;
        var a := await curWin.ShowMessageAsync("Confirm Delete", String.Format("Are you sure you want to delete {0} ?", aMessage.ItemName), MessageDialogStyle.AffirmativeAndNegative);
        if a = MessageDialogResult.Affirmative then aMessage.OnConfirmation();
      end); 

      Messenger.Default.Register<ShowMessageMessage>(self, method(aMessage: ShowMessageMessage)
      begin
        var curWin := fViewStack.Peek() as MetroWindow;
        await curWin.ShowMessageAsync(aMessage.Title, aMessage.Message);
      end); 

      Messenger.Default.Register<ShowScanLampsDialogMessage>(self, method
      begin
        using dlg := new LampSchedulerManager.Views.ScanLampsDialogViewView() do
        begin
          var curWin := fViewStack.Peek();
          curWin.Opacity := 0.3;
          fViewStack.Push(dlg);
          dlg.Owner := curWin;
          dlg.Show();    
        end; 
      end);

      Messenger.Default.Register<ShowScanLampsInProgressDialogMessage>(self, method
      begin
        using dlg := new LampSchedulerManager.Views.ScanLampsProgressDialogView do
        begin
          var curWin := fViewStack.Peek();
          curWin.Opacity := 0.3;
          fViewStack.Push(dlg);
          dlg.Owner := curWin;
          dlg.Show();    
        end; 
      end);

    end;
  end;

end.
