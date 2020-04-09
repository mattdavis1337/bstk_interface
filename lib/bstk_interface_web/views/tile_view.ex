defmodule BstkInterfaceWeb.TileView do
  use BstkInterfaceWeb, :view
  alias BstkInterfaceWeb.TileView
  alias BstkInterfaceWeb.TileImage


  def render("index.json", %{tiles: tiles}) do
    IO.puts("In TileView render(index.json)");
    IO.inspect(tiles)
    #res = Enum.map(tiles, fn x -> x.tile_hash end)
    IO.inspect(tiles)
    #
    #IO.inspect(res)
    #res




    #IO.inspect(Map.from_struct(tiles))
    v1 = %{
      "aIzej_Uvs2RJlLDG" => %Bstk.TileNew{
        placement: nil,
        tile_hash: "aIzej_Uvs2RJlLDG",
        type: :sticker
      },
      "bai3dIdlFfm7G34Q" => %Bstk.TileNew{
        placement: nil,
        tile_hash: "bai3dIdlFfm7G34Q",
        type: :sticker
      }
    }
    Enum.into(Enum.map(tiles, fn {a, b} -> {a, Map.from_struct(b)} end ), %{})
  end

  def render("show.json", %{tile: tile}) do
    IO.puts("In TileView render(show.json)");
    %{data: render_one(tile, TileView, "tile.json")}
  end

  def render("tile.json", %{tile: {_hash, %Bstk.TileNew{tile_hash: tile_hash, type: type, placement: placement}}}) do
    IO.puts("In TileView render(tile.json)");
    %{tile_hash: tile_hash,
      type: type
    }
  end
end
