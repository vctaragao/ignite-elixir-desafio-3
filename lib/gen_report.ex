defmodule GenReport do
  @moduledoc """

  """
  def build(filename) do
    File.stream!(filename)
    |> Enum.map(fn line -> parse_line(line) end)

    # |> Enum.reduce(%{}, fn line, acc -> generate_report(line, acc) end)
  end

  defp parse_line(line) do
    line
    |> String.trim()
    |> String.split(",")
    |> convert_tail_into_integer()
  end

  defp convert_tail_into_integer([head | tail]) do
    [head | Enum.map(tail, &String.to_integer/1)]
  end

  # defp generate_report(_line, _acc) do
  #   %{
  #     all_hours: %{}
  #   }
  # end
end
