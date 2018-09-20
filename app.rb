require 'rails'
require 'action_controller'

class App < Rails::Application
  
  config.secret_key_base = '0837359d48a53883'

  routes.append do 
    root to: proc{|env| [200, {'Content-type' => 'text/html'}, ['Hello World']]}

    get '/hello' => proc{|env| [200, {'Content-type' => 'text/plain'}, ['Hello Again']]}

    get '/thing' => 'things#index'

    get '/page' => 'things#page'
  end


end

class ThingsController < ActionController::Base

  def index
    render :plain => "thingy"
  end

end

def templates
  @templates ||= begin 
                   templates = {}
                   template = nil
                   lines = 0
                   DATA.each_line do |line|
                     lines += 1
                     if line =~ /^@@\s*(.*\S)\s*$/
                       template = ''
                       templates[$1.to_sym] = template
                     elsif template
                       template << line
                     end
                   end
                   templates
                 end
end

App.initialize!

Rack::Handler::WEBrick.run App

__END__
@@ layout
<!doctype html>
<html>
<head>
  <title>The App</title>
</head>
<body>
  <%= yield %>
</body>
</html>

@@ index
The body!

