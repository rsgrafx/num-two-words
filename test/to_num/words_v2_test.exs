# Code.require_file("./spec/words_v2.ex")
# Code.require_file("./spec/words_v3.ex")

defmodule Orion.WordsV2Test do
  use ExUnit.Case

  @parser Orion.WordsToNumbers

  # Solution that passes tests.
  @converter Orion.Grammar.Converter

  describe "parse string" do
    test "parse to list" do
    assert @parser.parse("fourty two") == ["fourty", "two"]

    assert @parser.parse("two million three thousand fifty three") == [
      "two",
      "million",
      "three",
      "thousand",
      "fifty",
      "three"
    ]
    end
  end

  describe "grammar / data structure" do
    test "builds grammar" do
      string = "six hundred seventy thousand"
      assert [[6],{0,0},[7,0],{0,0,0}] == @parser.grammar(string)

      string = "seventy million seventy thousand one"
      assert [[7,0],{0,0,0,0,0,0},[7,0],{0,0,0}, [1]] == @parser.grammar(string)
      string = "three thousand twelve"
      assert [[3],{0,0,0},[1,2]] == @parser.grammar(string)
      assert [
        [1],{0,0,0,0,0,0},[3],{0,0},{0,0,0},[2],{0,0},[1]
      ] == @parser.grammar("one million three hundred thousand two hundred one")
    end

  end

  describe "grammar to number" do
    test ".convert" do
      # Note not using parser.
      assert @converter.convert([[1]]) == 1
      assert @converter.convert([[1],[2]]) == 3
      assert @converter.convert([[3],{0,0},[2]]) == 302
      assert @converter.convert([[3],{0,0,0},[2]]) == 3002
      assert @converter.convert([[3],{0,0,0},[1,2]]) == 3012

      assert @converter.convert([[7,0],{0,0,0,0,0,0},[7,0],{0,0,0}, [1]]) == 70_070_001
      assert @converter.convert([[7,0],{0,0,0,0,0,0},[7,0],{0,0,0}, [2,1]]) == 70_070_021

      assert @converter.convert(
        [[1],{0,0,0,0,0,0},[3],{0,0},{0,0,0},[2],{0,0},[1]]
      ) == 1_300_201

    end
  end

  describe "string to number" do

    test "get" do
      assert @parser.get("one hundred million one") == 100_000_001
      assert @parser.get("one thousand one") == 1001

      assert @parser.get("one million one") == 1_000_001
      assert @parser.get("one million two hundred one") == 1_000_201
      assert @parser.get("one million three hundred thousand two hundred one") == 1_300_201
    end
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

    numbers_words
    |> Enum.with_index(1)
    |> Enum.map(fn {num, word} ->
      assert @parser.get(num) == word
    end)
  end

end