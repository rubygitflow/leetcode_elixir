# https://leetcode.com/problems/number-of-times-binary-string-is-prefix-aligned/description/
# 1375. Number of Times Binary String Is Prefix-Aligned

defmodule Solution do
  @spec num_times_all_blue(flips :: [integer]) :: integer
  def num_times_all_blue(flips) do
    iterate(flips, 0, 0, 0)
  end

  defp iterate([], _left, _right, output), do: output
  defp iterate([head | tail], left, right, output) do
    # we store only the right value of the passed range
    right = Enum.max([right, head])
    # True counter for the left-th step
    out = if right == left + 1 do
      output + 1
    else
      output
    end
    iterate(tail, left + 1, right, out)
  end
end

Solution.num_times_all_blue([3,2,4,1,5]) |> IO.inspect()
# Output: 2
Solution.num_times_all_blue([4,1,2,3]) |> IO.inspect()
# Output: 1
