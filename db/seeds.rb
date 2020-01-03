Playlist.destroy_all
Song.destroy_all
User.destroy_all

@headlines = Song.create(name: "Headlines", artist: "Drake", feeling: "hyped")
@creep_on_me = Song.create(name: "Creep on Me", artist: "GASHI", feeling: "chill")
@sorry = Song.create(name: "Sorry", artist: "6lack", feeling: "heartbroken")
@hands_free = Song.create(name: "Hands Free", artist: "The wav", feeling: "hyped")
@vertigo = Song.create(name: "Vertigo", artist: "Jason Derulo", feeling: "chill")
@someone_you_loved = Song.create(name: "Someone You Loved", artist: "Lewis Capaldi", feeling: "heartbroken")
@all_i_do_is_win = Song.create(name: "All I do is Win", artist: "DJ Khaled", feeling: "hyped")
@dont_matter = Song.create(name: "Don't Matter", artist: "August Alsina", feeling: "chill")
@not_ok = Song.create(name: "Not OK", artist: "Kygo", feeling: "heartbroken")
@dreams_and_nightmares = Song.create(name: "Dreams and Nightmares", artist: "Meek Mill", feeling: "hyped")
@rivals = Song.create(name: "Rivals", artist: "Usher", feeling: "chill")
@dancing_with_a_stranger = Song.create(name: "Dancing with a Stranger", artist: "Sam Smith", feeling: "heartbroken")
@six_seven_nine = Song.create(name: "679", artist: "Fetty Wap", feeling: "hyped")
@needs = Song.create(name: "Needs", artist: "ELHAE", feeling: "chill")
@somebody_to_love = Song.create(name: "Somebody to Love", artist: "OneRepublic", feeling: "heartbroken")
@nobodys_better = Song.create(name: "Nobody's Better", artist: "Fetty Wap", feeling: "hyped")

@vicky = User.create(name: "Vicky", age: 18, location: "NYC")
@drew = User.create(name: "Drew", age: 40, location: "London")
@amy = User.create(name: "Amy", age: 25, location: "Los Angeles")

@vicky_hyped = Playlist.create(title:"hyped", user_id: @vicky.id, song_id: @headlines.id)
@vicky_chill = Playlist.create(title: "chill", user_id: @vicky.id, song_id: @creep_on_me.id)
@vicky_heartbroken = Playlist.create(title: "heartbroken", user_id: @vicky.id, song_id: @sorry.id)
@drew_hyped = Playlist.create(title:"hyped", user_id: @drew.id, song_id: @hands_free.id)
@drew_chill = Playlist.create(title: "chill", user_id: @drew.id, song_id: @vertigo.id)
@drew_heartbroken = Playlist.create(title: "heartbroken", user_id: @drew.id, song_id: @someone_you_loved.id)
@amy_hyped = Playlist.create(title:"hyped", user_id: @amy.id, song_id: @all_i_do_is_win.id)
@amy_chill = Playlist.create(title: "chill", user_id: @amy.id, song_id: @dont_matter.id)
@amy_heartbroken = Playlist.create(title: "heartbroken", user_id: @amy.id, song_id: @not_ok.id)