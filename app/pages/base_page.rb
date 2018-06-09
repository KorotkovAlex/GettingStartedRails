class BasePage
  #What is Dry and why a option is not work in paginated _list?

  extend Dry::Initializer

  alias read_attribute_for_serialization send
end
