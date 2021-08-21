defmodule Action.Entrypoint do
  alias Parser.ParseFile
  alias ReportGenerator.Generator

  def execute(filename) do
    filename
    |> ParseFile.parse()
    |> Generator.generate_report()
  end

  def execute do
    {:error, "Insira o nome de um arquivo"}
  end
end
