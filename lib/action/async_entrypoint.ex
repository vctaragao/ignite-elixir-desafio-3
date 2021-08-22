defmodule Action.AsyncEntrypoint do
  alias Parser.ParseFile
  alias ReportGenerator.Generator

  def execute(filenames) when is_list(filenames) do
    filenames
    |> Task.async_stream(&generate_report_from_file/1)
    |> Enum.reduce(%{}, fn {:ok, report}, result_report ->
      build_final_report(result_report, report)
    end)
  end

  defp generate_report_from_file(filename) do
    filename
    |> ParseFile.parse()
    |> Generator.generate_report()
  end

  defp build_final_report(result_report, report) when result_report == %{}, do: report

  defp build_final_report(v1, v2) when is_integer(v1) and is_integer(v2) do
    v1 + v2
  end

  defp build_final_report(result_report, report) do
    Map.merge(result_report, report, fn _key, map1, map2 ->
      build_final_report(map1, map2)
    end)
  end

  def execute do
    {:error, "Insira uma lista de arquivos"}
  end
end
