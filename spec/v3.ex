Code.require_file("./spec/base.ex")

defmodule Orion.V3 do
  import Orion.Base
  import Integer, only: [undigits: 1, digits: 1]

  def get(number) do
    length =
      number
      |> Integer.digits()
      |> length()

    do_number(number) |> join_all()
  end

  defp do_number(num) do
    digits(num)
    |> Enum.reverse()
    |> Enum.chunk_every(3)
    |> Enum.map(fn block -> Enum.reverse(block) end)
    |> Enum.reverse()
    |> blocks([])
  end

  # Blocks of numbers:
  defp blocks([], list), do: list
  defp blocks(items, list) when length(items) >= 3 do
    base = do_block(items, "million")
    blocks(tl(items), base ++ list)
  end

  defp blocks(items, list) when length(items) <= 2 do
    base = do_block(items, "thousand")
    blocks(tl(items), list ++ base)
  end

  defp do_block(items, value) do
    mil = hd(items)
    base = [do_number(undigits(mil))] ++ [value]
  end

end