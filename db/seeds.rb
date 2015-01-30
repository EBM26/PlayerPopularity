# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Player.create([ 
	{name:'Kobe Bryant', twitter_handle: 'kobebryant', current_mentions: 0},
	{name:'Lebron James', twitter_handle: 'KingJames', current_mentions: 0}
	])