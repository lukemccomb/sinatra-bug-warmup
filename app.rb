require "sinatra"
require "gschool_database_connection"
require "rack-flash"

class App < Sinatra::Base
  enable :sessions
  use Rack::Flash

  def initialize
    super
    @database_connection = GschoolDatabaseConnection::DatabaseConnection.establish(ENV["RACK_ENV"])
  end

  get "/" do
    erb :home
  end

  get "/register" do
    erb :register
  end

  post "/registrations" do
    hunter_value = params[:name_is_hunter]

    if hunter_value.to_i == 1

    @database_connection.sql("INSERT INTO users (username, email, password, name_is_hunter)
    VALUES ('#{params[:username]}', '#{params[:email]}', '#{params[:password]}', '#{params[:name_is_hunter]}')")
    flash[:notice] = "Thanks for signing up"
    redirect "/"

    else
      flash[:notice] = "You're name ain't Hunter!"
      redirect "/register"
    end
  end
end