# https://leetcode.com/problems/advantage-shuffle/description/
# 870. Advantage Shuffle

defmodule Solution do
  # @spec advantage_count(nums1 :: [integer], nums2 :: [integer]) :: [integer]
  def advantage_count(nums1, nums2) when length(nums1) != length(nums2), do: []

  def advantage_count(nums1, nums2) do
    n = length(nums1)
    t = Enum.with_index(nums2) |> Enum.sort()
    do_iterate(
      Enum.with_index(
        List.duplicate(0, n)
      ) |> Map.new(fn {v, k} -> {k, v} end),
      0,
      n - 1,
      Enum.sort(nums1),
      Enum.with_index(t) |> Map.new(fn {v, k} -> {k, v} end)
    ) |> Map.values()
  end

  defp do_iterate(out, l, r, _nums, _src) when l > r, do: out

  defp do_iterate(out, l, r, [h | tail], src) do
    {v, _li} = src[l]
    {idx, ll, rr} = do_switch(h, v, l, r, src)
    do_iterate(
       Map.merge(out, %{idx => h}),
      ll,
      rr,
      tail,
      src
    )
  end

  defp do_switch(u, v, l, r, src) when u <= v do
    {_w, rj} = src[r]
    {rj, l, r-1}
  end

  defp do_switch(_u, _v, l, r, src) do
    {_v, li} = src[l]
    {li, l+1, r}
  end
end

[2,7,11,15] |> Solution.advantage_count([1,10,4,11]) |> IO.inspect()
# Output: [2,11,7,15]
[12,24,8,32] |> Solution.advantage_count([13,25,32,11]) |> IO.inspect()
# Output: [24,32,8,12]
[12,24,8] |> Solution.advantage_count([13,25,32,11]) |> IO.inspect()
# Output: []
