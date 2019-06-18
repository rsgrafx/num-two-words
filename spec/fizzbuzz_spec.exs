defmodule FizzBuzz do
  def get(num) do
    # The code goes in the code hole
  end
end

defmodule FizzBuzzSpec do
  use ESpec

  describe "Fizz Buzz" do
    it do: expect(FizzBuzz.get(3)).to eq("fizz")
  end
end
