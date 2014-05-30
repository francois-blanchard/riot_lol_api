class String
  def to_symbol
    self.gsub(/([a-z\d])([A-Z])/,'\1_\2').downcase.to_sym
  end
end