class TwitterJob
	include SuckerPunch::Job 

	
	def perform
		@counter = 0
		@client = Twitter::Streaming::Client.new do |config|
  		config.consumer_key        = ENV["consumer_key"]
  		config.consumer_secret     = ENV["consumer_secret"]
 		config.access_token        = ENV["access_token"]
  		config.access_token_secret = ENV["access_token_secret"]
		end
		@topics = ['kobebryant','kingjames']
		@client.filter(track: @topics.join(",")) do |object| 
    	if object.is_a?(Twitter::Tweet)
    		if object.text.include? 'kobebryant'
    			a = Playerscore.find_by(name:'Kobe Bryant')
    			a.twitterscore = (a.twitterscore + 1)
    			a.save
    			puts "Kobe tweet /n #{object.text}"
    		elsif object.text.include? 'kingjames'
    			a = Playerscore.find_by(name:'Lebron James')
    			a.twitterscore = (a.twitterscore + 1)
    			a.save
    			puts "Lebron tweet /n #{object.text}"
    		end
    		 		 	
		end
	end

	end

end