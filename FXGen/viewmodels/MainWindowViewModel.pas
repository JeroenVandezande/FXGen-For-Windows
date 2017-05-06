﻿namespace FXGen.ViewModels;

uses
  System.Linq,
  System.Collections.ObjectModel,
  MVVM,
  FXGen,
  FXGen.DataAccess,
  FXGen.Utilities,
  FXGen.Messages;

type

  MainWindowViewModel = public class
  private
  protected
  public
    property DataAccess: IDataAccess; notify;
    //commands
    property InvokeHeaderFilesHelperCommand := new RelayCommand(method; begin
      Messenger.Default.Send(new ShowHeaderFileHelperMessage);
    end); readonly;

    constructor(aDataAccess: IDataAccess);
    begin
      DataAccess := aDataAccess;
      var hi := new HeaderImporter;
    end;
  end;

end.
