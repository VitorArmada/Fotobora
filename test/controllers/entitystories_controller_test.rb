require 'test_helper'

class EntitystoriesControllerTest < ActionController::TestCase
  setup do
    @entitystory = entitystories(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:entitystories)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create entitystory" do
    assert_difference('Entitystory.count') do
      post :create, entitystory: { date: @entitystory.date, entity_id: @entitystory.entity_id, text: @entitystory.text, title: @entitystory.title, user_id: @entitystory.user_id }
    end

    assert_redirected_to entitystory_path(assigns(:entitystory))
  end

  test "should show entitystory" do
    get :show, id: @entitystory
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @entitystory
    assert_response :success
  end

  test "should update entitystory" do
    patch :update, id: @entitystory, entitystory: { date: @entitystory.date, entity_id: @entitystory.entity_id, text: @entitystory.text, title: @entitystory.title, user_id: @entitystory.user_id }
    assert_redirected_to entitystory_path(assigns(:entitystory))
  end

  test "should destroy entitystory" do
    assert_difference('Entitystory.count', -1) do
      delete :destroy, id: @entitystory
    end

    assert_redirected_to entitystories_path
  end
end
