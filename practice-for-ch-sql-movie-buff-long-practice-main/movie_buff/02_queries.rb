def eighties_b_movies
  # List all the movies from 1980-1989 with scores falling between 3 and 5
  # (inclusive). Show the id, title, year, and score.
  Movie
    .select('id', 'title', 'yr', 'score')
    .where(score: 3..5, yr: 1980..1989)
  
end

def bad_years
  # List the years in which no movie with a rating above 8 was released.
    Movie
      .group('yr')
      .having('MAX(movies.score) <= 8')
      .pluck('yr')
  
end

def cast_list(title)
  # List all the actors for a particular movie, given the title.
  # Sort the results by starring order (ord). Show the actor id and name.
  Actor
    .select('id', 'name')
    .joins(:movies)
    .where('movies.title = (?)', title)
    .order('castings.ord')

end

def vanity_projects
  # List the title of all movies in which the director also appeared as the
  # starring actor. Show the movie id, title, and director's name.

  # Note: Directors appear in the 'actors' table.
  Movie
    .select('id', 'title', 'actors.name')
    .joins(:actors)
    .where('director_id = castings.actor_id')
    .where("castings.ord = 1")
end

def most_supportive
  # Find the two actors with the largest number of non-starring roles.
  # Show each actor's id, name, and number of supporting roles.
  Actor
    .select('COUNT(*) AS roles', 'id','name')
    .joins(:castings)
    .where('castings.ord > 1')
    .group('id')
    .order('COUNT(actors.id) DESC')
    .limit(2)
  
end