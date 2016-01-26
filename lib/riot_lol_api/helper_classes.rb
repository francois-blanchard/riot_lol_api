module RiotLolApi
  module HelperClass
    # Instance methods
    def list_methods
      self.class.instance_methods(false).map(&:to_sym)
    end

    # Class methods
    def self.included(object)
      object.extend(ClassMethods)
    end

    module ClassMethods
      def list_methods
        instance_methods(false).map(&:to_sym)
      end
    end
  end
end
