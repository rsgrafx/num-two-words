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
    end

  end

end