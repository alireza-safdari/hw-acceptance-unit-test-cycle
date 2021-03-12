require 'rails_helper'

RSpec.describe Movie, :type => :model do
    it "find correct movies by the same director" do
        new_movies = [{"title": "The Grand Budapest Hotel", "director": "Wes Anderson"}, 
        {"title": "The Fast and the Furious: Tokyo Drift", "director": "Justin Lin"}, 
        {"title": "Fast & Furious 6", "director": "Justin Lin"}]
        new_movies.each do |new_movie|
            Movie.create(new_movie)
        end

        result = Movie.by_same_director("Justin Lin")

        expect(result.length()).to eq(2)

        result = result.as_json
        expect(result[0]["director"]).to eq("Justin Lin")
        expect(result[1]["director"]).to eq("Justin Lin")
    end

end 