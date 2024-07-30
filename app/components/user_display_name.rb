class UserDisplayName < ViewComponent::Base
  erb_template <<~ERB
    <span class="<%= classes %>">
      <span class="truncate"><%= user.name %></span>
      <span><%= role %></span>
    </span>
  ERB

  def initialize(user, role_label: true)
    @user = user
    @role_label = role_label
    super
  end

  private

  attr_reader :user

  def role
    return nil unless @role_label
    return '(Admin)' if user.admin?

    '(Bar)' if user.bar?
  end

  def classes
    Opentrink::Clsx.call(%w[inline-grid
                            grid-cols-[1fr_auto]
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
