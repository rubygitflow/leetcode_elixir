# https://leetcode.com/problems/count-primes/description/
# 204. Count Primes
# Explanation: https://algo.monster/liteproblems/204
# the Sieve of Eratosthenes algorithm

defmodule Solution do
  @spec count_primes(n :: integer) :: integer
  def count_primes(n) do
    {primes, _} = List.duplicate(true, n)
      |> Enum.reduce({Map.new(), 0}, fn x, {acc, i} -> {Map.put(acc, i, x), i+1} end)
    do_count_primes(primes, 0, n, 2)
  end

  defp do_count_primes(primes, out, n, i) when i < n do
    if Map.get(primes, i) do
      do_count_primes(do_primes(primes, n, i, i), out+1, n, i+1)
    else
      do_count_primes(primes, out, n, i+1)
    end
  end
  defp do_count_primes(_, out, _, _), do: out

  defp do_primes(primes, n, j, step) when j+step < n do
    do_primes(Map.put(primes, j+step, false), n, j+step, step)
  end
  defp do_primes(primes, _n, _j, _step), do: primes
end


IO.inspect(Solution.count_primes(10))
# Output: 4
IO.inspect(Solution.count_primes(0))
# Output: 0
IO.inspect(Solution.count_primes(1))
# Output: 0
