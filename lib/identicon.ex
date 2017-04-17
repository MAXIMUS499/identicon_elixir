defmodule Identicon do
  def main(input) do
    input
    |> hash_input
    |> pick_color
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
