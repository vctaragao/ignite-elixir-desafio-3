defmodule ReportGenerator.ReportAllHours do
  alias Model.Worker

  def generate(list) do
    %{
      all_hours: generate_all_hours(list)
    }
  end

  defp generate_all_hours(list) do
    list
    |> Enum.reduce(generate_initial_report(), fn [name, hours, _day, _month, _year], report ->
      atom = String.to_atom(name)
      Map.put(report, atom, report[atom] + hours)
    end)
  end

  defp generate_initial_report do
    Enum.reduce(Worker.get_all_workers(), %{}, fn worker, report ->
      Map.put(report, String.to_atom(worker), 0)
    end)
  end
end
