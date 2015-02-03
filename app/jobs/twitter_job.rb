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
          # calculating time for 24 hours
            if (Time.now.hour + 8) >= 24
                @hour = (Time.now.hour + 8)%24
                @day =  @day = (Time.now + 1.day).yday
            else
                @hour = Time.now.hour
                @day = Time.now.yday
            end
                @topics.each do |thandle|
                        if object.text.include? thandle 
                          # checking if Total Mention is older than an hour
                            if TotalMention.last.created_at.hour == @hour
                                 TotalMention.last.update(total_mentions: (TotalMention.last.total_mentions + 1))
                            else 
                                 TotalMention.create(yearday: @day,  hour:@hour, total_mentions: 1)
                            end
                            # finding a particular player
                             @a = Player.find_by(twitter_handle: thandle)
                            # checking if player's scores are older than an hour
                          if @a.updated_at.hour == @hour
                               @a.current_mentions = (@a.current_mentions + 1)
                               @a.save
                          else 
                            # This stuff is a little screwed up, ill fix it tomorrow
                               @total = TotalMention.find_by(yearday:@a.updated_at.yday, hour:@a.updated_at.hour)
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