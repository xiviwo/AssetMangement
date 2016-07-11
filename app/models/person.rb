class Person < ActiveRecord::Base

 fields do
    name            :string
    gender          enum_string('','男','女')
    identity        :string
    date_of_birth   :date
    timestamps
  end
  
    
validates_numericality_of :identity,:message => "这不是一个数字，请检验",:allow_blank => true
validates_format_of :identity, :with => /\A^(\d{6})(18|19|20)?(\d{2})([01]\d)([0123]\d)(\d{3})(\d|X)?$\Z/i,:message => "身份证格式不对，位数/数字",:allow_blank => true
  


end
