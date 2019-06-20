Code.require_file("./spec/v2/grammar.ex")

defmodule Orion.WordsToInt do
  import Words.Grammar

  @moduledoc  """
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

  @doc "Returns the grammar"
  @spec grammar(String.t()) :: List.t
  def grammar(string) do
    string_list = parse(string)
    Enum.map(string_list, fn item ->
      Map.get(numbers(), item)
      |> case do
        num when is_number(num) -> Integer.digits(num)
        val -> val
      end
    end)
  end

  def parse(string) do
    string
    |> String.trim()
    |> String.split(" ")
  end

  @spec convert(List.t) :: Integer.t()
  def convert(list) do
    Enum.reduce(list, 0
      fn
        # -- TODO: LONG DAY.
      end
    )
  end

end