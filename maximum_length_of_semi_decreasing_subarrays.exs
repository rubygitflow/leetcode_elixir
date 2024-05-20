# https://leetcode.com/problems/maximum-length-of-semi-decreasing-subarrays/description/
# 2863. Maximum Length of Semi-Decreasing Subarrays

defmodule Solution do
  @spec max_subarray_length_dec(edges :: [integer]) :: integer
  def max_subarray_length_dec(nums) do
    d =
      Enum.with_index(nums) |> Enum.reduce(Map.new(), fn {x, i}, acc ->
        Map.update(acc, x, [i], &[i | &1])
      end)
    {ans, _} = d
      |> Map.keys()
      |> Enum.sort(&(&1 >= &2))
      |> Enum.reduce({0, 10 ** 12}, fn x, {ans, k} ->
        {
          Enum.max([ans, hd(Map.get(d, x)) - k + 1]),
          Enum.min([k,   List.last(Map.get(d, x))               ])
        }
      end)
    ans
  end

  @spec max_subarray_length_inc(edges :: [integer]) :: integer
  def max_subarray_length_inc(nums) do
    d =
      Enum.with_index(nums) |> Enum.reduce(Map.new(), fn {x, i}, acc ->
        Map.update(acc, x, [i], &[i | &1])
      end)
    {ans, _} = d
      |> Map.keys()
      |> Enum.sort()
      |> Enum.reduce({0, 10 ** 12}, fn x, {ans, k} ->
        {
          Enum.max([ans, hd(Map.get(d, x)) - k + 1]),
          Enum.min([k,   List.last(Map.get(d, x))               ])
        }
      end)
    ans
  end
end

IO.inspect("Semi-Decreasing Subarrays")
Solution.max_subarray_length_dec([7,6,5,4,3,2,1,6,10,11]) |> IO.inspect()
# Output: 8
Solution.max_subarray_length_dec([57,55,50,60,61,58,63,59,64,60,63]) |> IO.inspect()
# Output: 6
Solution.max_subarray_length_dec([57,55,50,60,61,58,63,59,64,58,63]) |> IO.inspect()
# Output: 7
Solution.max_subarray_length_dec([1,2,3,4]) |> IO.inspect()
# Output: 0
Solution.max_subarray_length_dec([10,12,12,11,11]) |> IO.inspect()
# Output: 4

IO.inspect("Semi-Increasing Subarrays")
Solution.max_subarray_length_inc([11,10,6,1,2,3,4,5,6,7]) |> IO.inspect()
# Output: 8
Solution.max_subarray_length_inc([63,59,64,60,63,55,57,50,60,61,58]) |> IO.inspect()
# Output: 9
Solution.max_subarray_length_inc([57,55,50,60,61,58,63,59,64,58,63]) |> IO.inspect()
# Output: 11
Solution.max_subarray_length_inc([1,2,3,4]) |> IO.inspect()
# Output: 4
Solution.max_subarray_length_inc([101,92,53,4]) |> IO.inspect()
# Output: 0
Solution.max_subarray_length_inc([11,11,12,12,10]) |> IO.inspect()
# Output: 4
