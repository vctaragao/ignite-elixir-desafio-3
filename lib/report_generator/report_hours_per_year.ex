defmodule ReportGenerator.ReportHoursPerYear do
  alias Model.Worker

  def generate(list) do
    %{
      hours_per_year: generate_hours_per_year(list)
    }
  end

  defp generate_hours_per_year(list) do
    list
    |> Enum.reduce(generate_initial_report(), fn [name, hours, _day, _month, year], report ->
      person = String.to_atom(name)

      year =
        year
        |> Integer.to_string()
        |> String.to_atom()

      result = Map.put(report[person], year, report[person][year] + hours)
      Map.put(report, person, result)
    end)
  end

  defp generate_initial_report do
    initial_year_values = generate_initial_year_values()

    Enum.reduce(Worker.get_all_workers(), %{}, fn worker, report ->
      Map.put(report, String.to_atom(worker), initial_year_values)
    end)
  end

  defp generate_initial_year_values do
    Enum.reduce(get_all_year(), %{}, fn year, report ->
      year =
        year
        |> Integer.to_string()
        |> String.to_atom()

      Map.put(report, year, 0)
    end)
  end

  defp get_all_year, do: [2016, 2017, 2018, 2019, 2020]
end
