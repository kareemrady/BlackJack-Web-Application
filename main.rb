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
	session[:dealer_score]= 0
	session[:player_score]= 0
	suit = ["H", "C", "S", "D"]
	value = ["A", "2", "3", "4", "5","6", "7", "8", "9", "10", "J", "K", "Q"]
	session[:deck] = suit.product(value).shuffle!
	session[:dealer_cards] << session[:deck].pop
	session[:dealer_cards] << session[:deck].pop
	session[:player_cards] << session[:deck].pop
	session[:player_cards] << session[:deck].pop
	session[:player_cards].each do |s, v|
		if v == "A"
			session[:player_score] += 11 
		else
		v.to_i == 0 ? session[:player_score] +=10 : session[:player_score] += v.to_i
	end
end
	session[:dealer_cards].each do |s, v|
		if v == "A" 
			session[:dealer_score] += 11 
		else
		v.to_i == 0 ? session[:dealer_score] +=10 : session[:dealer_score] += v.to_i
	end
end

	erb :game, :layout => false

end

post '/hit' do
session[:player_cards] << session[:deck].pop
session[:dealer_cards] << session[:deck].pop


erb :hit, :layout => false
end

post '/stay' do
session[:player_cards] 
session[:dealer_cards] 
erb :stay, :layout => false
end




