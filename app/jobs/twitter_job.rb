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
        @hour = Time.now.hour
        @day = Time.now.yday        
      # checking if Total Mention is older than an hour
          if TotalMention.last.created_at.hour == @hour
              TotalMention.last.update(total_mentions: (TotalMention.last.total_mentions + 1))
          else 
            #method to create missing hours 
            @i = 0
            while @i < @hour do 
              if TotalMention.find_by(hour: @i)
                  puts 'already created'
              else
                  TotalMention.create(hour:@i, total_mentions: 1)
                end
              @i += 1
            end
           #method to delete old ass mentions 
              TotalMention.all.each do |mention| 
                if (mention.created_at.yday != @day) && (mention.hour <= @hour)
                    mention.delete
                end
                # creating all of the player scores at the same time
                Player.all.each do |p|
                #method to delete old ass player scores
                  p.hourly_scores.all.each do |score| 
                    if (score.created_at.yday != @day) && (score.hour <= @hour)
                        score.delete
                    end
                end
               #method to create the score 
                @b = 0
                while @b < @hour  do 
                  if p.hourly_scores.find_by(hour: @b)
                    puts 'already created'
                  else
                    if @b == @hour - 1
                      @total = TotalMention.find_by(hour:@b)
                      p.hourly_scores.create(hour:@b, score:((p.current_mentions.to_f/@total.total_mentions.to_f)*1000).round(2))
                      p.current_mentions = 0
                      p.save
                      puts 'has is a score'
                    else 
                      p.hourly_scores.create(hour:@b, score: 0)
                    end
                  end
                  @b += 1
                end
              end                
      end
    end
    @topics.each do |thandle|
      if object.text.include? thandle 
      # finding a particular player
        @a = Player.find_by(twitter_handle: thandle)
      # checking if player's scores are older than an hour
        if @a.updated_at.hour == @hour
            @a.current_mentions = (@a.current_mentions + 1)
            @a.save
        end
      end 	
    end	 		 	
	end
  end
end

	



end