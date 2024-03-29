module StringValidator
    def self.numeric?(string)
      string.match?(/\A\d+\z/)
    end
  end