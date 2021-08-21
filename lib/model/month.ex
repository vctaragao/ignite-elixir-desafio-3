defmodule Model.Month do
  def get_all_months do
    [
      "janeiro",
      "fevereiro",
      "março",
      "abril",
      "maio",
      "junho",
      "julho",
      "agosto",
      "setembro",
      "outubro",
      "novembro",
      "dezembro"
    ]
  end

  def get_month_by_number(number), do: Enum.at(get_all_months(), number - 1)
end
