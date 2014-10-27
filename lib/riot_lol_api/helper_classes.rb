module RiotLolApi
  module HelperClass
    def list_methods
      self.class.instance_methods(false).map{|i| i.to_sym}
    end
  end
end
