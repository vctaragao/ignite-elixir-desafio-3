defmodule ReportGenerator.ReportHoursPerMonth do
  alias Model.Month
  alias Model.Worker

  def generate(list) do
    %{
      hours_per_month: generate_hours_per_month(list)
    }
  end

  defp generate_hours_per_month(list) do
    list
    |> Enum.reduce(generate_initial_report(), fn [name, hours, _day, month, _year], report ->
      person = String.to_atom(name)

      month =
        month
        |> Month.get_month_by_number()
        |> String.to_atom()

      result = Map.put(report[person], month, report[person][month] + hours)
      Map.put(report, person, result)
    end)
  end

  defp generate_initial_report do
    initial_months_values = generate_initial_month_values()

    Enum.reduce(Worker.get_all_workers(), %{}, fn worker, report ->
      Map.put(report, String.to_atom(worker), initial_months_values)
    end)
  end

  defp generate_initial_month_values do
    Enum.reduce(Month.get_all_months(), %{}, fn month, report ->
      Map.put(report, String.to_atom(month), 0)
    end)
  end
end
