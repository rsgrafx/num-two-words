Code.require_file("./spec/v2/grammar.ex")
Code.require_file("./spec/words_v3.ex") # Solution

defmodule Orion.WordsToInt do
  import Words.Grammar
  alias Orion.WordsV3.Converter, as: V3


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
    |> V3.convert() #Note Change
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

  # See Implementation in * `spec/words_v3.ex`

  # @spec convert(List.t) :: Integer.t()
  # def convert(base), do: convert(base, 0)
  # def convert([], val), do: val

  # def convert([x], val) when is_list(x) do
  #   convert([], undigits(x) + val)
  # end
  # def convert([x], val) when is_number(x) do
  #   convert([], x + val)
  # end

  # # Bad solution - you will continue to keep adding function heads
  # # to mitigate potential
  # def convert([h, top, tuple |tail], val) when is_list(h) and is_tuple(top) and is_tuple(tuple) do
  #   sml = h ++ Tuple.to_list(top) ++ Tuple.to_list(tuple)
  #   val = val + undigits(sml)
  #   convert(tail, val)
  # end

  # def convert([h, top, tuple |tail], val) when is_list(h) and is_list(top) and is_tuple(tuple) do
  #   sml = top ++ Tuple.to_list(tuple)
  #   val = val + undigits(h) + undigits(sml)
  #   convert(tail, val)
  # end

  # def convert([x, y], val) when is_number(x) and is_number(y) do
  #   convert([], x + y + val)
  # end

  # def convert([x, y], val) when is_list(x) and is_list(y) do
  #   val = undigits(x) + undigits(y)
  #   convert([], val)
  # end

  # def convert([h,top|tail], val) when is_tuple(h) and is_list(top) do
  #   large = digits(val) ++ Tuple.to_list(h)
  #   val = val + undigits(large) + undigits(top)
  #   convert(tail, val)
  # end

  # def convert([h,top|tail], val) when is_list(h) and is_tuple(top) do
  #   count = h ++ Tuple.to_list(top)
  #   convert([count|tail], val)
  # end

end