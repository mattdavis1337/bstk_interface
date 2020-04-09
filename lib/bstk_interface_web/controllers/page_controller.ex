defmodule BstkInterfaceWeb.PageController do
  use BstkInterfaceWeb, :controller

  def index(conn, _params) do
    IO.puts("conn:")
    IO.inspect(conn)
    render(conn, "index.html")
  end
end
