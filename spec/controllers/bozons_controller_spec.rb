require File.dirname(__FILE__) + '/../spec_helper'

describe BozonsController do
  describe "handling POST /bozons" do
    before(:each) do 
      #@request.env["HTTP_ACCEPT"] = "text/x-json"
      @request.env["HTTP_ACCEPT"] = "application/json"
      @json_hash = { :_rev => 0,
                    :_type => :datatype,
                    :name => 'String',
                    :content => [
                      {:label => 'String'},
                      {:class => 'String'}
                    ] 
                  }
      @yr_dt_str = YRDatatype.new(@json_hash.to_json)
    end
  
    it "should save the json if it is valid and respond with 201 Created" do
      post :create, :json => @json_hash.to_json
      response.response_code.should == 201 #<= 201 Created 
    end 
  
    it "should return the json object that it just saved if the save was successful" do
      post :create, :json => @json_hash.to_json
      response.body.should_not be_nil
      response_json = response.body
      JSON[response_json]['bozon']['content'].should == @json_hash.to_json
    end
  
    it "should exist in the database after being created" do
      post :create, :json => @json_hash.to_json
      response_json = response.body
      new_bozon = Bozon.find(JSON[response_json]['bozon']['id'])
      new_bozon.content.should == @json_hash.to_json    
    end

    it "should respond with 422 Unprocessable Entity if the json is invalid" do
      @json_hash.delete(:content) #<= Invalidate the JSON
      post :create, :json => @json_hash.to_json #<= 422 result
      response.response_code.should == 422
    end    
  end
  
  describe "handling GET /bozons" do
    it "should return the newest existing bozon with an id"
    it "should return a list of all newest bozons without an id"
    it "should return a specific bozon version with an id and version"
    it "should 404 on a non-exsiting bozon"
  end
  
  describe "handling PUT /bozons" do
    it "should save the updated record and respond with 201 Created"
    it "should increment the version of an updated record"
    it "should not change the id of the updated record"
    it "should contain a revision number"
  end
  
end
