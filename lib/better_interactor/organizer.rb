
module Interactor::Organizer
  # Internal: Interactor::Organizer instance methods.
  module InstanceMethods
    # Internal: Invoke the organized Interactors. An Interactor::Organizer is
    # expected not to define its own "#call" method in favor of this default
    # implementation.
    #
    # Returns nothing.
    def call
      self.class.organized.each do |interactor|
        callable(interactor).call!(context) if should_call? interactor
      end
    end

    def callable(interactor)
      interactor.is_a?(Hash) ? interactor[:class] : interactor
    end

    def should_call?(interactor)
      if interactor.is_a?(Hash)
        interactor[:if].nil? || send(interactor[:if])
      else
        condition = interactor.default_condition_name.to_sym
        !respond_to?(condition) || send(condition)
      end
    end
  end

  module ClassMethods
  end
end
