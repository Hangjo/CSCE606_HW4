require 'rails_helper'
require 'support/initialization_fix'

describe MoviesController, :type => :controller do
    describe '#create' do
        before (:each) {
            @movie = {:title => "Lord of the Rings", :director => "Peter Jackson", :rating => "PG-13", :release_date => "2002-08-06", :description => "a movie", :id => '3'}
        }
        it 'should display flash' do
            get :create, :movie => @movie
            
            expect(flash[:notice]).to eq ("Lord of the Rings was successfully created.")
        end
        it 'should redirect to main page after creation' do
            get :create, :movie => @movie
            
            expect(response).to redirect_to(movies_path) 
        end
    end
    
    describe '#edit' do
        it 'should send call to Movie.find' do
            @movie = double(Movie).as_null_object
            
            allow(@movie).to receive(:id) { '1' }
            
            expect(Movie).to receive(:find).with(@movie.id).and_return(@movie)
            
            get :edit, :id => @movie.id
        end
    end
    
    describe '#show' do
        it 'should send call to Movie.find' do
            @movie = double(Movie).as_null_object
            
            allow(@movie).to receive(:id) { '1' }
            
            expect(Movie).to receive(:find).with(@movie.id).and_return(@movie)
            
            get :show, :id => @movie.id
        end
    end
    
    describe '#index' do 
        it 'should send a call to Movie.all_ratings' do
            expect(Movie).to receive(:all_ratings).and_return(["G", "PG", "PG-13", "NC-17", "R"])
            
            get :index
        end
        it 'should apply css classes to title header if selected' do
            get :index, :sort => "title"
            expect(controller.instance_variable_get('@title_header')).to eq('bg-warning hilite')
        end
        it 'should apply css classes to release header if selected' do
            get :index, :sort => "release_date"
            expect(controller.instance_variable_get('@date_header')).to eq('bg-warning hilite')
        end
    end
    
    describe '#director' do
        it 'When the specified movie has a director, it should make a call to Movie.same_director' do
            @movie = double(Movie).as_null_object
            
            allow(@movie).to receive(:id) { '1' }
            allow(@movie).to receive(:director) { "Peter Jackson" }
            
            expect(Movie).to receive(:find).with(@movie.id).and_return(@movie)
            expect(Movie).to receive(:same_director)
            
            get :director, :id => @movie.id
        end
        it 'When the specifid movie has no director, it should return to the main page and display flash' do
            @movie = double(Movie).as_null_object
           
            allow(@movie).to receive(:title) { "Lord of the Rings" }
            allow(@movie).to receive(:id) { '2' }
           
            expect(Movie).to receive(:find).with(@movie.id).and_return(@movie)
            
            get :director, :id => @movie.id
           
            expect(response).to redirect_to(movies_path)
            expect(flash[:notice]).to eq("'Lord of the Rings' has no director info")
        end
    end
end