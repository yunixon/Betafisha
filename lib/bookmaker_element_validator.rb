class BookmakerElementValidator < ActiveModel::EachValidator
  def validate_each(object, attribute, value)
    unless object.class.where(:element_name => value, :table_name => object.table_name).empty?
      object.errors[attribute] << (options[:message] || "not unique element")
    end
  end
end