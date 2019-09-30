require 'rest-client'
require 'JSON'
require 'pry'

def get_character_movies_from_api(character_name)
  #make the web request
  response_string = RestClient.get('http://www.swapi.co/api/people/')
  response_hash = JSON.parse(response_string)
  film_urls = nil

  response_hash["results"].each do |result|
    if result["name"].downcase == character_name
      film_urls = result["films"]
    end
  end
  
  film_hashes = []

  film_urls.each do |film_url|
    film_response = RestClient.get(film_url)
    film_hash = JSON.parse(film_response)

    film_hashes << film_hash
  end

  film_hashes
end

def print_movies(films)
  i = 0
  # some iteration magic and puts out the movies in a nice list
  films.each do |film|
    puts "#{i + 1}. #{film["title"]}"
    i += 1
  end
end

def show_character_movies(character)
  films = get_character_movies_from_api(character)
  print_movies(films)
end

## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
