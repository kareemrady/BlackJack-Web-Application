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


redirect '/dealer_busted' if session[:dealer_score] > 21

redirect '/player_busted' if session[:player_score] > 21 

redirect '/dealer_blackjack' if session[:dealer_score] == 21

redirect '/player_blackjack' if session[:player_score] == 21


	erb :game, :layout => false

end

post '/hit' do
	new_card_player = session[:deck].pop
session[:player_cards] << new_card_player
if session[:dealer_score] < 17
	new_card_dealer = session[:deck].pop
	session[:dealer_cards] << new_card_dealer
	value_d = new_card_dealer[1]
		if value_d == "A" 
			session[:dealer_score] += 11 
		else
		value_d.to_i == 0 ? session[:dealer_score] +=10 : session[:dealer_score] += value_d.to_i
	end
else
	session[:dealer_cards]
	session[:dealer_score]
end
value_p = new_card_player[1]
		if value_p == "A"
			session[:player_score] += 11 
		else
		value_p.to_i == 0 ? session[:player_score] +=10 : session[:player_score] += value_p.to_i
	end

	



redirect '/dealer_busted' if session[:dealer_score] > 21

redirect '/player_busted' if session[:player_score] > 21 

redirect '/dealer_blackjack' if session[:dealer_score] == 21

redirect '/player_blackjack' if session[:player_score] == 21

redirect '/draw' if session[:player_score] == session[:dealer_score]

redirect '/player_won' if (session[:player_score] - 21).abs < (session[:dealer_score] - 21).abs

redirect '/dealer_won' if (session[:player_score] - 21).abs > (session[:dealer_score] - 21).abs


erb :hit, :layout => false
end

post '/stay' do
session[:player_cards] 
session[:player_score]
 
if session[:dealer_score] < 17
	new_card_dealer = session[:deck].pop
	session[:dealer_cards] << new_card_dealer
	value_d = new_card_dealer[1]
		if value_d == "A" 
			session[:dealer_score] += 11 
		else
		value_d.to_i == 0 ? session[:dealer_score] +=10 : session[:dealer_score] += value_d.to_i
	end

else
	session[:dealer_cards]
	session[:dealer_score]
end


redirect '/dealer_busted' if session[:dealer_score] > 21

redirect '/player_busted' if session[:player_score] > 21 

redirect '/dealer_blackjack' if session[:dealer_score] == 21

redirect '/player_blackjack' if session[:player_score] == 21

redirect '/draw' if session[:player_score] == session[:dealer_score]

redirect '/player_won' if (session[:player_score] - 21).abs < (session[:dealer_score] - 21).abs

redirect '/dealer_won' if (session[:player_score] - 21).abs > (session[:dealer_score] - 21).abs

erb :stay, :layout => false
end

get '/dealer_busted' do
	erb :dealer_busted, :layout => false
end
get '/player_busted' do
	erb :player_busted, :layout => false
end
get '/dealer_blackjack' do
	erb :dealer_blackjack, :layout => false
end
get '/player_blackjack' do
	erb :player_blackjack, :layout => false
end
get '/player_won' do
	erb :player_won, :layout => false
end
get '/dealer_won' do
	erb :dealer_won, :layout => false
end

get '/draw' do
	erb :draw, :layout => false
end




