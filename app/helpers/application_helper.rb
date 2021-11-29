# frozen_string_literal: true

module ApplicationHelper
  def bookmark_errors_for(object = nil)
    render('shared/bookmark_errors', object: object) unless object.blank?
  end

  def flash_class(level)
    case level
    when :notice then 'alert alert-info'
    when :success then 'alert alert-success'
    when :error then 'alert alert-error'
    when :alert then 'alert alert-error'
    end
  end
end
