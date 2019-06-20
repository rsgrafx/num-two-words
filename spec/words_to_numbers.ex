Code.require_file("./spec/base.ex")
defmodule Orion.Words2Numbers do
  import Orion.Base
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
  defp to_num(val) when is_list(val), do: Integer.undigits(val)

  defp do_get(string) when is_binary(string) do
    base_numbers()
    |> flip()
    |> Map.get(string)
  end

  @tens [
    "twenty", "thirty", "forty", "fifty", "sixty", "seventy", "eighty", "ninety"
  ]
  defp do_get([string]) when string in unquote(@tens) do
    [flip(base_tens())[string], 0]
  end

  defp do_get([string]), do: do_get(string)

  defp do_get([t, rem]) do
    [flip(base_tens())[t], do_get(rem)]
  end

  defp do_get(rem) do
    recurse_strings(rem, [])
  end

  defp recurse_strings([], num_list), do: num_list

  defp recurse_strings(["hundred"|tail], num_list) do
    recurse_strings(tail, [0,0|num_list])
  end

  @tens ["twenty", "thirty", "fourty"]
  defp recurse_strings([hd|tail], num_list)  do
    recurse_strings(tail, [do_get(hd)|num_list])
  end

  defp recurse_strings([hd|tail], num_list) do
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