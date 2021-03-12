require 'rails_helper'


RSpec.describe "Routing test", :type => :request do
    it "route correctly when the movie has a director" do
        new_movies = [{"title": "The Grand Budapest Hotel", "director": "Wes Anderson"}, 
        {"title": "The Fast and the Furious: Tokyo Drift", "director": "Justin Lin"}, 
        {"title": "Fast & Furious 6", "director": "Justin Lin"}]
        new_movies.each do |new_movie|
            Movie.create(new_movie)
        end
        
        id =  Movie.where(title: "The Fast and the Furious: Tokyo Drift")[0].as_json["id"]
        get "/movies/#{id}/same_director"
        expect(response).to render_template("same_director")
    end

    it "route correctly when the movie has no director" do
        new_movies = [{"title": "The Grand Budapest Hotel"}, 
        {"title": "The Fast and the Furious: Tokyo Drift", "director": "Justin Lin"}, 
        {"title": "Fast & Furious 6", "director": "Justin Lin"}]
        new_movies.each do |new_movie|
            Movie.create(new_movie)
        end
        
        id =  Movie.where(title: "The Grand Budapest Hotel")[0].as_json["id"]
        get "/movies/#{id}/same_director"
        expect(response).to redirect_to("/movies")
    end
    
    it "route correctly for other general cases" do
        new_movies = [{"title": "The Grand Budapest Hotel", "director": "Wes Anderson", "release_date": "2014-02-06"}]
        new_movies.each do |new_movie|
            Movie.create(new_movie)
        end
        
        get "/movies"
        expect(response).to render_template("index")

        get "/movies/1"
        expect(response).to render_template("show")
        
        get "/movies/1/edit"
        expect(response).to render_template("edit")
        
        get "/movies/new"
        expect(response).to render_template("new")
        
        put "/movies/1", "movie": {"title": "Fast & Furious 6"}
        expect(response).to redirect_to("/movies/1")
        
        delete "/movies/1"
        expect(response).to redirect_to("/movies")
        
    end
    
end