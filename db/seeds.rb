# Note: You should run a rake db:reset rather than rake db:seed in order to avoid
# 			getting duplicate data.


#--- Create some basic test players ---
players = Player.create([ 
	{name:'Kobe Bryant', 							twitter_handle: 'kobebryant', 			current_mentions: 12, bggif: 'http://i.giphy.com/q5hVhkKwKHDuo.gif'},
	{name:'Lebron James', 						twitter_handle: 'KingJames', 				current_mentions: 0 },
	{name:'Carmelo Anthony', 					twitter_handle: 'carmeloanthony', 	current_mentions: 0 },
	{name:'Damian Lillard', 					twitter_handle: 'Dame_Lillard', 		current_mentions: 0 },
	{name:'Kyrie Irving', 						twitter_handle: 'KyrieIrving', 			current_mentions: 0 },
	{name:'Micheal Carter Williams', 	twitter_handle: 'MCW1', 						current_mentions: 0 },
	{name:'Shane Battier', 						twitter_handle: 'ShaneBattier', 		current_mentions: 0 },
	{name:'Rajon Rondo', 							twitter_handle: 'rajonrondo', 			current_mentions: 0 },
	{name:'Vince Carter', 						twitter_handle: 'mrvincecarter15',	current_mentions: 0 },
	{name:'James Harden', 						twitter_handle: 'JHarden13', 				current_mentions: 0 },
	{name:'Chris Bosh', 							twitter_handle: 'chrisbosh', 				current_mentions: 0 },
	{name:'Chandler Parsons', 				twitter_handle: 'ChandlerParsons',	current_mentions: 0 },
	{name:'Chris Paul', 							twitter_handle: 'CP3', 							current_mentions: 0 },
	{name:'DeAndre Jordan', 					twitter_handle: 'deandrejordan', 		current_mentions: 0 },
	{name:'Mario Chalmers', 					twitter_handle: 'mchalmers15', 			current_mentions: 0 },
	{name:'Tony Parker', 							twitter_handle: 'tp9network', 			current_mentions: 0 },
	{name:'Pau Gasol', 								twitter_handle: 'paugasol', 				current_mentions: 0 },
	{name:'Jeremy Lin', 							twitter_handle: 'JLin7', 						current_mentions: 0 },
	{name:'Marc Gasol', 							twitter_handle: 'MarcGasol', 				current_mentions: 0 },
	{name:'Metta World Piece',				twitter_handle: 'MettaWorldPeace',	current_mentions: 0 },
	{name:'Landry Fields', 						twitter_handle: 'landryfields', 		current_mentions: 0 },
	{name:'Derrick Rose', 						twitter_handle: 'drose', 						current_mentions: 0 }
])


#--- Add some random hourly scores for today for each player ---
#note: these scores will be all over the place since it's just using rand(1000)
today = Time.now.yday
start_day = today - 30

# puts "adding hourly scores for each player for today"
# Player.all.each do |p|

# 	24.times do |ii|
# 		score = rand(1000) + 1
# 		p.hourly_scores << HourlyScore.create(yearday: today, hour: ii, score: score)
# 	end

# 	puts "done with #{p.name}"

# end

#--- Create some random ass total mentions that in no way correspond to anything ---
puts "adding total mentions"

# 24.times do |ii|
# 	TotalMention.create(yearday: today, hour: ii, total_mentions: rand(5000))
# end

@hour = Time.now.hour
@day = Time.now.yday



TotalMention.create ([
	{total_mentions: 0, yearday: @day, hour: @hour}
	])




