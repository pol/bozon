class Bozon < ActiveRecord::Base

  attr_accessor :yr_content
  
  validates_presence_of :content 
  
  def content=(json)
    @yr_content = YogoRecord.build(json)
    write_attribute(:content, json)
  end

  def validate
    unless @yr_content.valid?
      errors.add_to_base("Content must be a valid YogoRecord json object.")
      self.content << {'errors' => errors.full_messages}.to_json
    end
  end
end
