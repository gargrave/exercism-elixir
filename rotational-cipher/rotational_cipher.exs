defmodule RotationalCipher do
  @alpha "abcdefghijklmnopqrstuvwxyz"

  @doc """
  Given a plaintext and amount to shift by, return a rotated string.

  Example:
  iex> RotationalCipher.rotate("Attack at dawn", 13)
  "Nggnpx ng qnja"
  """
  @spec rotate(text :: String.t(), shift :: integer) :: String.t()
  def rotate(text, 0) do
    text
  end

  @spec rotate(text :: String.t(), shift :: integer) :: String.t()
  def rotate(text, shift) when rem(shift, 26) == 0 do
    text
  end

  @spec rotate(text :: String.t(), shift :: integer) :: String.t()
  def rotate(text, shift) do
    alpha_clean = String.split(@alpha, "", trim: true)
    alpha_encoded = build_encoded(alpha_clean, rem(shift, 26))

    text
    |> String.split("", trim: true)
    |> Enum.map(&(sub_character(alpha_clean, alpha_encoded, &1)))
    |> Enum.join
  end

  defp sub_character(alpha_clean, alpha_encoded, char) do
    unless String.match?(char, ~r{[A-z]}) do
      char
    else
      new_char = Enum.at(
        alpha_encoded, 
        Enum.find_index(alpha_clean, &(&1 == String.downcase(char)))
      )

      case String.match?(char, ~r{[A-Z]}) do
        true -> String.upcase(new_char)
        false -> new_char
      end
    end
  end

  defp build_encoded(alpha_clean, shift) do
    Enum.concat(
      Enum.slice(alpha_clean, shift..26),
      Enum.slice(alpha_clean, 0..(shift - 1)))
  end
end
