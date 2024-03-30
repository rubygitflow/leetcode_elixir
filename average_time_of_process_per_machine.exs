# https://leetcode.com/problems/average-waiting-time/description/
# 1701. Average Waiting Time

defmodule Solution do
  @spec average_waiting_time(customers :: [[integer]]) :: float
  def average_waiting_time(customers) when length(customers) < 1, do: 0.0 
  def average_waiting_time(customers) do
    next_step(customers) / length(customers)
  end
  defp next_step(customers, at_free_time \\ 0, output \\ 0)
  defp next_step([[at, wait] | tail], at_free_time, output) do
    ft = Enum.max([at_free_time, at]) + wait
    next_step(tail, ft, output + ft - at)
  end
  defp next_step([], _at_free_time, output), do: output
end

[[1,2],[2,5],[4,3]] |> Solution.average_waiting_time() |> IO.inspect()
# Output: 5.0
[[5,2],[5,4],[10,3],[20,1]]|> Solution.average_waiting_time() |> IO.inspect()
# Output: 3.25
