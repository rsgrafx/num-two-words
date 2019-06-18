Code.require_file("./spec/numbers_two_words.exs")

defmodule Numbers2WordsTest do
  use ExUnit.Case
  alias Orion.Numbers2Words

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

    test "zero" do
      assert "" == Numbers2Words.get(0)
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

    test "two thousand nine hundred and twenty one" do
      assert "two thousand and nine hundred and twenty one" == Numbers2Words.get(2921)
    end

    test "10 thousand nine hundred and twenty one" do
      assert "ten thousand and nine hundred and twenty one" == Numbers2Words.get(10921)
    end

    test "thirty thousand and ten" do
      assert "thirty thousand and ten" == Numbers2Words.get(30010)
    end

    test "three hundred and twenty thousand and fifty three" do
      assert "three hundred and twenty thousand fifty three" == Numbers2Words.get(320_053)
    end

    test "two million and one" do
      assert "two million one" == Numbers2Words.get(2_000_001)
    end
  end
end
