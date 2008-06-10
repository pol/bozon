class Bozon < ActiveRecord::Base

  attr_accessor :yr_content
  
  def content=(json)
    @yr_content = YogoRecord.build(json)
    @content = json
  end

  def validate
    unless @yr_content.valid?
      errors.add_to_base("Content must be a valid YogoRecord json object.")
    end
  end
end
