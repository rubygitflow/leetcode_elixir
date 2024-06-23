# https://leetcode.com/problems/array-transformation/description/
# 1243. Array Transformation


defmodule Solution do
  @spec transform_array(arr :: [integer]) :: [integer]
  def transform_array(arr) do
    if length(arr)<3 do
      arr
    else
      while_transformable(arr, true)
    end
  end

  defp while_transformable(arr, loop) when loop do
    do_transform_array([hd(arr)], tl(arr) , false, 1,length(arr)-2, Enum.chunk_every(arr, 3, 1, :discard))
  end
  defp while_transformable(arr, _), do: arr

  defp do_transform_array(out, [head| tail], loop, i, last, [h | t]) do
    {l, m, r} = List.to_tuple(h)
    {transformable, elem} = cond do
      m > l && m > r -> {true, head - 1}
      m < l && m < r -> {true, head + 1}
      true           -> {false, head}
    end
    if i == last do
      while_transformable(Enum.reverse([r | [elem | out]]), loop || transformable )
    else
      do_transform_array([elem | out], tail, loop || transformable, i+1, last, t)
    end
  end
end

IO.inspect(Solution.transform_array([6,2,3,4]))
# Output: [6,3,3,4]
IO.inspect(Solution.transform_array([1,6,3,4,3,5]))
# Output: [1,4,4,4,4,5]
IO.inspect(Solution.transform_array([1,5]))
# Output: [1,5]
