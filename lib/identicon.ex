defmodule Identicon do
  def main(input) do
    input
    |> hash_input
    |> pick_color
    |> build_grid
  end

  def build_grid(%Identicon.Image{hex: hex} = image) do
    grid = 
      hex
      |> Enum.chunk(3)
      |> Enum.map(&mirror_row/1)
      |> List.flatten
      |> Enum.with_index  # we need indexes of the list's values
    
    %Identicon.Image{image | grid: grid}
  end

#mirror_row - it is a helper function
  def mirror_row(row) do
    # [145, 46, 200]
    [first, second | _tail] = row

    # [145, 46, 200, 46, 145]
    row ++ [second, first]
  end

  def pick_color(%Identicon.Image{hex: [r, g, b | _tail]} = image) do
    
    #[r, g, b | _tail] = hex_list #it says: give me the first 3 values and then I acknoledge that hex_list
    # has many others values inside of it

    %Identicon.Image{image | color: {r, g, b}}
    
  end

  def hash_input(input) do
    hex = :crypto.hash(:md5, input)
    |> :binary.bin_to_list

    %Identicon.Image{hex: hex}
  end
end
