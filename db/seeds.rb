invitation = Invitation.create!(role: :admin)
puts "Root invitation created:"
puts "/invitations/#{invitation.id}/users/new"
puts invitation.attributes.to_yaml
