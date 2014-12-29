module Nacre::Amountable

    private

    def protect_number(amount)
      (amount.to_f * multiplier).to_i
    end

    def unprotect_number(amount)
      (amount.to_f / multiplier)
    end

    def multiplier
      ('1' + '0' * Nacre.configuration.value_precision.to_i).to_i
    end
end
