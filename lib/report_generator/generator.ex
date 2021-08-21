defmodule ReportGenerator.Generator do
  alias ReportGenerator.ReportAllHours
  alias ReportGenerator.ReportHoursPerMonth
  alias ReportGenerator.ReportHoursPerYear

  def generate_report(list) do
    %{}
    |> Map.merge(ReportAllHours.generate(list))
    |> Map.merge(ReportHoursPerMonth.generate(list))
    |> Map.merge(ReportHoursPerYear.generate(list))
  end
end
