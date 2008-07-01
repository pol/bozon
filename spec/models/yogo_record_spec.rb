require File.dirname(__FILE__) + '/../spec_helper'

describe YogoRecord do
  before(:each) do
    # Required data members
    # _id: the unique id of this record, this is just a string, but it must be unique
    # _rev: the version of this bozon record
    # type {:datatype => "Basic Data Definition", :datamodel => "Model Component", :datarecord => "Actual Piece of Data"}
    # content:  payload content for this *type*
    @json_hash = {
                :_rev => 0,
                :_id => 'piratemonkey',
                :_type => :datarecord,
                :content => {
                  :first_name => 'Yogo',
                  :last_name => 'DataPile'
                }
              }
  end
  
  it "should be a valid yogo_record if it has an _id, _rev, type and content" do
    @yogo = YogoRecord.new(@json_hash.to_json)
    @yogo._id.should_not be_nil
    @yogo._rev.should_not be_nil
    @yogo._type.should_not be_nil
    @yogo.content.should_not be_nil
    @yogo.should be_valid
  end

  it "a new record will automatically supply a version of 0 if one is not set" do
    @json_hash.delete(:_rev)
    @json_hash[:_rev].should be_nil
    @yogo = YogoRecord.new(@json_hash.to_json)
    @yogo._rev.should == 0
  end

  it "should be an invalid yogo_record if the version is non-numerical" do
    @json_hash[:_rev] = 'foo'
    @yogo = YogoRecord.new(@json_hash.to_json)
    @yogo.should_not be_valid
  end

  it "should be a valid yogo_record if the version is a numerical string" do
    @json_hash[:_rev] = '0'
    @yogo = YogoRecord.new(@json_hash.to_json)
    @yogo.should be_valid
  end

  it "should be an invalid yogo_record if it is missing a type" do
    @json_hash.delete(:_type)
    @json_hash[:_type].should be_nil
    @yogo = YogoRecord.new(@json_hash.to_json)
    @yogo.should_not be_valid
  end

  it "should be an invalid yogo_record if it is missing a content" do
    @json_hash.delete(:content)
    @json_hash[:content].should be_nil
    @yogo = YogoRecord.new(@json_hash.to_json)
    @yogo.should_not be_valid
  end
  
  it "should have content which is an array or hash" do
    @yogo = YogoRecord.new(@json_hash.to_json)
    [Array,Hash].should include(@yogo.content.class)
  end
  
  it "should not be valid if the content is not an array or hash" do
    @json_hash[:content] = 'This is not an array or hash.'
    @yogo = YogoRecord.new(@json_hash.to_json)
    @yogo.should_not be_valid
  end
  
  it "should respond to a to_json method which returns a json string" do
    @yogo = YogoRecord.new(@json_hash.to_json)
    @yogo.should respond_to('to_json')
    @yogo.should be_valid
    @yogo.to_json.should_not be_empty # this may be empty if the YR is invalid
  end
  
  
  it "should create a UUID for an _id if one is not explicitly set" do
    @json_hash.delete(:_id)
    @yogo = YogoRecord.new(@json_hash.to_json)
    @yogo._id.should_not be_nil
  end
  
  it "should respond to build" do
    YogoRecord.should respond_to('build')
  end
  
  it "should build a YogoRecord of an appropriate type when given a json record with the type set properly" do
    @json_hash[:_type].should == :datarecord
    @yogo = YogoRecord.build(@json_hash.to_json)
    #@yogo.should be_valid
    #1@yogo._type.should == :datarecord
  end
end
  