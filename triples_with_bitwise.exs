# https://leetcode.com/problems/triples-with-bitwise-and-equal-to-zero/description/
# 982. Triples with Bitwise AND Equal To Zero

import Bitwise

defmodule Solution do
  @spec count_triplets(nums :: [integer]) :: integer
  def count_triplets(nums) do
    cnt = for x <- nums, reduce: %{} do
      acc_x -> 
        for y <- nums, reduce: acc_x do
          acc_y -> Map.update(acc_y, (x &&& y), 1, & &1 + 1)
        end
    end
    for {xy, v} <- cnt, reduce: 0 do
      acc -> 
        for z <- nums, reduce: acc do
          acc_z ->
            if (xy &&& z) == 0, do: acc_z + v, else: acc_z
        end
    end
  end
end

Solution.count_triplets([2,1,3]) |> IO.inspect()
# Output: 12
Solution.count_triplets([0,0,0]) |> IO.inspect()
# Output: 27
