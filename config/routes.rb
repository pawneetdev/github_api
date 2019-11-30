Rails.application.routes.draw do

	mount Github::Base => "/"

	get '/score/:username', to: redirect('/api/v1/score/:username')

end
