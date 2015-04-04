require 'test_helper'

class TagsTest < ActionDispatch::IntegrationTest
  setup do
    post '/tag', '{"entity_type": "widget", "entity_id": "abc", "tags": ["nice", "cool"]}', CONTENT_TYPE: 'application/json'
    assert_response :success
  end

  test 'entity get' do
    get '/tags/widget/abc'
    assert_response :success
    assert_json_response({
      'entity_type' => 'widget',
      'entity_id' => 'abc',
      'tags' => ['cool', 'nice']
    })

    get '/tags/widget/xyz'
    assert_response :missing

    get '/tags/doohickey/abc'
    assert_response :missing
  end

  test 'replacing entity' do
    post '/tag', '{"entity_type": "widget", "entity_id": "abc", "tags": ["awesome"]}', CONTENT_TYPE: 'application/json'
    get '/tags/widget/abc'

    assert_json_response({
      'entity_type' => 'widget',
      'entity_id' => 'abc',
      'tags' => ['awesome']
    })
  end

  test 'deleting entity' do
    delete '/tags/widget/abc'
    assert_response :success

    get '/tags/widget/abc'
    assert_response :missing

    delete '/tags/widget/xyz'
    assert_response :missing
  end

  test 'getting single-entity stats' do
    get '/stats/widget/abc'
    assert_json_response(
      {'tag_total' => 2}
    )

    get '/stats/widget/xyz'
    assert_response :missing
  end

  test 'getting stats' do
    get '/stats'
    assert_json_response([
      {'tag' => 'cool', 'count' => 1},
      {'tag' => 'nice', 'count' => 1}
    ])

    post '/tag', '{"entity_type": "widget", "entity_id": "xyz", "tags": ["cool", "awesome", "awesome"]}', CONTENT_TYPE: 'application/json'

    get '/stats'
    assert_json_response([
      {'tag' => 'awesome', 'count' => 1},
      {'tag' => 'cool', 'count' => 2},
      {'tag' => 'nice', 'count' => 1}
    ])
  end

  # !!! stats for single entity, as opposed to GET /tags?

  def assert_json_response(hash)
    assert_equal hash, JSON.parse(response.body)
  end
end
