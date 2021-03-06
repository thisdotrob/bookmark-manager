ENV['RACK_ENV'] ||= 'development'

require 'sinatra/base'
require 'sinatra/flash'
require 'sinatra/partial'

require_relative 'models/init'
require_relative 'controllers/init'

class BookmarkManager < Sinatra::Base
  register Sinatra::Flash
  register Sinatra::Partial

  use Rack::MethodOverride

  set :views, Proc.new { File.join(root, "../views") }
  set :session_secret, 'bollocks'
  set :partial_template_engine, :erb

  enable :sessions
  enable :partial_underscores

  def current_user
    @current_user ||= User.get(session[:user_id])
  end

  get '/' do
    redirect '/sessions/new'
  end

  run! if app_file == $0

end
