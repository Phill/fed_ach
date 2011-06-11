require 'open-uri'
class FedACH
  unless const_defined?(:VERSION)
    VERSION = '0.0.1'
  end

  def initialize(data_file = nil)
    return false if data_file.nil?
    return false unless @data = open(data_file)
  end

  def fields
    {
      # Field Name        Start At, Count
      :routing_number      => [  1,  9],
      :office_code         => [ 10,  1],
      :servicing_fbr       => [ 11,  9],
      :record_type         => [ 20,  1],
      :change_date         => [ 21,  6],
      :new_routing_number  => [ 27,  9],
      :customer_name       => [ 36, 36],
      :address             => [ 72, 36],
      :city                => [108, 20],
      :state               => [128,  2],
      :zip                 => [130,  5],
      :zip_ext             => [135,  4],
      :phone_area_code     => [139,  3],
      :phone_prefix        => [142,  3],
      :phone_suffix        => [145,  4],
      :institution_status  => [149,  1],
      :data_view_code      => [150,  1],
      :filler              => [151,  5]
    }
  end

  def parse
    return_data = []
    @data.each do |line|
      return_data << parse_line(line)
    end
    return_data
  end

  def parse_line(line)
    return_parsed_line = {}
    fields.each do |k, f|
      return_parsed_line[k] = line.slice(f[0]-1, f[1]).strip
    end
    return_parsed_line
  end

end

