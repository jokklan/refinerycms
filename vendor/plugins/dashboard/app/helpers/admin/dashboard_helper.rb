module Admin::DashboardHelper

  def activity_message_for(record)
    #TODO Update translation & translate message properly
    if (activity = Refinery::Plugins.active.find_activity_by_model(record.class)).present? and activity.title.present?
      # work out which action occured
      action = record.updated_at.eql?(record.created_at) ? "created" : "updated"

      #get article to define gender of model name, some lang have it
      article = t("plugins.#{record.class.name.pluralize.downcase}.article", :default => 'the')

      # now create a link to the notification's corresponding record.
      link_to t(".last_activity_mensage", :what => record.send(activity.title),

                                  :kind => record.class.human_name,
                                  :action => t("#{action}.with_article \"#{article}\"")).downcase.capitalize,
              eval("#{activity.url}(#{activity.nesting("record")}record)")
    end
  end

end
