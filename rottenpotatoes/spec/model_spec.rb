require 'rails_helper'

describe 'Movie Model' do
    describe '#same_director' do
        before(:each) {
            @movie1 = Movie.create(:title => "Lord of the Rings", :director => "Peter Jackson", :rating => "PG-13", :release_date => "2002-08-06")
            @movie2 = Movie.create(:title => "King Kong", :director => "Peter Jackson", :rating => "PG-13", :release_date => "2005-12-05")
            @movie3 = Movie.create(:title => "The Matrix", :director => "The Wachowskis", :rating => "R", :release_date => "1999-03-24") 
        }
        it "should return the correct matches for movies by the same director" do
            expect(Movie.same_director(@movie1.director)).to include(@movie2)
        end
        
        it "should not return matches of movies by differnet directors" do
            expect(Movie.same_director(@movie1.director)).to_not include(@movie3)
        end
    end
    
    describe '#all_ratings' do
        it "should return all ratings" do
           expect(Movie.all_ratings).to eq(["G", "PG", "PG-13", "NC-17", "R"])
        end
    end
    
    describe 'helpers' do
        before(:each){
            class TestClass
            end
            
            @tc = TestClass.new
            @tc.extend(MoviesHelper)
        }
        it 'oddness should return odd if number is odd' do
            expect(@tc.oddness(3)).to eq("odd")
        end
        it 'oddness should return even if number is even' do
            expect(@tc.oddness(4)).to eq("even") 
        end
    end
end