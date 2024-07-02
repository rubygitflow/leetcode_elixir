# https://leetcode.com/problems/top-k-frequent-words/description/
# 692. Top K Frequent Words

defmodule Solution do
  @spec top_k_frequent_words(words :: [String.t], k :: integer) :: [String.t]
  def top_k_frequent_words(words, k) do
    words
    |> Enum.frequencies()
    |> Enum.sort_by(fn {word, count} -> {-count, word} end)
    |> Enum.take(if k == 0, do: length(words), else: abs(k))
    |> Enum.map(fn {word, _} -> word end)
  end

  @spec top_k_frequent_elements(nums :: [integer], k :: integer) :: [integer]
  def top_k_frequent_elements(nums, k) do
    nums
    |> Enum.frequencies()
    |> Enum.sort(fn {ka, va}, {kb, vb} -> if(va == vb, do: ka < kb, else: vb < va) end)
    |> Enum.take(if k == 0, do: length(nums), else: abs(k))
    |> Enum.map(&elem(&1, 0))
  end
end

IO.inspect("Top K Frequent Words")
IO.inspect(Solution.top_k_frequent_words(["i","love","leetcode","i","love","coding"], 2))
# Output: ["i","love"]
IO.inspect(Solution.top_k_frequent_words(["the","day","is","sunny","the","the","the","sunny","is","is"], 4))
# Output: ["the","is","sunny","day"]
IO.inspect(Solution.top_k_frequent_words(["the","the","the","day","sunny","sunny","is","is","is"], 2))
# Output: ["is", "the"]
IO.inspect(Solution.top_k_frequent_words(["the","the","the","day","sunny","sunny","is","is","is"], 6))
# Output: ["is", "the", "sunny", "day"]


IO.inspect("Top K Frequent Elements")
IO.inspect(Solution.top_k_frequent_elements([1,1,1,2,2,3], 2))
# Output: [1,2]
IO.inspect(Solution.top_k_frequent_elements([1], 1))
# Output: [1]
IO.inspect(Solution.top_k_frequent_elements([10,11,13,25,22,30,42,10], 2))
# Output: [10, 11]
IO.inspect(Solution.top_k_frequent_elements([10,11,13,25,22,30,42,10], 3))
# Output: [10, 11, 13]
IO.inspect(Solution.top_k_frequent_elements([10,11,13,25,22,30,42,10], 0))
# Output: [10, 11, 13, 22, 25, 30, 42]
IO.inspect(Solution.top_k_frequent_elements([10,11,13,25,22,30,42,10], -2))
# Output: [10, 11]
IO.inspect(Solution.top_k_frequent_elements([1,1,1,2,2,3,0,0,0,5,5,5], 2))
# Output: [0, 1]
IO.inspect(Solution.top_k_frequent_elements([1,1,1,2,2,3,5,5,5,0,0,0], 2))
# Output: [0, 1]
