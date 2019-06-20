Code.require_file("./spec/words_v2.ex")

defmodule Orion.WordsV2Test do
  use ExUnit.Case

  @parser Orion.WordsToInt

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
    end

  end

  describe "grammar to number" do
    test ".convert" do
      assert @parser.convert([1]) == 1
      assert @parser.convert([[1],[2]]) == 12
      assert @parser.convert([[3],{0,0},[2]]) == 302
      assert @parser.convert([[3],{0,0,0},[2]]) == 3002
      assert @parser.convert([[3],{0,0,0},[1,2]]) == 3012

      assert @parser.convert([[7,0],{0,0,0,0,0,0},[7,0],{0,0,0}, [1]]) == 70_070_001
      assert @parser.convert([[7,0],{0,0,0,0,0,0},[7,0],{0,0,0}, [2,1]]) == 70_070_021
    end
  end

  describe "string to number" do

    test "get" do
      assert @parser.get("one hundred million one") == 100_000_001
      assert @parser.get("one thousand one") == 1001

      assert @parser.get("one million one") == 1_000_001
    end
  end

end