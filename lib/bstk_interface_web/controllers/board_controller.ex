defmodule BstkInterfaceWeb.BoardController do
  use BstkInterfaceWeb, :controller

  def show(conn, %{"board_id" => board_id}) do
    render(conn, "board.html", board_id: board_id)
  end
end
