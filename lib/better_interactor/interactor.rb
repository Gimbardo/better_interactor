module Interactor
  module ClassMethods
    def default_condition_name
      "can_#{self.name.underscore.gsub("/", "_")}?"
    end
  end
end
