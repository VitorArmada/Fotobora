require 'test_helper'

class VotetypesControllerTest < ActionController::TestCase
  setup do
    @votetype = votetypes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:votetypes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create votetype" do
    assert_difference('Votetype.count') do
      post :create, votetype: { entity_id: @votetype.entity_id, entitytype_id: @votetype.entitytype_id, user_id: @votetype.user_id, value: @votetype.value }
    end

    assert_redirected_to votetype_path(assigns(:votetype))
  end

  test "should show votetype" do
    get :show, id: @votetype
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @votetype
    assert_response :success
  end

  test "should update votetype" do
    patch :update, id: @votetype, votetype: { entity_id: @votetype.entity_id, entitytype_id: @votetype.entitytype_id, user_id: @votetype.user_id, value: @votetype.value }
    assert_redirected_to votetype_path(assigns(:votetype))
  end

  test "should destroy votetype" do
    assert_difference('Votetype.count', -1) do
      delete :destroy, id: @votetype
    end

    assert_redirected_to votetypes_path
  end
end
