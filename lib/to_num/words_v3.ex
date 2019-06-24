defmodule Orion.WordsV3.Converter do
  # Converter Logic
  @moduledoc """
  Houses data structure conversion logic
  that allows me to convert.
    {tuples} being the identifiers to the function for it being a
    hundreds, thousands, etc.
    # much more extendable.

    #  =>  [
      [1],{0,0,0,0,0,0},
      [3],{0,0},{0,0,0},
      [2],{0,0},
      [1]
    ]
    # to => [
      [1,0,0,0,0,0,0],
      [3,0,0,0,0,0],
      [2,0,0],
      [1]
    ]
    # Which is much easier to reduce.
  """

  defp convert([], builder), do: builder

  defp convert([i|tail], builder) when is_list(i) do
    convert(tail, [i|builder])
  end

  defp convert([i|tail], builder) when is_tuple(i) do
    [item|builder] = builder
    convert(tail, [item ++ Tuple.to_list(i)|builder])
  end

  @spec convert([List.t|Tuple.t]) :: Integer.t
  def convert(list) do
    list = convert(list, [])
    Enum.reduce(list, 0, fn i, acc ->
      Integer.undigits(i) + acc
    end)
  end
end
