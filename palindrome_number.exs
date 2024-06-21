# https://leetcode.com/problems/palindrome-number/description/
# 9. Palindrome Number

defmodule Solution do
  @spec is_palindrome(x :: integer) :: boolean
  def is_palindrome(x) when x < 0, do: false
  def is_palindrome(x) do
    cond do
      Integer.mod(x, 10) == 0 -> false
      true -> 
        {x, y} = while(x, 0)
        (x == y) || (x == Integer.floor_div(y, 10))
    end
  end

  defp while(x, y) when y >= x, do: {x, y}
  defp while(x, y), do: while(Integer.floor_div(x, 10), y * 10 + Integer.mod(x, 10))
end


IO.inspect(Solution.is_palindrome(-121))
# Output: false
IO.inspect(Solution.is_palindrome(121))
# Output: true
IO.inspect(Solution.is_palindrome(123435))
# Output: false
IO.inspect(Solution.is_palindrome(73537))
# Output: true
IO.inspect(Solution.is_palindrome(900))
# Output: false
IO.inspect(Solution.is_palindrome(-123435))
# Output: false
IO.inspect(Solution.is_palindrome(994499))
# Output: true
