Code.require_file("./spec/v2.ex")

defmodule Numbers2Words_V2_Test do
  use ExUnit.Case
  alias Orion.V2, as: Numbers2Words

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
      assert "seventy four" == Numbers2Words.get(74)
      assert "ninety nine" == Numbers2Words.get(99)
    end

    test "one hundred" do
      assert "one hundred" == Numbers2Words.get(100)
      assert "one hundred thirty one" == Numbers2Words.get(131)
    end

    test "nine hundred twenty one" do
      assert "nine hundred twenty one" == Numbers2Words.get(921)
    end

    test "two thousand nine hundred twenty one" do
      assert "two thousand nine hundred twenty one" == Numbers2Words.get(2921)
    end

    test "10 thousand nine hundred and twenty one" do
      assert "ten thousand nine hundred twenty one" == Numbers2Words.get(10921)
    end

    test "thirty thousand ten" do
      assert "thirty thousand ten" == Numbers2Words.get(30010)
      assert "thirty three thousand ten" == Numbers2Words.get(33010)
    end

    test "three hundred and twenty thousand and fifty three" do
      assert "three hundred twenty thousand fifty three" == Numbers2Words.get(320_053)
    end

    test "two million one" do
      assert "two million one" == Numbers2Words.get(2_000_001)
    end

    test "millions.." do
      assert "two million one" == Numbers2Words.get(2_000_001)
      assert "two million one thousand one" == Numbers2Words.get(2_001_001)
    end
  end
end
