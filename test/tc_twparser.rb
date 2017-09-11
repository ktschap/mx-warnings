require_relative "../twparser"
require "test/unit"
 
class TestTwparser < Test::Unit::TestCase
 
  def test_valid_xml_input
    parser = Twparser.new(File::read("tw_test_input_090317.xml"))
    w = parser.get_mexico_warnings
    assert_not_nil(w.intro)
    # 31 states and DF
    check_state_presence(w)
    assert_equal(32,w.warnings.length)
  end
  
  private
 
  @@EXPECTED_STATES = [
    'Aguascalientes', 'Chihuahua', 'Colima',
    'Baja California', 'Baja California Sur',
    'Chiapas', 'Oaxaca',
    'Durango',
    'Estado de Mexico',
    'Coahuila',
    'Tabasco',
    'Campeche',
    'Tlaxcala',
    'Veracruz',
    'Yucatan',
    'Zacatecas'
  ]
  
  def check_state_presence(w)
    @@EXPECTED_STATES.each do | curr_state |
      rw = w.get_region_warning(curr_state)
      assert_not_nil(curr_state, rw)
      puts rw.region
      puts rw.region_full_desc
      puts rw.warning
    end
  end
 
end
