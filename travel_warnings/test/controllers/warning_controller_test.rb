require 'test_helper'

class WarningControllerTest < ActionDispatch::IntegrationTest

  test "should get display regions" do
    get warning_display_regions_url
    assert_response :success
    assert_equal 2, TravelWarning.count
    assert_select "title", "Travel Warnings for Mexico"
    assert_select "li", travel_warnings(:one).name
    assert_select "li", travel_warnings(:two).name
  end

  test "should get display for single region with different full name" do
    load_single_warning("1", :one)
    assert_select "h3", travel_warnings(:one).fullname
  end
  
  test "should get display for single region with same full name" do
    load_single_warning("2", :two)
    assert_select "h3", false
  end
  
  private
  
  def load_single_warning(id, fixture)
    get warning_display_url + "?id=" + id
    assert_response :success
    assert_select "title", "Advisory for " + travel_warnings(fixture).name 
    assert_select "h2", travel_warnings(fixture).name
  end
end
