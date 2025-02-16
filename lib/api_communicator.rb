require 'rest-client'
require 'json'
require 'pry'

def response_string
  RestClient.get('http://www.swapi.co/api/people/')
end

def response_hash
  JSON.parse(response_string)
end

def get_character_movies_from_api(character_name)
  # iterate over the response hash to find the collection of `films` for the given
  #   `character`
  character = response_hash['results'].find { |a| a['name'].downcase == character_name }
  character["films"].collect { |f| JSON.parse(RestClient.get(f)) }
  # collect those film API urls, make a web request to each URL to get the info
  #  for that film
  # return value of this method should be collection of info about each film.
  #  i.e. an array of hashes in which each hash reps a given film
  # this collection will be the argument given to `print_movies`
  #  and that method will do some nice presentation stuff like puts out a list
  #  of movies by title. Have a play around with the puts with other info about a given film.
end

def print_movies(films)
  # some iteration magic and puts out the movies in a nice list
  films.each { |f| puts f['title'] }
end

def show_character_movies(character)
  films = get_character_movies_from_api(character)
  print_movies(films)
end


## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
