module Nacre::Amountable

    private

    # Six significant decimal places should prevent
    # floating point errors
    def protect_number(amount)
      (amount.to_f * 1000000).to_i
    end

    def unprotect_number(amount)
      (amount.to_f / 1000000)
    end

end
