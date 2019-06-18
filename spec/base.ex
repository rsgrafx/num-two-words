defmodule Orion.Base do

  @numbers %{
    0 => "",
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

  @tens %{
    2 => "twenty",
    3 => "thirty",
    4 => "fourty",
    5 => "fifty",
    6 => "sixty",
    7 => "seventy",
    8 => "eighty",
    9 => "ninety"
  }

  @base %{
    3 => "hundred",
    4 => "thousand",
    5 => "thousand",
    6 => "million",
    7 => "million"
  }

  def base, do: @base
  def base_tens, do: @tens
  def base_teens, do: @teens
  def base_numbers, do: @numbers
end