# https://leetcode.com/problems/is-object-empty/description/
# 2727. Is Object Empty

defmodule Solution do
  def is_empty(obj) do
    cond do
      is_float(obj)     -> false
      is_number(obj)    -> false
      is_boolean(obj)   -> false
      is_bitstring(obj) -> String.length(obj) == 0
      is_map(obj)       -> is_enum_empty(obj)
      is_list(obj)      -> is_enum_empty(obj)
      is_tuple(obj)     -> is_enum_empty(obj)
      true           -> true
    end    
  end

  defp is_enum_empty(obj) do
    if Enum.any?(obj, fn _ -> true end) do
      false
    else
      true
    end
  end
end

Solution.is_empty(%{"x" => 5, "y" => 42}) |> IO.inspect()
# Output: false
Solution.is_empty(%{}) |> IO.inspect()
# Output: true
Solution.is_empty([nil, false, 0]) |> IO.inspect()
# Output: false
Solution.is_empty([]) |> IO.inspect()
# Output: true
Solution.is_empty("wer") |> IO.inspect()
# Output: false
Solution.is_empty("") |> IO.inspect()
# Output: true
Solution.is_empty(4.9) |> IO.inspect()
# Output: false
Solution.is_empty(None) |> IO.inspect()
# Output: true
Solution.is_empty([nil, false]) |> IO.inspect()
# Output: false

Solution.is_empty(Range.to_list(1..10//2)) |> IO.inspect()
# Output: false
Solution.is_empty(Range.to_list(0..-1//1)) |> IO.inspect() # empty range
# Output: true

Solution.is_empty(MapSet.new([1, :two, {"three"}])) |> IO.inspect()
# Output: false
Solution.is_empty(MapSet.new()) |> IO.inspect()
# Output: true
