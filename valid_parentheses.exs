# https://leetcode.com/problems/valid-parentheses/description/
# 20. Valid Parentheses

defmodule Solution do
  @pairs %{?( => ?), ?[ => ?], ?{ => ?}} 
  @spec is_valid(s :: String.t) :: boolean
  def is_valid(s) do
    do_is_valid(s, [])
  end

  defp do_is_valid(<<bracket, rest::bytes>>, stack) do
    # IO.inspect({bracket, rest, stack, Map.has_key?(@pairs, bracket), @pairs})
    cond do
      Map.has_key?(@pairs, bracket)         -> do_is_valid(rest, [bracket | stack])
      length(stack) == 0                    -> false
      bracket != Map.get(@pairs, hd(stack)) -> false
      true                                  -> do_is_valid(rest, tl(stack))
    end
  end
  defp do_is_valid(<<>>, stack), do:  length(stack) == 0
end

IO.inspect(Solution.is_valid("()[]{}"))
# Output: true
IO.inspect(Solution.is_valid("(]"))
# Output: false
IO.inspect(Solution.is_valid("([][])[]{}"))
# Output: true
