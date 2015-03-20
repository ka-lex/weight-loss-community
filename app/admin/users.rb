ActiveAdmin.register User do
  filter :email
  filter :username

  index do
      column :email do |user|
        link_to user.email, admin_user_path(user)
      end
      column :username
      column :sign_in_count
      column :last_sign_in_at
      column :created_at
      column :confirmation_token
      column :invitation_token
      column :age
      column :sex
      column :size
      column :id
    end
  
   sidebar :help, :only => :show do
    ul do
      li "Second List First Item"
      li "Second List Second Item"
    end
  end
end
