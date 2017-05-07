namespace FXGen.Converters;

uses
  System.Collections.Generic,
  System.Linq,
  System.Windows.Data,
  System.Windows,
  System.Text;

type

  ListToCSVConvertor = public class(IValueConverter)
  private
  protected
  public

    method Convert(value: Object; targetType: System.Type; parameter: Object; culture: System.Globalization.CultureInfo): Object;
    begin
      var v := IEnumerable<String>(value);
      if not assigned(v) then exit String.Empty;
      exit String.Join('; ', v);
    end;

    method ConvertBack(value: Object; targetType: System.Type; parameter: Object; culture: System.Globalization.CultureInfo): Object;
    begin
      var v := String(value);
      if not assigned(v) then exit new System.Collections.ObjectModel.ObservableCollection<String>;
      var headers := v.Split([',', ';'], StringSplitOptions.RemoveEmptyEntries).Select(s->s.Trim());
      exit new System.Collections.ObjectModel.ObservableCollection<String>(headers);
    end;

  end;

end.
