Code.require_file("./spec/numbers_2_words_spec.exs")


defmodule Numbers2WordsTest do

  use ExUnit.Case

  describe "Numbers 2 Words" do
    test "should convert integer to word equivalent" do
      assert "one" == Numbers2Words.get(1)
    end

    test "number 2" do
      assert "two" == Numbers2Words.get(2)
    end

    test "numbers within to 10" do
      numbers_words = [
      "one",
      "two",
      "three",
      "four",
      "five",
      "six",
      "seven",
      "eight",
      "nine",
       "ten"
      ]

       Enum.with_index(numbers_words, 1)
       |> Enum.map(fn {word, num} ->
          assert word == Numbers2Words.get(num)
       end)

    end

    test "teens" do
      assert "eleven" == Numbers2Words.get(11)
    end

    test "tens" do
      assert "sixty one" == Numbers2Words.get(61)
    end

    test "nine hundred and twenty one" do
      assert "nine hundred and twenty one" == Numbers2Words.get(921)
    end
  end
end
