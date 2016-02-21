defmodule GrowJournal.Router do
  use GrowJournal.Web, :router

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

  pipeline :admin do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug GrowJournal.Auth, repo: GrowJournal.Repo
  end

  scope "/", GrowJournal do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    get "/login", UserController, :login
    post "/login", UserController, :handle_login
    resources "/plants", PlantController do
      resources "/events", EventController
    end
    resources "/users", UserController, except: [:delete, :edit, :update]
  end

  scope "/admin", GrowJournal.Admin, as: :admin do
    pipe_through :admin

    resources "/users", UserController
  end

  # Other scopes may use custom stacks.
  # scope "/api", GrowJournal do
  #   pipe_through :api
  # end
end
