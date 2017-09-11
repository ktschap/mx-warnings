Rails.application.routes.draw do
  get 'warning/display'
  get 'warning/display_regions'
  root 'warning#display_regions'
end
