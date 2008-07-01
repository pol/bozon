require File.dirname(__FILE__) + '/../spec_helper'

describe Bozon do
  before(:each) do
    @json_str = { :_rev => 0,
                  :_id => 'String',
                  :_type => :datatype,
                  :content => [
                    {:label => 'String'},
                    {:class => 'String'}
                  ] 
                }
                
    @json_int = { :_rev => 0,
                  :_id => 'Integer',
                  :_type => :datatype,
                  :content => [
                    {:label => 'Integer'},
                    {:class => 'Integer'}
                  ] 
                }
  
    @json_dm = { :_rev => 0,
                 :_id => 'Person',
                 :_type => :datamodel,
                 :content =>  [
                   {:label => 'first_name', :datatype => 'String'},
                   {:label => 'last_name', :datatype => 'String'},
                   {:label => 'num_items', :datatype => 'Integer'},
                 ]
                }
                
    @json_dr = { :_rev => 0,
                 :_id => 'Person',
                 :_type => :datarecord,
                 :content => [
                   {:first_name => 'Yogo'},
                   {:last_name => 'Datastore'},
                   {:num_items => 3}
                 ]
               }
        
  end
  
  it "should contain a YogoRecord when it's content is set" do
    @bozon = Bozon.new(:content => @json_str.to_json)
    @bozon.yr_content.should_not be_nil
  end

  it "should be valid if the data to insert is valid" do
    @bozon = Bozon.new(:content => @json_str.to_json)
    @yr = YogoRecord.build(@json_str.to_json)
    @yr.should be_valid
    @bozon.yr_content.should be_valid
    @bozon.should be_valid
  end
   
  it "should contain a YRDatatype if it is sent a datatype json" do
    @bozon = Bozon.new(:content => @json_str.to_json)
    @bozon.yr_content.class.should == YRDatatype
  end

  it "should contain a YRDatamodel if it is sent a datamodel json" do
    @bozon = Bozon.new(:content => @json_dm.to_json)
    @bozon.yr_content.class.should == YRDatamodel
  end

  it "should contain a YRDatarecord if it is sent a datarecord json" do
    @bozon = Bozon.new(:content => @json_dr.to_json)
    @bozon.yr_content.class.should == YRDatarecord
  end

  it "should contain a YogoRecord if it is sent a yogorecord json without a type, but it should be invalid" do
    @json_dr.delete(:_type)
    @bozon = Bozon.new(:content => @json_dr.to_json)
    @bozon.yr_content.class.should == YogoRecord
    @bozon.yr_content.should_not be_valid
  end

  it "should retain an explicitly set _id after being saved"

end
  