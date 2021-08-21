defmodule Parser.ParseFile do
  def parse(filename) do
    File.stream!(filename)
    |> Enum.map(fn line -> parse_line(line) end)
  end

  defp parse_line(line) do
    line
    |> String.trim()
    |> String.split(",")
    |> convert_tail_into_integer()
  end

  defp convert_tail_into_integer([head | tail]) do
    [String.downcase(head) | Enum.map(tail, &String.to_integer/1)]
  end
end
