# https://leetcode.com/problems/greatest-english-letter-in-upper-and-lower-case/description/
# 2309. Greatest English Letter in Upper and Lower Case

defmodule Solution do
  @spec greatest_letter(s :: String.t) :: String.t
  def greatest_letter(s) do
    s
    # |> String.to_charlist() # ** (FunctionClauseError) no function clause matching in String.upcase/2
    |> String.codepoints()
    |> Enum.reduce({%{}, %MapSet{}, ""}, fn c, {map, set, ans} ->
      if !MapSet.member?(set, c) do
        set = MapSet.put(set, c)
        upper = String.upcase(c)
        # we have caught a changed character case if the character already exists
        map = Map.put(map, upper, Map.get(map, upper, 0) + 1)
        # processing an additional condition
        ans = if Map.get(map, upper) == 2, do: max(upper, ans), else: ans
        # update the accumulator
        {map, set, ans}
      else 
        # skip the same case !!!
        {map, set, ans}
      end
    end)
    # take the answer 
    |> elem(2)    
  end
end

IO.inspect(Solution.greatest_letter("l Ee TcOd E "))
# Output: "E"
IO.inspect(Solution.greatest_letter("a rR AzFif"))
# Output: "R"
IO.inspect(Solution.greatest_letter("a rr AzFifA"))
# Output: "F"
IO.inspect(Solution.greatest_letter("AbCdEfGhIjK"))
# Output: ""
IO.inspect(Solution.greatest_letter("a рр AzФiфA"))
# Output: "Ф"

