defmodule Acronym do
  def abbreviate(str) do
    str
      |> split_str
      |> Stream.map(&(truncate_str(&1)))
      |> Enum.join
  end

  defp split_str(str) do
    str 
      |> String.replace(~r{([A-Z])}, "_\\g{1}")
      |> String.split(~r{_|\s|[^\w\d\s]}, trim: true)
  end

  defp truncate_str(str) do
    str
      |> String.slice(0..0)
      |> String.upcase
  end
end
