
module Interactor
  module Organizer
    module InstanceMethods
      # Internal: Invoke the organized Interactors. An Interactor::Organizer is
      # expected not to define its own "#call" method in favor of this default
      # implementation.
      #
      # Returns nothing.
      def call
        self.class.organized.each do |interactor|
          handle_call(interactor) if should_call? interactor
        end
      end

      def handle_call(interactor)
        to_call = interactor.is_a?(Hash) ? interactor[:class] : interactor
        to_call.is_a?(Symbol) ? send(to_call) : to_call.call!(context)
      end

      def should_call?(interactor)
        if interactor.is_a?(Hash)
          interactor[:if].nil? || send(interactor[:if])
        else
          condition = condition_for interactor
          !respond_to?(condition) || send(condition)
        end
      end

      def condition_for(interactor)
        interactor.is_a?(Symbol) ? "can_#{interactor}}?" : interactor.default_condition_name
      end
    end
  end
end
