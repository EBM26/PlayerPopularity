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
            if (Time.now.hour + 8) >= 24
                @hour = (Time.now.hour + 8)%24
            else
                @hour = Time.now.hour
            end
                @topics.each do |thandle|
                        if object.text.include? thandle 
                            if TotalMention.last.created_at.hour == @hour
                                 TotalMention.last.update(total_mentions: (TotalMention.last.total_mentions + 1))
                            else 
                                 TotalMention.create(yearday: @day,  hour:@hour, total_mentions: 1)
                            end
                             @a = Player.find_by(twitter_handle: thandle)
                          if @a.updated_at.hour == @hour
                               @a.current_mentions = (@a.current_mentions + 1)
                               @a.save
                          else 
                               @total = TotalMention.all[-2]
                               @a.hourly_scores.new(yearday: @a.updated_at.yday, hour:@a.updated_at.hour, score:(@a.current_mentions/@total.total_mentions)*1000)
                               @a.current_mentions = 1
                               @a.save
                          end
                        end 	
                end	 		 	
		    end
        end
	end

	



end