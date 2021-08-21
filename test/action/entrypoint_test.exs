defmodule Action.EntrypointTest do
  use ExUnit.Case

  alias Action.Entrypoint
  alias GenReport.Support.ReportFixture

  @file_name "gen_report.csv"

  describe "execute/1" do
    test "When passing file name return a report" do
      response = Entrypoint.execute(@file_name)

      assert response == ReportFixture.build()
    end

    test "When no filename was given, returns an error" do
      response = Entrypoint.execute()

      assert response == {:error, "Insira o nome de um arquivo"}
    end
  end
end
