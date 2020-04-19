defmodule BstkInterface.Presence do
  use Phoenix.Presence, otp_app: :bstk_interface,
                        pubsub_server: BstkInterface.PubSub



end
