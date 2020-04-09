defmodule BstkInterfaceWeb.GameChannel do
  use BstkInterfaceWeb, :channel
  alias Bstk.{BoardServer, BoardSupervisor}
  alias BstkInterfaceWeb.BoardView

  def channel do
    quote do
      use Phoenix.Channel
      import BstkInterfaceWeb.Gettext
    end
  end

  def join("game:" <> board_id, _payload, socket) do
    IO.puts("joining...")
    {:ok, _game} = BoardSupervisor.find_or_create_process(String.to_integer(board_id))
    #Is it ok that we aren't pulling based on _game pid returned? Can this cause a race condition? MFD 3/23/2020
    #{:ok, _game} = BoardServer.start_link(%{board_name: "mainboard", process_id: String.to_integer(board_id), x: 16, y: 16})


    board = BoardServer.get_board(String.to_integer(board_id))
    boardJSON = BoardView.render("show.json", board)
    reply = %{"board" => boardJSON};

    IO.puts("joined...")
    {:ok, reply, socket}
  end
end
