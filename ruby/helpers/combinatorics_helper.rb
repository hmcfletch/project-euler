class CombinatoricsHelper

  class << self

    def factorial(n)
      (1..n).inject(1) { |memo, i| memo = memo * i }
    end

    def n_choose_k(n, k)
      factorial(n) / (factorial(k) * factorial(n - k))
    end

    def n_multichoose_k(n, k)
      n_choose_k((n + k - 1), k)
    end

    def power_set(set)
      ret = set.class[set.class[]]
      set.each do |s|
          deepcopy = ret.map { |x| set.class.new(x) }
          deepcopy.map { |r| r << s }
          ret = ret + deepcopy
      end
      return ret
  end

  end
end
