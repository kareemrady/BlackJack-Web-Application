require 'rubygems'
require 'sinatra'

set :sessions, true

get  '/' do 
	if session[:player_name]
		redirect '/game'
	else 
		redirect '/new_player'
	end

end

get '/new_player' do
	erb :new_player
end

post '/game' do
	session[:new_player] = params[:new_player]
	session[:dealer_cards] = []
	session[:player_cards]= []
	suit = ["H", "C", "S", "D"]
	value = ["A", "2", "3", "4", "5","6", "7", "8", "9", "10", "J", "K", "Q"]
	session[:deck] = suit.product(value).shuffle!
	session[:dealer_cards] << session[:deck].pop
	session[:dealer_cards] << session[:deck].pop
	session[:player_cards] << session[:deck].pop
	session[:player_cards] << session[:deck].pop
	erb :game, :layout => false

end

