
require 'soundcloud'

client = Soundcloud.new(:client_id => '7be899ca72e6534d952737e40093afe8')


puts "welcome to hottest10 !"

loop do

	puts "would you like to check out the hottest tracks on soundcloud by genre or latest ?"
 
	print "(put genre or latest ) : " 

	decision=gets. chomp

	if  decision== "genre"

		print "please input a genre :  "

		genre = gets.chomp

		tracks = client.get('/tracks',  genres: "#{genre}" )   

		tracks.delete_if{|t|t=!t.playback_count||t.playback_count==0 ||t.favoriting_count == 0}

		tracks.delete_if{|t|t=t.comment_count.nil?}

		tracks.delete_if{|t|t=t.download_count.nil?}

		tracks.sort_by!{|t|(t.download_count+t.playback_count)/(t.download_count*0.5+t.favoritings_count+t.comment_count/0.5)}

		newa=tracks.take(10) 

		newa.each { |t| puts  t.permalink_url}


	elsif decision=="latest"

		page_size = 100

		tracks = client.get('/tracks', :order => 'created_at', :limit => page_size, :offset => page_size)

		tracks.delete_if {|t|t=!t.playback_count||t.playback_count==0}

		tracks.sort_by!{|t|- (t.playback_count+t.download_count+t.favoritings_count*2+t.comment_count*2)}

		newa=tracks.take(10) 

		newa.each { |t| puts  t.permalink_url}


	else  puts "wrong answer, what were you thinking" 

	end

	print "would you like to keep searching ? (yes or no) :  "

	decision2=gets.chomp

	break if decision2=="no"

end

puts "have a nice day !"

