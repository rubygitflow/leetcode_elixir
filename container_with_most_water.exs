# https://leetcode.com/problems/container-with-most-water/description/
# 11. Container With Most Water

defmodule Solution do
  @spec max_area(height :: [integer]) :: integer
  def max_area(height) do
    do_max_area(0, length(height) - 1, List.to_tuple(height), 0)
  end

  defp do_max_area(l,r,height, out) when l>=r, do: max_area
  defp do_max_area(l,r,height, max_area) do
    out = max(out, min(elem(height, l), elem(height, r)) * (r - l))
    if height[l] < height[r] do
      do_max_area(l+1,r,height, out)
    else
      do_max_area(l,r-1,height, out)
    end
  end
end

IO.inspect("Container With Most Water")
IO.inspect(max_area([1,8,6,2,5,4,8,3,7]))
# Output: 49
IO.inspect(max_area([1,1]))
# Output: 1
