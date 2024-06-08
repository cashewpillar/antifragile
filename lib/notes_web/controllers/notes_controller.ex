defmodule NotesWeb.NotesController do
  use NotesWeb, :controller

  def index(conn, _params) do
    render(conn, :index)
  end
end
