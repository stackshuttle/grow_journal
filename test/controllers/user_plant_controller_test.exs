defmodule GrowJournal.UserPlantControllerTest do
  use GrowJournal.ConnCase

  test "requires user authentication on all actions", %{conn: conn} do
    Enum.each([
      get(conn, user_user_plant_path(conn, :new)),
      get(conn, user_user_plant_path(conn, :edit, "123")),
      get(conn, user_user_plant_path(conn, :show, "123")),
      get(conn, user_user_plant_path(conn, :edit, "123")),
      put(conn, user_user_plant_path(conn, :update, "123", %{"user_plant": "123"})),
      post(conn, user_user_plant_path(conn, :create, %{"user_plant": "123"})),
      delete(conn, user_user_plant_path(conn, :delete, "123")),
    ], fn conn ->
      assert html_response(conn, 302)
      assert conn.halted
    end)
  end
end
