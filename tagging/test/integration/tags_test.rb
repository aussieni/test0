require 'test_helper'

class TagsTest < ActionDispatch::IntegrationTest
  setup do
    post '/tag', '{"entity_type": "thing", "entity_id": "abc", "tags": ["nice", "cool"]}', CONTENT_TYPE: 'application/json'
    assert_response :success
  end

  test 'entity get' do
    get '/tags/thing/abc'
    assert_response :success
    assert_json_response({
      'entity_type' => 'thing',
      'entity_id' => 'abc',
      'tags' => ['cool', 'nice']
    })

    get '/tags/thing/xyz'
    assert_response :missing
  end

  test 'replacing entity' do
    post '/tag', '{"entity_type": "thing", "entity_id": "abc", "tags": ["awesome"]}', CONTENT_TYPE: 'application/json'
    get '/tags/thing/abc'

    assert_json_response({
      'entity_type' => 'thing',
      'entity_id' => 'abc',
      'tags' => ['awesome']
    })
  end

  test 'deleting entity' do
    delete '/tags/thing/abc'
    assert_response :success

    get '/tags/thing/abc'
    assert_response :missing
  end

  def assert_json_response(hash)
    assert_equal hash, JSON.parse(response.body)
  end
end
