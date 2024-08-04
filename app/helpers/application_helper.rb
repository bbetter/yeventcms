# app/helpers/application_helper.rb
module ApplicationHelper
    def percentage(part, total)
        return 0 if total == 0
        (part.to_f / total.to_f * 100).round(2)
    end
end
