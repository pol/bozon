require File.dirname(__FILE__) + '/../spec_helper'

describe YRDatarecord do
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
                
    @json_dr = { :_rev => 0,
                 :_id => 'FirstRecord',
                 :_type => :datarecord,
                 :datamodel_id => 'Person',
                 :content => [
                   {:first_name => 'Yogo'},
                   {:last_name => 'Datastore'},
                   {:num_items => 3}
                 ]
               }
  end
  
  it "should be valid with valid data" do
    @yogo = YRDatarecord.new(@json_dr.to_json)
    @yogo.should be_valid
  end
  
  it "should validate like a YogoRecord " do
    @json_str.delete(:_type)
    @yr = YogoRecord.new(@json_str.to_json)
    @yr.should_not be_valid
    @yogo = YRDatarecord.new(@json_str.to_json)
    @yogo.should_not be_valid
  end
  
  it "should have a :datamodel_id that references an existing datamodel"
  it "should have content elements in the same order as the datamodel elements"

end
  