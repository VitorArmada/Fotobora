require 'test_helper'

class EntitystorycommentsControllerTest < ActionController::TestCase
  setup do
    @entitystorycomment = entitystorycomments(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:entitystorycomments)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create entitystorycomment" do
    assert_difference('Entitystorycomment.count') do
      post :create, entitystorycomment: { date: @entitystorycomment.date, entitystory_id: @entitystorycomment.entitystory_id, text: @entitystorycomment.text, user_id: @entitystorycomment.user_id }
    end

    assert_redirected_to entitystorycomment_path(assigns(:entitystorycomment))
  end

  test "should show entitystorycomment" do
    get :show, id: @entitystorycomment
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @entitystorycomment
    assert_response :success
  end

  test "should update entitystorycomment" do
    patch :update, id: @entitystorycomment, entitystorycomment: { date: @entitystorycomment.date, entitystory_id: @entitystorycomment.entitystory_id, text: @entitystorycomment.text, user_id: @entitystorycomment.user_id }
    assert_redirected_to entitystorycomment_path(assigns(:entitystorycomment))
  end

  test "should destroy entitystorycomment" do
    assert_difference('Entitystorycomment.count', -1) do
      delete :destroy, id: @entitystorycomment
    end

    assert_redirected_to entitystorycomments_path
  end
end
