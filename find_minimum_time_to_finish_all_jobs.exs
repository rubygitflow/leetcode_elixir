# https://leetcode.com/problems/find-minimum-time-to-finish-all-jobs/description/
# 1723. Find Minimum Time to Finish All Jobs

defmodule Solution do
  @spec minimum_time_required(jobs :: [integer], k :: integer) :: integer
  def minimum_time_required(_jobs, k) when k < 1, do: 0

  def minimum_time_required(jobs, k) do
    x = Enum.sort(jobs, &(&1 >= &2))
    avg = Enum.sum(jobs) / k |> Float.ceil()
    do_iterate(x, k, avg, 0)
  end

  defp do_iterate(x, k, avg, sum) when k < 1 do
    Enum.max([sum + Enum.sum(x), avg])
  end

  defp do_iterate(x, k, avg, _sum) do
    excluded = Enum.reduce_while(x, [], fn num, acc ->
      s = Enum.sum(acc)
      cond do
        s + num == avg -> {:halt, acc ++ [num]}
        s + num < avg  -> {:cont, acc ++ [num]}
        true           -> {:cont, acc}
      end
    end)
    s = Enum.sum(excluded)
    do_iterate(x -- excluded, k - 1, Enum.max([s, avg]), s)
  end
end

[3,2,3] |> Solution.minimum_time_required(3) |> IO.inspect()
# Output: 3
[1,2,4,7,8] |> Solution.minimum_time_required(2) |> IO.inspect()
# Output: 11
[4,7,8] |> Solution.minimum_time_required(2) |> IO.inspect()
# Output: 11
[24,17,28] |> Solution.minimum_time_required(2) |> IO.inspect()
# Output: 41
