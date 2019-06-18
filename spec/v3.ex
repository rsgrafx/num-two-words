Code.require_file("./spec/base.ex")

defmodule Orion.V3 do
  import Orion.Base
  import Integer, only: [undigits: 1, digits: 1]

  def get(number) do
    number
    |> do_number()
    |> return()
  end

  defp return(values) when is_binary(values), do: values
  defp return(values) when is_list(values) do
    values
    |> List.flatten()
    |> Enum.filter(&(&1 != ""))
    |> Enum.join(" ")
  end

  defp do_number(num) when num <= 10 do
    Map.get(base_numbers(), num)
  end

  defp do_number(num) when num > 10 and num < 20 do
    Map.get(base_teens(), num)
  end

  defp do_number(num) when num < 100 do
    [tens, num] = digits(num)
    [Map.get(base_tens(), tens), Map.get(base_numbers(), num)]
  end

  defp do_number(num) when num < 1000 do
    split = digits(num)
    rm = tl(split) |> undigits()
    [do_number(hd(split))] ++ ["hundred"] ++ [do_number(rm)]
  end

  defp do_number(num) do
    list = digits(num)
    |> Enum.reverse()
    |> Enum.chunk_every(3)
    |> Enum.with_index()
    |> Enum.map(fn {block, x} -> {Enum.reverse(block), x} end)
    recurse(list, [])
  end

  defp recurse([], string_list) do
    string_list
  end

  defp recurse([{nl, i}|rem], string_list) do
    words = words(undigits(nl), i)
    str = words ++ string_list
    recurse(rem, str)
  end

  defp words(0, _i), do: []
  defp words(num, i) do
    [do_number(num), base(i)]
  end

  def base(0), do: []
  def base(1), do: ["thousand"]
  def base(2), do: ["million"]
  def base(3), do: ["billion"]

end