module ApplicationHelper
  include Pagy::Frontend

  def flash_message(message, bootstrap_classname)
    tag.div(class: class_names('alert', bootstrap_classname, 'alert-dismissible', 'fade', 'show'), role: 'alert') do
      concat message
      concat tag.button(class: 'btn-close', 'data-bs-dismiss' => 'alert', 'aria-label' => 'Close')
    end
  end
end
