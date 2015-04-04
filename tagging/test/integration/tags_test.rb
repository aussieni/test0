require 'test_helper'

class TagsTest < ActionDispatch::IntegrationTest
  test 'entity get and set' do
    post '/tag', '{"entity_type": "thing", "entity_id": "abc", "tags": []}', CONTENT_TYPE: 'application/json'
    assert_response :success
    get '/tags/thing/abc'
    assert_response :success
    expected = {
      'entity_type' => 'thing',
      'entity_id' => 'abc',
      'tags' => []
    }
    assert_equal expected, JSON.parse(response.body)

    get '/tags/thing/xyz'
    assert_response :missing
  end

=begin
    post '/tag', '{"entity_type": "thing", "entity_id": "abc", "tags": ["nice", "cool"]}', CONTENT_TYPE: 'application/json'
=end
end
