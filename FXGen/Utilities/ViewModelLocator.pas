namespace LampSchedulerManager.Utilities;

uses
  Prism.StandardAspects,
  LampSchedulerManager.ViewModels,
  LampSchedulerManager.DataAccess;

type

  ViewModelLocator = public class
  private
    fDataAccess: IDataAccess := new DataAccess;
  protected
  public
    property MainWindowViewModel := new MainWindowViewModel(fDataAccess); lazy;
    property LogOnViewModel := new LogOnWindowViewModel(fDataAccess); lazy;
    property SchedulesTabViewModel := new SchedulesTabViewModel(fDataAccess); lazy;
    property AddEditScheduleViewModel := new AddEditScheduleViewModel(fDataAccess); lazy;
    property LampGroupsTabViewModel := new LampGroupsTabViewModel(fDataAccess); lazy;
    property AddEditLampGroupsViewModel := new AddEditLampGroupViewModel(fDataAccess); lazy;
    property ManageLampsViewModel := new ManageLampsViewModel(fDataAccess); lazy;
    property ScanLampsDialogViewModel := new ScanLampsDialogViewModel(fDataAccess); lazy;
    property ScanLampsProgressDialogViewModel := new ScanLampsProgressDialogViewModel(fDataAccess); lazy;
    property AboutTabViewModel := new AboutTabViewModel(fDataAccess); lazy;
    property UploadFilesTabViewModel := new UploadFilesTabViewModel(fDataAccess); lazy;
    property UserManagementTabViewModel := new UserManagementTabViewModel(fDataAccess); lazy;
    property LogsTabViewModel := new LogsTabViewModel(fDataAccess); lazy;
    property TransmittersSettingsTabViewModel := new TransmittersSettingsTabViewModel(fDataAccess); lazy;

    [aspect: Disposable]
    method Dispose;
    begin
      disposeAndNil(fDataAccess);
    end;
  end;

end.
