namespace LampSchedulerManager.Messages;

type

  CloseCurrentWindowMessage = assembly class;

  ViewActivated = assembly class
  public
    property ViewName: String;
    constructor(aViewName: String);
    begin
      ViewName := aViewName;
    end;
  end;
  
end.
