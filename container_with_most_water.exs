# https://leetcode.com/problems/container-with-most-water/description/
# 11. Container With Most Water


########################
# https://leetcode.com/problems/trapping-rain-water/description/
# 42. Trapping Rain Water


defmodule Solution do
  @spec max_area(height :: [integer]) :: integer
  def max_area(height) do
    do_max_area(0, length(height) - 1, List.to_tuple(height), 0)
  end

  defp do_max_area(l,r,_, out) when l>=r, do: out
  defp do_max_area(l,r,height, out) do
    lh = elem(height, l)
    rh = elem(height, r)
    out = max(out, min(lh, rh) * (r - l))
    if lh < rh do
      do_max_area(l+1,r,height, out)
    else
      do_max_area(l,r-1,height, out)
    end
  end

  @spec trap(height :: [integer]) :: integer
  def trap(height) do
    do_trap(0, length(height) - 1, List.to_tuple(height), 0, 0, 0)
  end
  defp do_trap(l,r,_, total_water, _, _) when l>=r, do: total_water
  defp do_trap(l,r,height, total_water, l_max, r_max) do
    lh = elem(height, l)
    rh = elem(height, r)
    if lh <= rh do
      do_trap(l+1,r,height,
              if(lh <  l_max, do: total_water + l_max - lh, else: total_water),
              if(lh >= l_max, do: lh, else: l_max),
              r_max)
    else
      do_trap(l,r-1,height,
              if(rh <  r_max, do: total_water + r_max - rh, else: total_water),
              l_max,
              if(rh >= r_max, do: rh, else: r_max))
    end
  end
end

IO.inspect("Container With Most Water")
IO.inspect(Solution.max_area([1,8,6,2,5,4,8,3,7]))
# Output: 49
IO.inspect(Solution.max_area([1,1]))
# Output: 1

IO.inspect("Trapping Rain Water")
IO.inspect(Solution.trap([0,1,0,2,1,0,1,3,2,1,2,1]))
# Output: 6
IO.inspect(Solution.trap([4,2,0,3,2,5]))
# Output: 9
