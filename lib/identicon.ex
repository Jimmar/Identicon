defmodule Identicon do

  def main do
    main("asdf")
  end
  
  def main(input) do
    input
    |> hash_data
    |> pick_color
    |> build_grid
    |> build_pixel_map
    |> draw_image
    |> save_image(input)
  end
  
  def hash_data(data) do
     hash = 
       :crypto.hash(:md5, data) 
       |> :binary.bin_to_list 
       %Identicon.Image{hash: hash}
  end
  
  def pick_color(%Identicon.Image{hash: [r,g,b | _tail]} =  image) do
    %Identicon.Image{image | color: {r,g,b}}
  end
  
  def build_grid(%Identicon.Image{hash: hash} =  image) do
    grid = 
      hash
      |> Enum.chunk_every(3,3,:discard)
      |> Enum.map(&mirror_row/1)
      |> List.flatten
      |> Enum.map (fn(x) -> rem(x, 2) == 0 end)
      
    %Identicon.Image{image | grid: grid}
  end
  
  def build_pixel_map(%Identicon.Image{grid: grid} =  image) do
     pixel_map = 
       grid 
       |> Enum.with_index 
       |> Enum.filter(fn({value, _index}) -> value end)
       |> Enum.map fn({_value, index}) -> 
         {h, v} = {rem(index,5) * 50, div(index, 5) * 50}
         top_left = {25+h,25+v}
         bottom_right = {25+h+50, 25+v+50}
         
         {top_left, bottom_right}
        end
        
      %Identicon.Image{image | pixel_map: pixel_map}
  end
  
  def draw_image(%Identicon.Image{pixel_map: pixel_map, color: color}) do
    image = :egd.create(300,300)
    color = :egd.color(color)
    
    pixel_map
    |> Enum.each fn({start,stop}) ->
       :egd.filledRectangle(image,start, stop, color) 
     end
     
     :egd.render(image)
  end
  
  def save_image(image, file_name) do
    File.write("#{file_name}.png", image)
  end
  
  def mirror_row(row) do
    [a,b,c] = row
    [a,b,c,b,a]
  end
end

