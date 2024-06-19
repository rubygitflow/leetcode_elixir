# https://leetcode.com/problems/count-and-say/description/
# 38. Count and Say
# https://en.wikipedia.org/wiki/Run-length_encoding
# Explanation: https://algo.monster/liteproblems/38


defmodule Solution do
  @spec count_and_say(n :: integer) :: String.t
  def count_and_say(1), do: "1"
  def count_and_say(n) do
    count_and_say(n - 1)
    |> String.split("", trim: true)
    |> Enum.chunk_by(&(&1))
    |> Enum.map(fn [ch | _] = chunk -> "#{Enum.count(chunk)}#{ch}" end)
    |> Enum.join
  end
end

IO.inspect(Solution.count_and_say(4))
# Output: "1211"
IO.inspect(Solution.count_and_say(1))
# Output: "1"
# IO.inspect(Solution.count_and_say(10))
# # Output: "13211311123113112211"
