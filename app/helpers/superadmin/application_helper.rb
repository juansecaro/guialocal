module Superadmin::ApplicationHelper
  def change_current_city(val)
    Config.first.city = val
    $current_city = val
  end
end
