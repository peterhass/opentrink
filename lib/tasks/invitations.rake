desc "List invitations with easy access paths. Call with RAILS_ENV=production to get full links"
task invitations: :environment do
  url_helpers = Rails.application.routes.url_helpers
  Invitation.all.newest_first.activated.each do |invitation|
    parts = []

    parts << "[Admin]" if invitation.admin?
    parts << "[Bar]" if invitation.bar?
    parts << begin 
               # url helper might throw if env config is missing host
               url_helpers.new_invitation_user_url(invitation) 
             rescue 
               url_helpers.new_invitation_user_path(invitation)
             end

    puts parts.join(" ")
  end
end
