require File.dirname(__FILE__) + '/../spec_helper'

describe BozonsController, "creating a new bozon" do
  before(:each) do 
    @json_str = { :version => 0,
                  :type => :datatype,
                  :name => 'String',
                  :content => [
                    {:label => 'String'},
                    {:class => 'String'}
                  ] 
                }
    @yr_dt_str = YRDatatype.new(@json_str.to_json)
  end
  
  it "should save the json if it is valid" do
    post :create, :json => @json_str.to_json
  end 
  
end