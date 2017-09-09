require 'nokogiri'

class Twparser
  def initialize(warning_file)
    @twdoc = Nokogiri::XML(warning_file)
  end

  def get_mexico_warnings
    items = @twdoc.xpath("//item")
    items.each do | warning |
      warning_details = warning.children
      warning_details.each do | detail |
        if detail.name == "identifier"
          if detail.content.to_s.strip == "MX"
            return process_item(warning)
          end
        end
      end
    end
  end

  private

  def process_item(item)
    details = item.children
    details.each do | detail |
      if detail.name == "description"
        return parse_description(detail.content.to_s)
      end
    end
  end

  def parse_description(desc)
    warnings = Array.new
    strs = desc.split("><p><b>")
    mx_warnings = MexicoWarnings.new
    mx_warnings.add_to_intro = strs[0]
    mx_warnings.add_to_intro = strs[1]
    strs.shift
    strs.shift
    strs.each do | str |
      parts = str.partition(":")
      mx_warnings.add_warning = RegionalWarning.new(parts[0],parts[2])
    end
    return mx_warnings
  end
end

class MexicoWarnings
  attr_reader :intro
  
  def initialize()
    @warnings = Array.new
  end
  
  def add_to_intro=(next_snippet)
    @intro = @intro.to_s + next_snippet
  end
  
  def add_warning=(next_warning)
    @warnings.push next_warning 
  end
  
  def get_region_warning(region_name)
    @warnings.each do | warning |
      if warning.region == region_name
        return warning
      end
    end
    return nil
  end
  
  def warnings
    @warnings
  end
end

class RegionalWarning
  def initialize(region_name, warning_html)
    @region_name = region_name.split('(')[0].strip
    @region_full_desc = region_name
    @warning_html = warning_html
  end

  def region
    @region_name
  end
  
  def region_full_desc
    @region_full_desc
  end
  
  def warning
    @warning_html
  end
end