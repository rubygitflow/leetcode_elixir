# https://leetcode.com/problems/corporate-flight-bookings/description/
# 1109. Corporate Flight Bookings

defmodule Solution do
  @spec corp_flight_bookings(bookings :: [[integer]], n :: integer) :: [integer]
  def corp_flight_bookings(bookings, n) do
    acc = for d <- 1..n, reduce: %{ 1 => 0 } do
      acc -> Map.put(acc, d, 0)
    end
    iterate_bookings(bookings, acc)
  end

  defp iterate_bookings([], acc), do: Map.values(acc)
  defp iterate_bookings([ [first, last, seats] | tail], acc) do
    acc = for i <- first..last, reduce: acc do
      acc -> Map.update(acc, i, 0, &(&1 + seats))
    end
    iterate_bookings(tail, acc)
  end

  def corp_flight_bookings_ex(bookings, n) do
    mp =
      bookings
      |> Enum.reduce(%{}, fn [first, last, seats], mp ->
        mp
        |> Map.update(first, seats, &(&1 + seats))
        |> Map.update(last + 1, -seats, &(&1 - seats))
      end)
    1..n
    |> Enum.reduce([], fn x, acc ->
      [(acc |> List.first(0)) + (mp |> Map.get(x, 0)) | acc]
    end)
    |> Enum.reverse()
  end
end

[[1,2,10],[2,3,20],[2,5,25]] |> Solution.corp_flight_bookings(5) |> IO.inspect()
# Output: [10,55,45,25,25]
[[1,2,10],[2,2,15]] |> Solution.corp_flight_bookings(2) |> IO.inspect()
# Output: [10,25]

[[1,2,10],[2,3,20],[2,5,25]] |> Solution.corp_flight_bookings_ex(5) |> IO.inspect()
# Output: [10,55,45,25,25]
[[1,2,10],[2,2,15]] |> Solution.corp_flight_bookings_ex(2) |> IO.inspect()
# Output: [10,25]
