# https://leetcode.com/problems/4sum/description/
# 18. 4Sum

defmodule Solution do
  @spec four_sum(nums :: [integer], target :: integer) :: [[integer]]
  def four_sum(nums, target) do
    nums
    |> Enum.sort()
    |> k_sum(target, 4)
  end

  defp k_sum(_nums, _target, k) when k < 1, do: []
  defp k_sum(nums, target, 1) do
    [Enum.find_value(nums, fn x ->
      if x == target, do: x
    end)]
  end
  defp k_sum(nums, _target, k) when length(nums) < k, do: []
  defp k_sum(nums, target, 2), do: two_sum(nums, target)
  defp k_sum(nums, target, k) do
    nums
    |> Enum.with_index()
    |> Enum.reduce(MapSet.new(), fn {n, i}, acc_map_set -> 
        results = 
          # запускаем рекурсию для
          # отсекаем хвост массива, изменяем остаточную сумму на текущее значение, изменяем мерность слагаемых
          k_sum(Enum.drop(nums, i + 1), target - n, k - 1)
          # результаты объединяем с текущим числом и помещаем во множество
          |> Enum.into(MapSet.new(), fn result -> [n | result]end)
        # объединяем все итерации
        MapSet.union(acc_map_set, results)
    end)
    # конвертируем все множества в списки
    |> MapSet.to_list()
  end

  defp two_sum(nums, _target) when length(nums) < 2, do: []
  defp two_sum(nums, target) do
    Enum.reduce(nums, {MapSet.new(), MapSet.new()}, fn n, {visited, results} -> 
      new_results = 
        if (MapSet.member?(visited, target - n)) do
          MapSet.put(results, [min(n, target - n), max(n, target - n)])
        else
          results
        end
      new_visited = MapSet.put(visited, n)
      {new_visited, new_results}
    end)
    |> elem(1)
    |> MapSet.to_list()
  end
end

[1,0,-1,0,-2,2] |> Solution.four_sum(0) |> IO.inspect()
# Output: [[-2,-1,1,2],[-2,0,0,2],[-1,0,0,1]]
[2,2,2,2,2] |> Solution.four_sum(8) |> IO.inspect()
# Output: [[2,2,2,2]]
[2,2,2,2,2] |> Solution.four_sum(9) |> IO.inspect()
# Output: [[]]
