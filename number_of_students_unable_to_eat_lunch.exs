# https://leetcode.com/problems/number-of-students-unable-to-eat-lunch/description/
# 1700. Number of Students Unable to Eat Lunch

defmodule Solution do
  @spec count_students(students :: [integer], sandwiches :: [integer]) :: integer
  def count_students(students, sandwiches) do
    do_count_students(sandwiches, Enum.frequencies(students))
  end

  defp do_count_students([type | tl], cnt) do
    case cnt[type] do
      nil -> Map.values(cnt) |> hd
      1 -> do_count_students(tl, Map.delete(cnt, type))
      x -> do_count_students(tl, Map.put(cnt, type, x - 1))
    end
  end
  defp do_count_students(_, _), do: 0
end

[1,1,0,0] |> Solution.count_students([0,1,0,1]) |> IO.inspect()
# Output: 0 
[1,1,1,0,0,1] |> Solution.count_students([1,0,0,0,1,1]) |> IO.inspect()
# Output: 3
[0,0,0,1,1,0] |> Solution.count_students([1,0,0,0,1,1]) |> IO.inspect()
# Output: 1
[0,0,0,1,1,0] |> Solution.count_students([0,1,1,1,0,0]) |> IO.inspect()
# Output: 3
