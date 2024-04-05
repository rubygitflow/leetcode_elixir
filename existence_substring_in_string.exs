# https://leetcode.com/problems/existence-of-a-substring-in-a-string-and-its-reverse/description/
# 3083. Existence of a Substring in a String and Its Reverse

defmodule Solution do
  @spec is_substring_present(s :: String.t) :: boolean
  def is_substring_present(s) do
    is_substring(s, String.reverse(s))
  end

  @spec is_substring(s :: String.t, rev :: String.t) :: boolean
  def is_substring(s, rev) do
    l = String.length(rev)
    cond do
      l <= 1 ->
        false
      String.contains?(s, String.slice(rev, 0, 2)) ->
        true
      true ->
        is_substring(s, String.slice(rev, 1..l))
    end    
  end
end

"leetcode" |> Solution.is_substring_present() |> IO.inspect()
# Output: true
"abcba" |> Solution.is_substring_present() |> IO.inspect()
# Output: true
"abcd" |> Solution.is_substring_present() |> IO.inspect()
# Output: false
