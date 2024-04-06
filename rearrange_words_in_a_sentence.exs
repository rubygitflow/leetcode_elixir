# https://leetcode.com/problems/rearrange-words-in-a-sentence/description/
# 1451. Rearrange Words in a Sentence

defmodule Solution do
  @spec arrange_words(text :: String.t) :: String.t
  def arrange_words(text) do
    text
    |> String.split(" ")
    |> Enum.sort_by(&String.length/1)
    |> Enum.join(" ")
    |> String.capitalize()
  end
end

"Leetcode is cool" |> Solution.arrange_words() |> IO.inspect()
# Output: "Is cool leetcode"
"Keep calm and code on" |> Solution.arrange_words() |> IO.inspect()
# Output: "On and keep calm code"
"To be or not to be" |> Solution.arrange_words() |> IO.inspect()
# Output: "To be or to be not"
