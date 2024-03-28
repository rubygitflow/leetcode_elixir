# Matching strings up to letter permutation
# Дан текст T и строка S. Требуется найти подстроку S' в T такую, что она совпадает с S с точностью до перестановки букв.
# В качестве ответа стоит вернуть индекс первого вхождения, или -1, если такая подстрока S' не нашлась.
# ("reebok", "bee") -> 1

defmodule Solution do
  @spec match_substring(hoststring :: String.t, substring :: String.t) :: integer
  def match_substring(hoststring, substring) when length(hoststring) < length(substring), do: -1 
  def match_substring(hoststring, substring) do
    match_iter(
      0,
      String.length(hoststring) - String.length(substring),
      hoststring |> String.to_charlist(),
      substring |> String.to_charlist() |> Enum.sort()
    )
  end

  defp match_iter(from, to, _hoststring, _substring) when from > to, do: -1
  defp match_iter(from, to, hoststring, substring) do
    if ( hoststring 
         |> Enum.slice(from, length(substring))
         |> Enum.sort()
        ) == substring do
      from
    else
      match_iter(from+1, to, hoststring, substring)
    end
  end
end

# IMPORTANT!
# Utilize ""  instead of ''
"reebokee" |> Solution.match_substring("bee") |> IO.inspect()
# Output: 1
"colorados" |> Solution.match_substring("dosar") |> IO.inspect()
# Output: 4
"reebokee" |> Solution.match_substring("mee") |> IO.inspect()
# Output: -1
"mee" |> Solution.match_substring("reebokee") |> IO.inspect()
# Output: -1
