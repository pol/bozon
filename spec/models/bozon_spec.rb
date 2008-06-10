require File.dirname(__FILE__) + '/../spec_helper'

describe Bozon do
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
                
    @json_int = { :version => 0,
                  :type => :datatype,
                  :name => 'Integer',
                  :content => [
                    {:label => 'Integer'},
                    {:class => 'Integer'}
                  ] 
                }
    @yr_dt_int = YRDatatype.new(@json_int.to_json)
  
    @json_dm = { :version => 0,
                 :type => :datamodel,
                 :name => 'Person',
                 :content =>  [
                   {:label => 'first_name', :datatype => 'String'},
                   {:label => 'last_name', :datatype => 'String'},
                   {:label => 'num_items', :datatype => 'Integer'},
                 ]
                }
    @yr_dm = YRDatamodel.new(@json_dm.to_json)
                
    @json_dr = { :version => 0,
                 :type => :datarecord,
                 :name => 'Person',
                 :content => [
                   {:first_name => 'Yogo'},
                   {:last_name => 'Datastore'},
                   {:num_items => 3}
                 ]
               }
    @yr_dr = YRDatarecord.new(@json_dr.to_json)
        
  end
  
  it "should contain a YogoRecord when it's content is set" do
    @bozon = Bozon.new(:content => @yr_dt_str.to_json)
    @bozon.yr_content.should_not be_nil
  end

  it "should be valid if the data to insert is valid" do
    @bozon = Bozon.new(:content => @yr_dt_str.to_json)
    @yr_dt_str.should be_valid
    @bozon.yr_content.should be_valid
    @bozon.should be_valid
  end
   
  it "should contain a YRDatatype if it is sent a datatype json" do
    @bozon = Bozon.new(:content => @yr_dt_str.to_json)
    @bozon.yr_content.class.should == YRDatatype
  end

  it "should contain a YRDatamodel if it is sent a datamodel json" do
    @bozon = Bozon.new(:content => @yr_dm.to_json)
    @bozon.yr_content.class.should == YRDatamodel
  end

  it "should contain a YRDatarecord if it is sent a datarecord json" do
    @bozon = Bozon.new(:content => @yr_dr.to_json)
    @bozon.yr_content.class.should == YRDatarecord
  end

  it "should contain a YogoRecord if it is sent a yogorecord json without a type, but it should be invalid" do
    @json_dr.delete(:type)
    @bozon = Bozon.new(:content => @json_dr.to_json)
    @bozon.yr_content.class.should == YogoRecord
    @bozon.yr_content.should_not be_valid
  end

end
  