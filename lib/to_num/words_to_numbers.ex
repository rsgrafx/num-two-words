defmodule Orion.WordsToNumbers do
  import Words.Grammar

  @converter Orion.Grammar.Converter
  @moduledoc """
    Second attempt at parsing words to numbers.
    From text to integers.

    Given that these text strings follow a specific
    format
    `fourty two 42`
    `six hundred seventy five - 675`
    `one hundred one thousand - 101_000`
    `two thousand one hundred two - 2102`
    `seven million three hundred thousand fifty three - 7_300_053`
    `two million three thousand fifty three - 2_003_053`

    We expect to be able to iterate over the text
    and identify base level.

    # Identified pattern -
    (number) (base10)* (number) (base10)

    # Potential parser
    [[6],{0,0},[7,0],{0,0,0}]

  """

  def get(string) do
    string
    |> grammar()
    |> @converter.convert()
  end

  @doc "Returns the grammar"
  @spec grammar(String.t()) :: List.t()
  def grammar(string) do
    string
    |> parse()
    |> Enum.map(&build_list/1)
  end

  defp build_list(data) do
    numbers()
    |> Map.get(data)
    |> digitize()
  end

  defp digitize(i) when is_number(i), do: Integer.digits(i)
  defp digitize(i), do: i

  def parse(string) do
    string
    |> String.trim()
    |> String.split(" ")
  end
end
