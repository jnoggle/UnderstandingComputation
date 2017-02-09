class Sign < Struct.new(:name)
    NEGATIVE, ZERO, POSITIVE, UNKNOWN = [:negative, :zero, :postive, :unknown].map { |name| new(name) }

    def inspect
        "#<Sign #{name}>"
    end

    def *(other_sign)
        if [self, other_sign].include?(ZERO)
            ZERO
        elsif [self, other_sign].include?(UNKNOWN)
            UNKNOWN
        elsif self == other_sign
            POSITIVE
        else
            NEGATIVE
        end
    end

    def +(other_sign)
        if self == other_sign || other_sign == ZERO
            self
        elsif self == ZERO
            other_sign
        else
            UNKNOWN
        end
    end

    def <=(other_sign)
        self == other_sign || other_sign == UNKNOWN
    end
end

class Numeric
    def sign
        if self < 0
            Sign::NEGATIVE
        elsif zero?
            Sign::ZERO
        else
            Sign::POSITIVE
        end
    end
end