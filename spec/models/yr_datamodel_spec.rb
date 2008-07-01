require File.dirname(__FILE__) + '/../spec_helper'

describe YRDatamodel do
  before(:each) do
    # Required data members
    # version
    # type {:datatype => "Basic Data Definition", :datamodel => "Model Component", :datarecord => "Actual Piece of Data"}
    # content
    @json_str = { :_rev => 0,
                  :_id => 'String',
                  :_type => :datatype,
                  :content => [
                    {:label => 'String', :class => 'String'}
                  ] 
                }
                
    @json_int = { :_rev => 0,
                  :_id => 'Integer',
                  :_type => :datatype,
                  :content => [
                    {:label => 'Integer', :class => 'Integer'}
                  ] 
                }
  
    @json_dm = { :_rev => 0,
                 :_id => 'Person',
                 :_type => :datamodel,
                 :content =>  [
                   {:label => 'first_name', :datatype_id => 'String'},
                   {:label => 'last_name', :datatype_id => 'String'},
                   {:label => 'num_items', :datatype_id => 'Integer'},
                 ]
                }
  end
  
  it "should be valid with valid data" do
    @yogo = YRDatamodel.new(@json_dm.to_json)
    @yogo.should be_valid
  end
  
  it "should validate like a YogoRecord " do
    @json_dm.delete(:_type)
    @yr = YogoRecord.new(@json_dm.to_json)
    @yr.should_not be_valid
    @yogo = YRDatamodel.new(@json_dm.to_json)
    @yogo.should_not be_valid
  end
  
  it "should have content that is an array of label, datatype_id hashes"
  
  it "should only reference datatypes that exist in the datastore"

end
  