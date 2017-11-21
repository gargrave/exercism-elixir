defmodule Allergies do
  import Bitwise

  @allergens [
    "eggs",
    "peanuts",
    "shellfish",
    "strawberries",
    "tomatoes",
    "chocolate",
    "pollen",
    "cats"
  ]

  @doc """
  List the allergies for which the corresponding flag bit is true.
  """
  @spec list(non_neg_integer) :: [String.t]
  def list(flags) do
    find_allergies(flags) 
  end

  @doc """
  Returns whether the corresponding flag bit in 'flags' is set for the item.
  """
  @spec allergic_to?(non_neg_integer, String.t) :: boolean
  def allergic_to?(flags, item) do
    list(flags) 
    |> Enum.member?(item)
  end

  @spec find_allergies(non_neg_integer) :: [String.t]
  defp find_allergies(flags) do
    {allergens, _} = indexed_list()
    |> Stream.filter(fn({allergen, flag}) -> (flags &&& flag) > 0 end)
    |> Enum.unzip
    allergens
  end

  @spec indexed_list() :: {[String.t], [non_neg_integer]}
  defp indexed_list() do
    Stream.with_index(@allergens)
    |> Enum.map(fn({allergen, i}) -> {allergen, 1 <<< i} end) 
  end
end
