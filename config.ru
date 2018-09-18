require 'rails'
require 'action_controller'

class App < Rails::Application
  
  config.secret_key_base = '0837359d48a53883'

  routes.append do 
    root to: proc{|env| [200, {'Content-type' => 'text/html'}, ['Hello World']]}

    get '/hello' => proc{|env| [200, {'Content-type' => 'text/plain'}, ['Hello Again']]}

    get '/thing' => 'things#index'
  end


end

class ThingsController < ActionController::Base

  def index
    render :plain => "thingy"
  end

end

App.initialize!

run App
