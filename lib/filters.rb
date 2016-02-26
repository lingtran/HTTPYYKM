module Filters
  def filter_verb
    @request_lines[0].split[0]
  end

  def filter_path
    filter_path = @request_lines[0].split[1]
    if filter_path.split("?")[0].include?("/word_search")
      filter_path = filter_path.split("?")[0]
    else
      filter_path
    end
  end

  def filter_protocol
    @request_lines[0].split[2]
  end

  def filter_host
    @request_lines.find { |element| element if element.include?("Host:") }.split(":")[1].lstrip
  end

  def filter_parameter
    @request_lines[0].split[1].split("?")[1].split("=")[0]
  end

  def filter_value
    @request_lines[0].split[1].split("?")[1].split("=")[1].downcase
  end
end
