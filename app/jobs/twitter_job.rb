class TwitterJob
	include SuckerPunch::Job 

	
	def perform

    @topics = Player.twitter_handles

		@counter = 0

    TweetStream.configure do |config|
      config.consumer_key       = ENV["consumer_key"]
      config.consumer_secret    = ENV["consumer_secret"]
      config.oauth_token        = ENV["access_token"]
      config.oauth_token_secret = ENV["access_token_secret"]
      config.auth_method        = :oauth
    end

    tweet_client = TweetStream::Client.new

    tweet_client.on_reconnect do |timeout, retries|
      #reconnect
      puts "Reconnecting tweet_stream.  timeout:#{timeout}, retries:#{retries}"

    end

    tweet_client.on_error do |message|
      #error
      puts "Error with tweet_stream: #{message}"
    end


    tweet_client.track(@topics.join(",")) do |object|

      # If any database errors occur, catch them!!!
      begin

        if object.is_a?(Twitter::Tweet)

          # calculating time for 24 hours
          @hour = Time.now.hour
          @day = Time.now.yday

          # checking if Total Mention is older than an hour
          if TotalMention.last.created_at.hour == @hour
            TotalMention.last.update(total_mentions: (TotalMention.last.total_mentions + 1))
          else

            # Create any missing hours. There should be a total mention for every hour.
            TotalMention.create_missing_hours

            TotalMention.delete_old_hours

            Player.all.each do |p|

              # Delete all scores not from the last 24 hours for this player
              p.delete_old_hourly_scores

              #method to create the score 
              @b = 0
              while @b < @hour do

                if p.hourly_scores.find_by(hour: @b)
                  puts "#{p.name} score for hour #{@b} exists. Doing nothing."
                else

                  #create last hour's score
                  if @b == @hour - 1
                    @total = TotalMention.find_by(hour:@b)
                    p.hourly_scores.create(hour:@b, score:((p.current_mentions.to_f/@total.total_mentions.to_f)*1000).round(2))
                    p.current_mentions = 0
                    p.save
                    puts "Created #{p.name} score for hour #{@b}"
                  else
                    # a score was missing for some reason
                    p.hourly_scores.create(hour:@b, score: 0)
                    puts "Score for #{p.name} at hour #{@b} was missing. Created it."
                  end

                end

                @b += 1

              end
            end                
            
          end

          @topics.each do |thandle|

            if object.text.include? thandle
              # finding a particular player
              @a = Player.find_by(twitter_handle: thandle)
              puts "processing tweet for #{@a.name}"

              # checking if player's scores are older than an hour
              if @a.updated_at.hour == @hour
                @a.current_mentions = (@a.current_mentions + 1)
                @a.save
                puts "\tupdated current mentions for #{@a.name} to #{@a.current_mentions}"
              else
                puts "\t#{@a.name} wasn't updated this hour so doing nothing. This is bad, I think."
              end
            end

          end

      	end #end of if object.is_a?(Twitter::Tweet)

      # Rescue database errors!!!
      rescue ActiveRecord::StatementInvalid => e
        puts "______________________PG CONNECTION IS BROKEN AGAIN____________________"

        ActiveRecord::Base.connection.reconnect!
      rescue => e
        puts "________________AN ERROR OCCURED BUT IT WASN'T StatementInvalid__________"
        puts "error text: #{e.message}"

        ActiveRecord::Base.connection.reconnect!
      end

    end #end of tweet_client.track
    
  end #end of #perform

end #end of class