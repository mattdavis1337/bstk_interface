defmodule BstkInterfaceWeb.Router do
  use BstkInterfaceWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", BstkInterfaceWeb do
    pipe_through :browser

    get "/boards/:board_id", BoardController, :show       #show one board by :board_id
    #get "/", PageController, :index
  end

  # Other scopes may use custom stacks.
  # scope "/api", BstkInterfaceWeb do
  #   pipe_through :api
  # end
end
