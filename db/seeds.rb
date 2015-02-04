# Note: You should run a rake db:reset rather than rake db:seed in order to avoid
# 			getting duplicate data.


#--- Create some basic test players ---
players = Player.create([ 
	{name:'Kobe Bryant', 							twitter_handle: 'kobebryant', 			current_mentions: 0, switch: true},
	{name:'Lebron James', 						twitter_handle: 'KingJames', 				current_mentions: 0, switch: true},
	{name:'Carmelo Anthony', 					twitter_handle: 'carmeloanthony', 	current_mentions: 0, switch: true},
	{name:'Damian Lillard', 					twitter_handle: 'Dame_Lillard', 		current_mentions: 0, switch: true},
	{name:'Kyrie Irving', 						twitter_handle: 'KyrieIrving', 			current_mentions: 0, switch: true},
	{name:'Micheal Carter Williams', 	twitter_handle: 'MCW1', 						current_mentions: 0, switch: true},
	{name:'Shane Battier', 						twitter_handle: 'ShaneBattier', 		current_mentions: 0, switch: true},
	{name:'Rajon Rondo', 							twitter_handle: 'rajonrondo', 			current_mentions: 0, switch: true},
	{name:'Vince Carter', 						twitter_handle: 'mrvincecarter15',	current_mentions: 0, switch: true},
	{name:'James Harden', 						twitter_handle: 'JHarden13', 				current_mentions: 0, switch: true},
	{name:'Chris Bosh', 							twitter_handle: 'chrisbosh', 				current_mentions: 0, switch: true},
	{name:'Chandler Parsons', 				twitter_handle: 'ChandlerParsons',	current_mentions: 0, switch: true},
	{name:'Chris Paul', 							twitter_handle: 'CP3', 							current_mentions: 0, switch: true},
	{name:'DeAndre Jordan', 					twitter_handle: 'deandrejordan', 		current_mentions: 0, switch: true},
	{name:'Mario Chalmers', 					twitter_handle: 'mchalmers15', 			current_mentions: 0, switch: true},
	{name:'Tony Parker', 							twitter_handle: 'tp9network', 			current_mentions: 0, switch: true},
	{name:'Pau Gasol', 								twitter_handle: 'paugasol', 				current_mentions: 0, switch: true},
	{name:'Jeremy Lin', 							twitter_handle: 'JLin7', 						current_mentions: 0, switch: true},
	{name:'Marc Gasol', 							twitter_handle: 'MarcGasol', 				current_mentions: 0, switch: true},
	{name:'Metta World Piece',				twitter_handle: 'MettaWorldPeace',	current_mentions: 0, switch: true},
	{name:'Landry Fields', 						twitter_handle: 'landryfields', 		current_mentions: 0, switch: true},
	{name:'Derrick Rose', 						twitter_handle: 'drose', 						current_mentions: 0, switch: true}
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

# if (Time.now.hour + 8) >= 24
#   @hour = (Time.now.hour + 8)%24
#   @day = (Time.now + 1.day).yday
# else
#   @hour = Time.now.hour
#   @day = Time.now.yday
# end


# TotalMention.create ([
# 	{total_mentions: 0, yearday: @day, hour: @hour}
# 	])




