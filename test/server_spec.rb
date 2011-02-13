require File.dirname(__FILE__) + '/spec_helper'
require 'libxml'

describe "Server Tests" do
  include Rack::Test::Methods

  def app
    @app ||= Sinatra::Application
  end

  before :all do
    @objects = ['user', 'point', 'trail', 'condition', 'category']
    @base_response = 'Welcome to mobile trail mapping application'
    @test_user = "test@brousalis.com"
    @test_pw = Digest::SHA1.hexdigest('password')
    @invalid_user = "invalid@brousalis.com"
    @schema = LibXML::XML::Schema.new(File.dirname(__FILE__) + '/../schema.xsd')
  end

  describe "Point Actions" do
    it "should add a point" do
      params = {:user => @test_user,
                :pwhash => @test_pw,
                :title => 'trail_point',
                :lat => 4,
                :long => 5,
                :connections => "1,2,3",
                :condition => 'Open',
                :category => 'test',
                :trail => 'trail',
                :desc => 'test'}

      post "/point/add", params
      last_response.body.should == "Added Point 4.0, 5.0"
      Point.first(:lat => 4, :long => 5).category.name.should == 'test'
    end

    it "should delete a point" do
      params = {:user => @test_user,
                :pwhash => @test_pw,
                :title => 'trail_point',
                :lat => 4,
                :long => 5,
                :connections => "1,2,3",
                :condition => 'Open',
                :category => 'test',
                :trail => 'trail',
                :desc => 'test',
                :id => 1 }

      post "/point/add", params
      last_response.body.should == "Added Point 4.0, 5.0"

      get '/point/delete', params
      Point.first(:id => 1).should be_nil
    end

    it "should not error when deleting a nonexistant point" do
      params = {:user => @test_user,
                :pwhash => @test_pw,
                :title => 'trail_point',
                :lat => 4,
                :long => 5,
                :connections => "1,2,3",
                :condition => 'Open',
                :category => 'test',
                :trail => 'trail',
                :desc => 'test',
                :id => 1}

      get '/point/delete', params
      Point.first(:id => 1).should be_nil
    end

    it "should catch an invalid user" do
      post '/point/add', { :user => @invalid_user, :pwhash => @test_pw }
      last_response.body.should == 'Invalid username or password'
    end

    it "should return a test point" do
      params = {:user => @test_user,
                :pwhash => @test_pw,
                :title => 'trail_point',
                :lat => 4,
                :long => 5,
                :connections => "1,2,3",
                :condition => 'Open',
                :category => 'test',
                :trail => 'trail',
                :desc => 'test'}

      post "/point/add", params #need to have something in misc or builder has problems

      params = { :user => @test_user,
                :pwhash => @test_pw }

      get "/point/get", params
      doc = LibXML::XML::Document.string(last_response.body)
      doc.validate_schema(@schema).should == true
    end
  end

  describe "Trail Actions" do
    it "should add a trail" do
      trailname = 'trail'
      params = {:trail => trailname,
                :user => @test_user,
                :pwhash => @test_pw }

      post '/trail/add', params
      last_response.body.should == "Added Trail #{trailname}"
      Trail.first(:name => trailname).name.should == trailname
    end

    it "should error for an invalid user" do
      params = {:trail => 'trail',
                :user => @invalid_user,
                :pwhash => @test_pw }

      post '/trail/add', params
      last_response.body.should == "Invalid username or password"   
    end

    it "should find all trails except misc" do
      (Trail.all - Trail.all(:name => :misc)).each { |trail| trail.name.should_not == 'misc' }
    end

    it "should delete a trail" do
      trailname = 'trail'
      params = {:trail => trailname,
                :user => @test_user,
                :pwhash => @test_pw }

      post '/trail/add', params
      last_response.body.should == "Added Trail #{trailname}"

      get '/trail/delete', params
      Trail.first(:name => trailname).should be_nil
    end

    it "should not error for a non-existant trail" do
      trailname = 'trail'
      params = {:trail => trailname,
                :user => @test_user,
                :pwhash => @test_pw }

      get '/trail/delete', params
      Trail.first(:name => trailname).should be_nil
    end
  end

  describe "Category Actions" do
    it "should add a category" do
      categoryName = 'category'

      params = {:category => categoryName,
                :user => @test_user,
                :pwhash => @test_pw }

      post '/category/add', params
      last_response.body.should == "Added Category #{categoryName}"
      Category.first(:name => categoryName).name.should == categoryName
    end

    it "should error for an invalid user" do
      params = {:category => 'category',
                :user => @invalid_user,
                :pwhash => @test_pw }

      post '/category/add', params
      last_response.body.should == "Invalid username or password"   
    end

    it "should delete a category" do
      params = { :category => "test" ,
                 :user => @test_user,
                 :pwhash => @test_pw }

      post '/category/add', params
      last_response.body.should == "Added Category test"

      get '/category/delete', params
      Category.first(:name => 'test').should be_nil
    end

    it "should not error when deleting a non-existant category" do
      params = { :category => "test" ,
                 :user => @test_user,
                 :pwhash => @test_pw }

      get '/category/delete', params
      Category.first(:name => 'test').should be_nil
    end
  end

  describe "Condition Actions" do
    it "should add a condition" do
      condition = 'condition'
      params = {:condition => condition,
                :user => @test_user,
                :pwhash => @test_pw }

      post '/condition/add', params
      last_response.body.should == "Added Condition #{condition}"
      Condition.first(:desc => condition).desc.should == condition
    end

    it "should error for an invalid user" do
      params = {:name => 'condition',
                :user => @invalid_user,
                :pwhash => @test_pw }

      post '/condition/add', params
      last_response.body.should == "Invalid username or password"   
    end

    it "should delete a condition" do
      condition = 'condition'
      params = {:condition => condition,
                :user => @test_user,
                :pwhash => @test_pw }

      post '/condition/add', params
      last_response.body.should == "Added Condition #{condition}"

      get '/condition/delete', params
      Condition.first(:desc => condition).should be_nil
    end

    it "should not error on a nonexistant condition" do
      condition = 'condition'
      params = {:condition => condition,
                :user => @test_user,
                :pwhash => @test_pw }

      get '/condition/delete', params
      Condition.first(:desc => condition).should be_nil
    end
  end

  describe "Image Actions" do
    it "should return the number of images for a point" do
       params = {:user => @test_user,
                :pwhash => @test_pw,
                :title => 'trail_point',
                :lat => 4,
                :long => 5,
                :connections => "1,2,3",
                :condition => 'Open',
                :category => 'test',
                :trail => 'trail',
                :desc => 'test'}

      post "/point/add", params #need to have something in misc or builder has problems

      params = {:user => @test_user,
                :pwhash => @test_pw }

      get "/image/get/1", params

      last_response.body.should == "0"
    end

    it "should return an image for a point" do
       params = {:user => @test_user,
                :pwhash => @test_pw,
                :title => 'trail_point',
                :lat => 4,
                :long => 5,
                :connections => "1,2,3",
                :condition => 'Open',
                :category => 'test',
                :trail => 'trail',
                :desc => 'test'}

      post "/point/add", params #need to have something in misc or builder has problems

      params = { :user => @test_user,
                :pwhash => @test_pw }

      get "/image/get/1/1", params

      last_response.body.should == "Image does not exist"
    end
  end
end
