module UiHelper
  def clsx(*args)
    Opentrink::Clsx.call(*args)
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
         ])
  end

  def danger_button_class
    clsx(%w[
           unstyled
           text-white
           bg-red-700
           hover:bg-red-800
           text-center
           focus:ring-4
           focus:ring-red-300
           font-medium
           rounded-lg
           text-sm
           px-5 py-2.5
           me-2 mb-2
           focus:outline-none
         ])
  end

  def alternative_button_class
    clsx(%w[

           text-blue-700
           hover:text-white
           border
           border-blue-700
           hover:bg-blue-800
           focus:ring-4
           focus:outline-none
           focus:ring-blue-300
           font-medium
           rounded-lg
           text-sm
           px-5
           py-2.5
           text-center
           me-2
           mb-2
         ])
  end
end
