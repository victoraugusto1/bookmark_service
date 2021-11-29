module ApplicationHelper
    def bookmark_errors_for(object=nil)
        render('shared/bookmark_errors', object: object) unless object.blank?
    end
end
