# https://leetcode.com/problems/maximum-binary-string-after-change/description/
# 1702. Maximum Binary String After Change

# You can apply each of the following operations any number of times:
# Operation 1: If the number contains the substring "00", you can replace it with "10".
# For example, "00010" -> "10010"
# Operation 2: If the number contains the substring "10", you can replace it with "01".
# For example, "00010" -> "00001"

defmodule Solution do
  @spec maximum_binary_string(binary :: String.t) :: String.t
  def maximum_binary_string(binary) do
    l = String.length(binary)
    binary_as_list = binary |> String.graphemes()
    c_first_ones = Enum.find_index(binary_as_list, &(&1 == "0")) || l
    c_zeros = Enum.count(binary_as_list, &(&1 == "0")) || 0
    # The solution formula
    String.duplicate("1", c_first_ones) <>
    String.duplicate("1", (if c_zeros>0, do: c_zeros - 1, else: 0)) <>
    String.duplicate("0", (if c_zeros>0, do: 1, else: 0)) <>
    String.duplicate("1", l-c_first_ones-c_zeros)
  end
end

"000110" |> Solution.maximum_binary_string() |> IO.inspect()
# Output: "111011"
"01" |> Solution.maximum_binary_string() |> IO.inspect()
# Output: "01"
"1101011" |> Solution.maximum_binary_string() |> IO.inspect()
# Output: "1111011"
"0000" |> Solution.maximum_binary_string() |> IO.inspect()
# Output: "1110"
"1111" |> Solution.maximum_binary_string() |> IO.inspect()
# Output: "1111"
