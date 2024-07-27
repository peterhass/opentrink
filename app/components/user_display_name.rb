class UserDisplayName < ViewComponent::Base
  erb_template <<~ERB
    <span class="<%= classes %>">
      <%= text %>
    </span>
  ERB

  def initialize(user)
    @user = user
    super
  end

  private

  attr_reader :user

  def text
    return "#{user.name} (Admin)" if user.admin?
    return "#{user.name} (Bar)" if user.bar?

    user.name
  end

  def classes
    Opentrink::Clsx.call(%w[inline-flex
                            item-baseline
                            rounded-md
                            px-2
                            py-1
                            text-md
                            font-medium
                            ring-1
                            ring-inset
                            ring-gray-500/10],
                         %w[bg-red-50 text-red-800] => user.admin?,
                         %w[bg-purple-50 text-purple-800] => user.bar?)
  end
end
