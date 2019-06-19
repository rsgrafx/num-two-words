Code.require_file("./spec/base.ex")

defmodule Orion.V2 do
  import Orion.Base
  import Integer, only: [undigits: 1, digits: 1]

  def get(number) do
    do_number(number) |> join_all()
  end

  defp do_number(0), do: []

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

  defp do_number(num) when num < 1000000 do
    {thousands, base} = Enum.split(digits(num), -3)
    [do_number(undigits(thousands)), "thousand"] ++ [do_number(undigits(base))]
  end

  defp do_number(num) when num > 1000000 do
    [millions, thousands, hundreds] = block(num)
    rem = thousands ++ hundreds
    [do_number(undigits(millions)), "million"] ++ [do_number(undigits(rem))]
  end

  defp do_number({[], base}) do
    do_number(undigits(base))
  end

  defp block(num) do
    digits(num)
    |> Enum.reverse()
    |> Enum.chunk_every(3)
    |> Enum.map(fn block -> Enum.reverse(block) end)
    |> Enum.reverse()
  end
  #
  def base_term(len) do
    Map.get(base(), len)
  end

  defp join_all(value) when is_binary(value) do
    value
  end

  defp join_all(values) when is_list(values) do
    values
    |> List.flatten()
    |> Enum.map(&String.trim/1)
    |> Enum.filter(&(&1 != ""))
    |> Enum.join(" ")
    |> String.trim()
  end


end