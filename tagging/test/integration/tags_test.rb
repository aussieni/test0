require 'test_helper'

class TagsTest < ActionDispatch::IntegrationTest
  test 'get before set' do
    get '/tags/thing/abc'
    assert_response :missing
  end

  test 'get and set' do
    post '/tag', '{"entity_type": "thing", "entity_id": "abc", "tags": ["nice", "cool"]}', CONTENT_TYPE: 'application/json'
    get '/tags/thing/abc'
    assert_response :success
  end
end
