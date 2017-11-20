defmodule Hamming do
  def hamming_distance(a, b) when length(a) === length(b) do
    distance = dist(Enum.zip(a, b))
    {:ok, distance}
  end

  def hamming_distance(_, _) do
    {:error, "Lists must be the same length"}
  end

  defp dist(pairs) do
    Enum.count(pairs, fn({a, b}) -> a != b end)
  end
end