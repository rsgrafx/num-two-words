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

  defp do_number(num) when num < 20 do
    base_numbers()[num]
  end

  defp do_number(num) when is_integer(num) do
    digits(num) |> do_number()
  end

  defp do_number([tens, num]) do
    [base_tens()[tens], base_numbers()[num]]
  end

  defp do_number([top | rem] = num) when length(num) < 4 do
    [
      do_number(top)
      | [
          "hundred",
          rem
          |> undigits()
          |> do_number()
        ]
    ]
  end

  defp do_number(num) do
    num
    |> Enum.reverse()
    |> Stream.chunk_every(3)
    |> Stream.with_index()
    |> Stream.map(fn {block, x} -> {Enum.reverse(block), x} end)
    |> Enum.to_list()
    |> recurse([])
  end

  defp recurse([], string_list) do
    string_list
  end

  defp recurse([{nl, i} | rem], string_list) do
    words = words(undigits(nl), i)
    recurse(rem, [words | string_list])
  end

  defp words(0, _i), do: []

  defp words(num, i) do
    [do_number(num), base(i)]
  end

  def base(0), do: []
  def base(1), do: ["thousand"]
  def base(2), do: ["million"]
  def base(3), do: ["billion"]
  def base(4), do: ["trillion"]
end
