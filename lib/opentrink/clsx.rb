module Opentrink
  class Clsx
    def self.call(*args)
      new.join(*args)
    end

    def join(*args)
      reduce_classes!([], *args) * ' '
    end

    private

    def reduce_classes!(acc, *args) # rubocop:disable Metrics/CyclomaticComplexity
      args.reject(&:blank?).each do |arg|
        case arg
        when Hash
          arg.each do |key, value|
            reduce_classes!(acc, key) if value
          end
        when Array
          reduce_classes!(acc, *arg)
        when Symbol, String
          acc << arg.to_s
        end
      end

      acc.uniq
    end
  end
end
