defmodule BstkInterfaceWeb.TileSlotView do
  use BstkInterfaceWeb, :view
  alias BstkInterfaceWeb.TileSlotView

  def render("index.json", %{tile_slots: tile_slots}) do
    IO.puts("in TileSlotView render index.json")
    render_many(tile_slots, TileSlotView, "tile_slot.json")
  end

  def render("show.json", %{tile: tile}) do
    %{data: render_one(tile, TileSlotView, "tile_slots.json")}
  end

  def render("tile_slot.json", %{tile_slot: {_coord, %Bstk.TileSlot{tile_hash: tile_hash, tile_slot_hash: tile_slot_hash, x: x, y: y}}}) do
    #IO.puts("in render tile_slot.json")
    %{x: x,
      y: y,
      tile_hash: tile_hash,
      tile_slot_hash: tile_slot_hash}

  end
end
