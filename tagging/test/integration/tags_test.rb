require 'test_helper'

class TagsTest < ActionDispatch::IntegrationTest
  test 'get before set' do
    get '/tags/thing/123'
    assert_response :missing
  end
end
