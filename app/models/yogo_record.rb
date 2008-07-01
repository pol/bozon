require 'json'
require 'uuidtools'
class YogoRecord
  attr_accessor :_rev, :_id, :_type, :content

  include Validateable
  validates_presence_of :_rev
  validates_presence_of :_id
  validates_presence_of :_type
  validates_presence_of :content
  validates_format_of :_type, :with => /(datatype)|(datamodel)|(datarecord)/
  validates_numericality_of :_rev

  def validate
    unless [Array,Hash].include?(content.class)
      errors.add_to_base('The :content must be a Hash or Array')
    end
  end
  
  def initialize(json = '')
    @_rev, @_id, @_type, @content = '','','',[{}]
    unless json.empty?
      @_rev = JSON[json]['_rev']
      @_id = JSON[json]['_id']
      @_type = JSON[json]['_type']
      @content = JSON[json]['content']
    end
    
    if @_id.nil? or @_id.empty?
      @_id = UUID.random_create.to_s
    end
    
    if @_rev.nil?
      @_rev = 0
    end

  end

  def self.build(json)
    case JSON[json]['_type']
      when 'datatype'
        YRDatatype.new(json)
      when 'datamodel'
        YRDatamodel.new(json)
      when 'datarecord'
        YRDatarecord.new(json)
      else
        self.new(json)        
    end
  end


  def to_json
    { :_rev => @_rev,
      :_id => @_id,
      :_type => @_type,
      :content => @content
      }.to_json
  end

  # This might need to happen if the data items need to be immutable
  # def index
  #   YogoRecordIndex.new(@_id, @_rev)
  # end

end