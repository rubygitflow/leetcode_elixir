# https://leetcode.com/problems/check-if-move-is-legal/
# 1958. Check if Move is Legal

defmodule Solution do
  @spec check_move(board :: [[char]], r_move :: integer, c_move :: integer, color :: char) :: boolean
  def check_move(board, r_move, c_move, color) do
    IO.inspect("color: #{color}")
    # Enum.each(board, &IO.puts/1)
    Enum.each(board, &IO.inspect/1)

    do_check_move(
      [{0, 1}, {0, -1}, {1, 0}, {-1, 0}, {1, 1}, {-1, -1}, {1, -1}, {-1, 1}],
      board |> List.flatten |> List.to_tuple,
      r_move,
      c_move,
      color,
      length(board),
      length(hd(board))
    )
  end

  defp do_check_move([], _matrix, _r_move, _c_move, _color, _m, _n), do: false
  defp do_check_move([{dr, dc}| t], matrix, r_move, c_move, color, m, n) do
    if take_while(matrix,r_move+dr,c_move + dc,2,dr,dc,m,n,color) do
      true
    else
      do_check_move(t, matrix, r_move, c_move, color, m, n)
    end
  end

  defp take_while(matrix,i,j,size,dr,dc,m,n,color) when i >= 0 and i < m and j >= 0 and j < n do
    el = elem(matrix,i*m+j)
    cond do
      el == "." || size < 3 && el == color ->
        false
      el == color ->
        true
      true ->
        take_while(matrix,i+dr,j+dc,size+1,dr,dc,m,n,color)
    end
  end
  defp take_while(_matrix,_i,_j,_size,_dr,_dc,_m,_n,_color), do: false
end

{board, r_move, c_move, color} = {[[".",".",".","B",".",".",".","."],[".",".",".","W",".",".",".","."],[".",".",".","W",".",".",".","."],[".",".",".","W",".",".",".","."],["W","B","B",".","W","W","W","B"],[".",".",".","B",".",".",".","."],[".",".",".","B",".",".",".","."],[".",".",".","W",".",".",".","."]], 4, 3, "B"}
IO.inspect(Solution.check_move(board, r_move, c_move, color))
# Output: true
{board, r_move, c_move, color} = {[[".",".",".",".",".",".",".","."],[".","B",".",".","W",".",".","."],[".",".","W",".",".",".",".","."],[".",".",".","W","B",".",".","."],[".",".",".",".",".",".",".","."],[".",".",".",".","B","W",".","."],[".",".",".",".",".",".","W","."],[".",".",".",".",".",".",".","B"]], 4, 4, "W"}
IO.inspect(Solution.check_move(board, r_move, c_move, color))
# Output: false
