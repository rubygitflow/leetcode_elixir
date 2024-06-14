# https://leetcode.com/problems/contains-duplicate/description/
# 217. Contains Duplicate

defmodule Solution do
  @spec contains_duplicate(nums :: [integer]) :: boolean
  def contains_duplicate(nums), do: do_contains_duplicate(nums, MapSet.new())

  defp do_contains_duplicate([num | tl], set) do
    if MapSet.member?(visited, num), do: true, else: do_contains_duplicate(tl, MapSet.put(visited, num))
  end
  defp do_contains_duplicate([], _), do: false

  @spec contains_duplicate_alt(nums :: [integer]) :: boolean
  def contains_duplicate_alt(nums) do
    # MapSet.size(MapSet.new(nums)) !== length(nums)
    # No need to interate through the entire list. We return a boolean at the first duplicate
    Enum.reduce_while(nums, MapSet.new(), fn num, visited ->
      if MapSet.member?(visited, num) do
        {:halt, true}
      else
        {:cont, MapSet.put(visited, num)}
      end
    end) == true
  end
end

IO.inspect(Solution.contains_duplicate([1,2,3,1]))
# Output: true
IO.inspect(Solution.contains_duplicate([1,2,3,4]))
# Output: false
IO.inspect(Solution.contains_duplicate([1,1,1,3,3,4,3,2,4,2]))
# Output: true

IO.inspect(Solution.contains_duplicate_alt([1,2,3,1]))
# Output: true
IO.inspect(Solution.contains_duplicate_alt([1,2,3,4]))
# Output: false
IO.inspect(Solution.contains_duplicate_alt([1,1,1,3,3,4,3,2,4,2]))
# Output: true
