defmodule SecretHandshake do
  use Bitwise

  @all_commands [
    "wink",
    "double blink",
    "close your eyes",
    "jump"
  ]
  @reverse_bit 16

  @doc """
  Determine the actions of a secret handshake based on the binary
  representation of the given `code`.

  If the following bits are set, include the corresponding action in your list
  of commands, in order from lowest to highest.

  1 = wink
  10 = double blink
  100 = close your eyes
  1000 = jump

  10000 = Reverse the order of the operations in the secret handshake
  """
  @spec commands(code :: integer) :: list(String.t())
  def commands(code) do
    # check each command for bit
    # push valid commands into list
    command_list =
      indexed_codelist()
      |> Enum.reduce([], fn({cmd, bit}, acc) -> 
        cond do 
          (code &&& bit) > 0 ->
            [cmd | acc]
          true -> acc
        end
      end)

    # reverse list if reverse_bit is present
    cond do
      (code &&& @reverse_bit) == 0 -> 
        Enum.reverse(command_list)
      true -> command_list
    end
  end

  defp indexed_codelist() do
    @all_commands
    |> Stream.with_index
    |> Enum.map(fn({cmd, i}) -> {cmd, 1 <<< i} end)
  end
end

