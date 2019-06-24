defmodule Orion.NumbersToWords do
  import Orion.Base

  def get(num) when num in [0, "0"] do
    ""
  end

  def get(number) when number <= 10 do
    Map.get(base_numbers(), number)
  end

  def get(number) when number > 10 and number < 20 do
    Map.get(base_teens(), number)
  end

  def get(number) do
    "#{number}"
    |> String.splitter("", trim: true)
    |> Enum.to_list()
    |> do_number("")
  end

  def do_number(list, string \\ "")

  def do_number([], string), do: string

  def do_number([head | last], string) when head in [0, "0"] do
    do_number(last, string)
  end

  def do_number(num_list, _string) when length(num_list) >= 7 do
    {millions, rest} = Enum.split(num_list, -6)

    string = do_number(millions)
    do_number(rest, "#{string} million ")
  end

  def do_number([a, b, c | rest] = num_list, _string) when length(num_list) > 5 do
    string = do_number([a, b, c]) <> "thousand "
    do_number(rest, string)
  end

  def do_number([a, b | last] = num_list, string) when length(num_list) == 5 do
    base = fetch_base(num_list, hd(last))
    head = String.to_integer("#{a}#{b}")
    string = string <> "#{get(head)} " <> "#{base} " <> "and "
    do_number(last, string)
  end

  def do_number([head | last] = num_list, string) when length(num_list) >= 3 do
    base = fetch_base(num_list, hd(last))
    num = String.to_integer(head)
    string = string <> "#{get(num)} " <> "#{base} " <> "and "
    do_number(last, string)
  end

  def do_number([head | last] = num_list, string) when length(num_list) == 2 do
    tens = num_check(base_tens(), head)
    string = string <> "#{tens} "
    do_number(last, string)
  end

  def do_number([val], string) do
    string = string <> get(String.to_integer(val))
    do_number([], string)
  end

  defp fetch_base(num_list, _) when is_list(num_list) do
    Map.get(base(), length(num_list))
  end

  defp num_check(list, val) when is_binary(val) do
    num_check(list, String.to_integer(val))
  end

  defp num_check(list, val),
    do: Map.get(list, val)
end
