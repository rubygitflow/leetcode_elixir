# https://leetcode.com/problems/top-k-frequent-words/description/
# 692. Top K Frequent Words

defmodule Solution do
  @spec top_k_frequent_words(words :: [String.t], k :: integer) :: [String.t]
  def top_k_frequent_words(words, k) do
    words 
    |> Enum.frequencies() 
    |> Enum.sort_by(fn {word, count} -> {-count, word} end) 
    |> Enum.take(k)
    |> Enum.map(fn {word, _} -> word end)
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
