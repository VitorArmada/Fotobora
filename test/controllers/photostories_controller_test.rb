require 'test_helper'

class PhotostoriesControllerTest < ActionController::TestCase
  setup do
    @photostory = photostories(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:photostories)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create photostory" do
    assert_difference('Photostory.count') do
      post :create, photostory: { date: @photostory.date, photo_id: @photostory.photo_id, text: @photostory.text, title: @photostory.title, user_id: @photostory.user_id }
    end

    assert_redirected_to photostory_path(assigns(:photostory))
  end

  test "should show photostory" do
    get :show, id: @photostory
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @photostory
    assert_response :success
  end

  test "should update photostory" do
    patch :update, id: @photostory, photostory: { date: @photostory.date, photo_id: @photostory.photo_id, text: @photostory.text, title: @photostory.title, user_id: @photostory.user_id }
    assert_redirected_to photostory_path(assigns(:photostory))
  end

  test "should destroy photostory" do
    assert_difference('Photostory.count', -1) do
      delete :destroy, id: @photostory
    end

    assert_redirected_to photostories_path
  end
end
