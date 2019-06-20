Code.require_file("./spec/v2/grammar.ex")

defmodule Orion.WordsToInt do
  import Words.Grammar
  import Integer, only: [undigits: 1, digits: 1]

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

  def get(string) do
    string
    |> grammar()
    |> convert()
  end

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
  def convert(base), do: convert(base, 0)
  def convert([], val), do: val

  def convert([x], val) when is_list(x) do
    convert([], undigits(x) + val)
  end
  def convert([x], val) when is_number(x) do
    convert([], x + val)
  end

  def convert([x, y], val) when is_number(x) and is_number(y) do
    convert([], x + y + val)
  end
  def convert([x, y], val) when is_list(x) and is_list(y) do
    val = undigits(x) + undigits(y)
    convert([], val)
  end

  def convert([h, top| tail]) when is_list(h) and is_list(top) do
    val = undigits(h) + undigits(top)
    convert(tail, val)
  end

  def convert([h,top|tail], val) when is_tuple(h) do
    val = digits(val) ++ Tuple.to_list(h)
    val = undigits(val)
    convert(tail, val)
  end

  def convert([h,top|tail], val) when is_list(h) and is_tuple(top) do
    val = undigits(h ++ Tuple.to_list(top))
    convert(tail, val)
  end

end