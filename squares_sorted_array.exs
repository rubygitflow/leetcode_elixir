# https://leetcode.com/problems/squares-of-a-sorted-array/description/
# 977. Squares of a Sorted Array

defmodule Solution do
  @spec sorted_squares(nums :: [integer]) :: [integer]
  def sorted_squares(nums) do
    do_sorted_squares(nums, Enum.reverse(nums), [], length(nums)-1)
  end

  defp do_sorted_squares(_, _, res, k) when k < 0, do: res
  defp do_sorted_squares([neg | neg_tail], [pos | pos_tail], res, k) do
    if abs(neg) > abs(pos) do
      do_sorted_squares(neg_tail, [pos | pos_tail], [neg*neg | res], k-1)
    else
      do_sorted_squares([neg | neg_tail], pos_tail, [pos*pos | res], k-1)
    end
  end

  @spec sorted_squares_ex(nums :: [integer]) :: [integer]
  def sorted_squares_ex(nums) do
    nums |> Enum.map(& &1*&1) |> Enum.sort()
  end
end

Solution.sorted_squares([-4,-1,0,3,10]) |> IO.inspect()
# Output: [0,1,9,16,100]
Solution.sorted_squares([-7,-3,2,3,11]) |> IO.inspect()
# Output: [4,9,9,49,121]

Solution.sorted_squares_ex([-4,-1,0,3,10]) |> IO.inspect()
# Output: [0,1,9,16,100]
Solution.sorted_squares_ex([-7,-3,2,3,11]) |> IO.inspect()
# Output: [4,9,9,49,121]
