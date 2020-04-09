defmodule BstkInterfaceWeb.BoardView do
  use BstkInterfaceWeb, :view
  alias BstkInterfaceWeb.BoardView
  alias BstkInterfaceWeb.TileSlotView
  alias BstkInterfaceWeb.TileView

  def render("index.json", %{boards: boards}) do
    IO.puts("In board render index")
    %{data: render_many(boards, BoardView, "board.json")}
  end

  def render("show.json", board) do
    IO.puts("In board render show")
    %{data: render_one(board, BoardView, "board.json")}
  end

  def render("board.json", %{board: board}) do
    IO.puts("In board render board")
    %{
      name: board.board_name,
      hash: board.creator_hash,
      height: board.height,
      width: board.width,
      tile_slots: TileSlotView.render("index.json", %{tile_slots: board.tile_slots}),
      tiles: TileView.render("index.json", %{tiles: board.tiles})
    }
  end
end
