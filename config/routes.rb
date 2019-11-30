Rails.application.routes.draw do

	mount Github::Base => "/"

	match "/score/:username" => redirect { |params, request| "/api/v1/score/#{params[:username]}" }, :via=>[:get]

end
