class String
  def to_underscore
    gsub(/([a-z\d])([A-Z])/, '\1_\2').downcase
  end


  def to_camel
    split("_").inject([]) do |memo, char|
      memo.push(memo.empty? ? char : char.capitalize)
    end.join
  end
end
