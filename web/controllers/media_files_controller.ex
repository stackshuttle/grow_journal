defmodule GrowJournal.MediaFilesController do
  use GrowJournal.Web, :controller
  import Plug.Conn

  @media_folder "/media"

  def download(conn, %{"filepath" => filepath}) do
    filepath = Enum.join(filepath, "/")
    path = "#{System.cwd}#{@media_folder}/#{filepath}"
    conn
    |> put_resp_content_type("image/png")
    |> send_file(200, path)
  end
end
