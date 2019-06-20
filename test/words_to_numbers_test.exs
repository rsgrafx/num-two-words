Code.require_file("./spec/words_to_numbers.ex")

defmodule Orion.Words2NumbersTest do
  use ExUnit.Case
  alias Orion.Words2Numbers

  describe "Convert a number string to integer" do
    test "simple numbers" do
      assert Words2Numbers.get("one") == 1
    end

    test "1..19" do
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
        "ten",
        "eleven",
        "twelve",
        "thirteen",
        "fourteen",
        "fifteen",
        "sixteen",
        "seventeen",
        "eighteen",
        "nineteen"
      ]

      Enum.with_index(numbers_words, 1)
      |> Enum.map(fn {num, word} ->
        assert Words2Numbers.get(num) == word
      end)
    end

    test "twenty" do
      assert Words2Numbers.get("twenty") == 20
      assert Words2Numbers.get("seventy") == 70
    end

    test "tens" do
      assert Words2Numbers.get("twenty one") == 21
      assert Words2Numbers.get("sixty three") == 63
      assert Words2Numbers.get("ninety nine") == 99
    end

    test "hundreds" do
      assert Words2Numbers.get("one hundred") == 100
      assert Words2Numbers.get("three hundred") == 300
    end

    test "hundred + but less than 1000"
    # do
    #   assert Words2Numbers.get("three hundred twenty") == 320
    #   assert Words2Numbers.get("three hundred thirty") == 330
    #   assert Words2Numbers.get("three hundred fourty") == 340
    #   assert Words2Numbers.get("three hundred twenty one") == 321
    # end

    test "thousands"
    # do
    #   assert Words2Numbers.get("one thousand") == 1000
    #   assert Words2Numbers.get("one thousand one") == 1001
    #   assert Words2Numbers.get("one thousand three hundred fourty one") == 1341
    # end
  end
end
