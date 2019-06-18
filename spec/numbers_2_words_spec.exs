defmodule Numbers2Words do

  @numbers %{
    1 => "one",
    2 => "two",
    3 => "three",
    4 => "four",
    5 => "five",
    6 => "six",
    7 => "seven",
    8 => "eight",
    9 => "nine",
    10 => "ten",
  }

  @teens %{
    11 => "eleven",
    12 => "twelve",
    13 => "thirteen",
    14 => "fourteen",
    15 => "fifteen",
    16 => "sixteen",
    17 => "seventeen",
    18 => "eighteen",
    19 => "nineteen"
  }

  @denominators %{
    3 => "hundred",
    4 => "thousand"
  }

  def get(number) when number <= 10 do
    Map.get(@numbers, number)
  end

  def get(number) when number > 10 and number < 20 do
    Map.get(@teens, number)
  end

  def get(number) when number < 100 do
    nums =
    fn
      num when num >= 20 and num <= 30 ->
        number_string("twenty", number - 20)
      num when num >= 60 and num < 70 ->
        number_string("sixty", number - 60)
    end
    nums.(number)
  end

  def get(number) do
    num_string = "#{number}"

    value = if String.length(num_string) == 3 do
      "hundred"
    end
    string_split = String.split(num_string, "")

    first = Enum.at(string_split, 0)
      |> String.to_integer()
      |> get()

    denominators = Map.get(@denominators, String.length(num_string))
    first <> " " <> value <> " "
  end

  def number_string(string, small_int) do
    num = Map.get(@numbers, small_int)
    "#{string} #{num}"
  end

end