module UiHelper
  def clsx_flatten_classes(*args)
    args.flatten.reduce([]) do |acc, arg|
      next acc if arg.blank? || arg.is_a?(TrueClass)

      if arg.is_a?(Hash)
        arg.each { |key, value| acc << key if value }
        next acc
      end

      acc << arg.to_s
      next acc
    end.uniq
  end

  def clsx(*args)
    clsx_flatten_classes(*args) * ' '
  end

  def primary_button_class
    clsx(%w[
           unstyled
           text-white
           bg-blue-700
           hover:bg-blue-800
           text-center
           focus:ring-4
           focus:ring-blue-300
           font-medium
           rounded-lg
           text-sm
           px-5 py-2.5
           me-2 mb-2
           focus:outline-none
           dark:focus:ring-blue-800
         ])
  end
end
