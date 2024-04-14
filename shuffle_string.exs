# https://leetcode.com/problems/shuffle-string/description/
# 1528. Shuffle String

defmodule Solution do
  @spec restore_string(s :: String.t, indices :: [integer]) :: String.t
  def restore_string(s, indices) do
    index_map = index_map(s, indices, %{})
    for x <- 0..map_size(index_map) - 1, reduce: <<>> do
      res -> <<res::bytes, index_map[x]>>
    end
  end

  defp index_map(<<f, rest::bytes>>, [hd | tl], map), do: index_map(rest, tl, Map.put(map, hd, f))
  defp index_map(_, _, map), do: map
end

Solution.restore_string("codeleet", [4,5,6,7,0,2,1,3]) |> IO.inspect()
# Output: "leetcode"
Solution.restore_string("abc", [0,1,2]) |> IO.inspect()
# Output: "abc"
