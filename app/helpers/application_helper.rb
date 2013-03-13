module ApplicationHelper
  def action_form_for record, action, options = {}, &proc
    class_name = record.class.name.underscore
    
    case action
    when :create
      options[:html] ||= {}
      options[:html][:class] ||= "new_#{class_name}"
      options[:html][:id]    ||= "new_#{class_name}_#{record.id}"
    when :update
      options[:html] ||= {}
      options[:html][:class] ||= "edit_#{class_name}"
      options[:html][:id]    ||= "edit_#{class_name}_#{record.id}"
    end # case
    
    form_for record, options, &proc
  end # method action_form_for
end # helper ApplicationHelper
