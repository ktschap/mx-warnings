class WarningController < ApplicationController
  def display_regions
    @all_warnings = TravelWarning.all
  end
  
  def display
    @travel_warning = TravelWarning.find(params[:id])
  end
end
