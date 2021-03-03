# Add a declarative step here for populating the DB with movies.

Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    Movie.create!(movie)
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
  end
  # fail "Unimplemented"
end

Then /(.*) seed movies should exist/ do | n_seeds |
  Movie.count.should be n_seeds.to_i
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  expect(page.body).to have_content(/(.*)#{e1}(.*)#{e2}(.*)/mi)
  #  ensure that that e1 occurs before e2.
  #  page.body is the entire content of the page as a string.
  # fail "Unimplemented"
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  # HINT: use String#split to split up the rating_list, then
  #   iterate over the ratings and reuse the "When I check..." or
  #   "When I uncheck..." steps in lines 89-95 of web_steps.rb
  # fail "Unimplemented"
  ratings = rating_list.split(', ')
  ratings.each do |rating|
    uncheck ? uncheck("ratings[#{rating}]") : check("ratings[#{rating}]")
  end
end

Then /I should (not )?see the following ratings: (.*)/ do |notsee, rating_list|
  ratings = rating_list.split(', ')
  ratings.each do |rating|
    if notsee 
      !expect(page).to have_content(rating)
    else
      expect(page).to have_content(rating)
    end
  end
end

Then /I should see all the movies/ do
  Movie.all.each do |movie|
    expect(page).to have_content(movie.title)
  end
  # Make sure that all the movies in the app are visible in the table
  # fail "Unimplemented"
end
