require 'test/unit'
require 'fed_ach'

class FedACHTest < Test::Unit::TestCase

  def setup
    @data = FedACH.new(File.dirname(__FILE__) + '/fixtures/sample_data').parse;
  end

  def test_initalize
    assert @data
  end

  def test_customer_name
    assert_equal 'FEDERAL RESERVE BANK', @data[0][:customer_name]
    assert_equal 'STATE STREET BANK AND TRUST COMPANY', @data[1][:customer_name]
  end

  def test_address
    assert_equal '1000 PEACHTREE ST N.E.', @data[0][:address]
    assert_equal 'ONE LINCOLN STREET', @data[1][:address]
  end

end

