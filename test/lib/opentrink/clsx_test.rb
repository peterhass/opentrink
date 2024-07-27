require 'test_helper'

class OpentrinkClsxTest < ActiveSupport::TestCase
  test 'flat_array' do
    assert_equal(Opentrink::Clsx.call(%w[one two three]), 'one two three')
  end

  test 'array with hash' do
    assert_equal(Opentrink::Clsx.call(
                   %w[one two three],
                   { 'four' => true, 'five' => false }
                 ), 'one two three four')
  end

  test 'array with complex hash' do
    assert_equal(Opentrink::Clsx.call(
                   %w[one two three],
                   { ['four', '4.1'] => true, 'five' => false }
                 ), 'one two three four 4.1')
  end

  test 'nested array' do
    assert_equal(Opentrink::Clsx.call(
                   %w[one two three],
                   [['1.1', '2.2', ['3.3']]]
                 ), 'one two three 1.1 2.2 3.3')
  end
end
