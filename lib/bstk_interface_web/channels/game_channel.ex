defmodule BstkInterfaceWeb.GameChannel do
  use BstkInterfaceWeb, :channel
  alias Bstk.{BoardServer, BoardSupervisor}
  alias BstkInterfaceWeb.BoardView
  alias BstkInterface.Presence

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
    send(self(), :after_join)
    #{:ok, }
    {:ok, reply, assign(socket, :user_id, "my_user1")}
  end

  def handle_info(:after_join, socket) do
    push(socket, "presence_state", Presence.list(socket))
    {:ok, _} = Presence.track(socket, socket.assigns.user_id, %{
      online_at: inspect(System.system_time(:second))
    })
    {:noreply, socket}
  end

  defp genhash(length) do
    :crypto.strong_rand_bytes(length) |> Base.url_encode64 |> binary_part(0, length)
  end
end
