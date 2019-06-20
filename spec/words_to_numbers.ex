Code.require_file("./spec/base.ex")
defmodule Orion.Words2Numbers do
  import Orion.Base
  import Integer, only: [undigits: 1]
  @moduledoc """
  House logic that handles converting words to numbers.
  """
  def get(string) do
    string
    |> parse_to_list()
    |> do_get()
    |> to_num()
  end

  defp to_num(val) when is_number(val), do: val
  defp to_num(val) when is_list(val) do
    Enum.reduce(val, {[], []}, fn
      item, {acc, l} when is_number(item) -> {acc ++ [item], l}
      item, {acc, l} when is_list(item) ->  {acc, [item|[l]] }
    end)
    |> case do
      {p, []} -> undigits(p)
      {p, list} ->
        {p = undigits(p), results = Enum.reduce(list, 0, fn i, acc -> acc + undigits(i) end)}
        p + results
    end
  end

  @tens [
    "twenty", "thirty", "fourty", "fifty", "sixty", "seventy", "eighty", "ninety"
  ]
  defp do_get(string) when string in unquote(@tens) do
    [flip(base_tens())[string], 0]
  end

  defp do_get(string) when is_binary(string) do
    base_numbers()
    |> flip()
    |> Map.get(string)
  end

  defp do_get([string]), do: do_get(string)
  defp do_get([t, rem]), do: [flip(base_tens())[t], do_get(rem)]
  defp do_get(rem),      do: recurse_strings(rem, [])

  defp recurse_strings([], num_list), do: num_list

  defp recurse_strings(["hundred"|tail], num_list) do
    recurse_strings(tail, num_list ++ [0,0])
  end

  defp recurse_strings([hd|tail], num_list)  do
    recurse_strings(tail, [do_get(hd)|num_list])
  end

  defp parse_to_list(string) do
    string
    |> String.trim()
    |> String.split(" ")
  end

  defp flip(data) do
    data
    |> Enum.map(fn {k, v} -> {v, k} end)
    |> Enum.into(%{})
  end
end