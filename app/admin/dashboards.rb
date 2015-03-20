ActiveAdmin.register_page "Dashboard" do

  # Define your dashboard sections here. Each block will be
  # rendered on the dashboard in the context of the view. So just
  # return the content which you would like to display.
  
  # == Simple Dashboard Section
  # Here is an example of a simple dashboard section
  #
  menu :priority => 1, :label => proc{ I18n.t("active_admin.dashboard") }

  content :title => proc{ I18n.t("active_admin.dashboard") } do
    div :class => "blank_slate_container", :id => "dashboard_default_message" do
      span :class => "blank_slate" do
        span I18n.t("active_admin.dashboard_welcome.welcome")
        small I18n.t("active_admin.dashboard_welcome.call_to_action")
      end
    end

    columns do
      column do
        panel "Info" do
          para "Welcome to ActiveAdmin."
        end
      end
    end

    columns do
      column do
        panel "Users" do
          table_for User.limit(20).reverse_order.each do |user|
            column(:username) {|user| link_to user.username, admin_user_path(user)}
            
          end
        end
      end

    end


  end


  #    section "Recent Users" do
  #      ul do
  #        User.limit(20).reverse_order.collect do |user|
  #          li link_to(user.username, admin_user_path(user))
  #        end
  #      end
  #    end

  #  section "Recent Groups" do
  #      ul do
  #        Group.limit(20).reverse_order.collect do |group|
  #          li link_to(group.name, admin_group_path(group))
  #        end
  #      end
  #    end

  # section "Recent Targets" do
  #      ul do
  #        Target.limit(20).reverse_order.collect do |target|
  #          li link_to(target.title, admin_target_path(target))
  #        end
  #      end
  #    end

  #  section "Recent Messages" do
  #      ul do
  #        Message.limit(20).reverse_order.collect do |message|
  #          li link_to(truncate(message.body, :length => 50), admin_message_path(message))
  #        end
  #      end
  #    end

  #    section "Recent Accounts" do
  #      ul do
  #        Account.limit(20).reverse_order.collect do |account|
  #          li link_to(account.user.username, admin_account_path(account))
  #        end
  #      end
  #    end

end
