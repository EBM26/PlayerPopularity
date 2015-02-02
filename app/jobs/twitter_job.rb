class TwitterJob
	include SuckerPunch::Job 

	
	def perform
        @topics = Player.twitter_handles

		@counter = 0
		@client = Twitter::Streaming::Client.new do |config|
  		config.consumer_key        = ENV["consumer_key"] 
  		config.consumer_secret     = ENV["consumer_secret"]
 		config.access_token        = ENV["access_token"]
  		config.access_token_secret = ENV["access_token_secret"]
		end
		# @topics = ['kobebryant','KingJames']
		@client.filter(track: @topics.join(",")) do |object| 
    	   if object.is_a?(Twitter::Tweet)
            
                @topics.each do |thandle|
                        if object.text.include? thandle 
                             @a = Player.find_by(twitter_handle: thandle)
                          if @a.updated_at.hour == Time.now.hour + 8
                               @a.current_mentions = (@a.current_mentions + 1)
                               @a.save
                          else 
                               @a.hourly_scores.new(yearday: @a.updated_at.yday, hour:@a.updated_at.hour, score:@a.current_mentions)
                               @a.current_mentions = 1
                               @a.save
                          end
                        end 	
                end	 		 	
		    end
        end
	end

	



end