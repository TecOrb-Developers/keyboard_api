ActiveAdmin.register_page "Upload CSV" do

  content title: "Upload CSV" do
    # div class: "blank_slate_container", id: "dashboard_default_message" do
  #     span class: "blank_slate" do
  #       span I18n.t("active_admin.dashboard_welcome.welcome")
  #       small I18n.t("active_admin.dashboard_welcome.call_to_action")
  #     end
    # end

    # Here is an example of a simple dashboard with columns and panels.
    #
    columns do
      column do 
        h4 "Please upload csv in this format otherwise data may be inconsistent."
        #h2 "MainCar Csv"
        render partial: 'admin/new.html.erb' #,locals: { :@interest_data =>   @interest_data}
        # br
        # br
        # h2 "Fema Code CSV"
        # render partial: 'admin/fema_csv_format'
      end
    end
    columns do
      column do
         # render partial: 'admin/users_country_chart'#,locals: { :@interest_data =>   @interest_data}
      end
    end
    # columns do
    #   column do
    #     panel "Recent Events" do
    #       ul do
    #         Event.last(5).map do |event|
    #           li link_to(event.title, admin_event_path(event))
    #         end
    #       end
    #     end
    #   end

    #   column do
    #     panel "Info" do
    #       para "Welcome to ActiveAdmin."
    #     end
    #   end
    # end
  end # content
end
