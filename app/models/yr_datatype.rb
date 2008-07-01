class YRDatatype < YogoRecord
  
  validates_format_of :_type, :with => /datatype/
  validates_presence_of :datatype_label 
  validates_presence_of :datatype_class
  
  def datatype_label()
    @content.find { |c| !c['label'].nil? } if @content
  end
  
  def datatype_class()
    @content.find { |c| !c['class'].nil? } if @content
  end
  
  
end