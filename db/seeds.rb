# Note: You should run a rake db:reset rather than rake db:seed in order to avoid
# 			getting duplicate data.


#--- Create some basic test players ---
players = Player.create([ 
	{name:'Kobe Bryant', 							twitter_handle: 'kobebryant', 			current_mentions: 0, switch: true},
	{name:'Lebron James', 						twitter_handle: 'KingJames', 				current_mentions: 0, switch: true},
	{name:'Carmelo Anthony', 					twitter_handle: 'carmeloanthony', 	current_mentions: 0, switch: true},
	{name:'Damian Lillard', 					twitter_handle: 'Dame_Lillard', 		current_mentions: 0, switch: true},
	
])


#--- Add some random hourly scores for today for each player ---
#note: these scores will be all over the place since it's just using rand(1000)
today = Time.now.yday
start_day = today - 30

puts "adding hourly scores for each player for today"
Player.all.each do |p|

	24.times do |ii|
		score = rand(1000) + 1
		p.hourly_scores << HourlyScore.create(yearday: today, hour: ii, score: score)
	end

	puts "done with #{p.name}"

end

#--- Create some random ass total mentions that in no way correspond to anything ---
puts "adding total mentions"

24.times do |ii|
	TotalMention.create(yearday: today, hour: ii, total_mentions: rand(5000))
end

# @hour = Time.now.hour
# @day = Time.now.yday



# TotalMention.create ([
# 	{total_mentions: 0, yearday: @day, hour: @hour}
# 	])




