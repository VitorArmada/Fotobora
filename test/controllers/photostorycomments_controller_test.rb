require 'test_helper'

class PhotostorycommentsControllerTest < ActionController::TestCase
  setup do
    @photostorycomment = photostorycomments(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:photostorycomments)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create photostorycomment" do
    assert_difference('Photostorycomment.count') do
      post :create, photostorycomment: { date: @photostorycomment.date, photostory_id: @photostorycomment.photostory_id, text: @photostorycomment.text, user_id: @photostorycomment.user_id }
    end

    assert_redirected_to photostorycomment_path(assigns(:photostorycomment))
  end

  test "should show photostorycomment" do
    get :show, id: @photostorycomment
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @photostorycomment
    assert_response :success
  end

  test "should update photostorycomment" do
    patch :update, id: @photostorycomment, photostorycomment: { date: @photostorycomment.date, photostory_id: @photostorycomment.photostory_id, text: @photostorycomment.text, user_id: @photostorycomment.user_id }
    assert_redirected_to photostorycomment_path(assigns(:photostorycomment))
  end

  test "should destroy photostorycomment" do
    assert_difference('Photostorycomment.count', -1) do
      delete :destroy, id: @photostorycomment
    end

    assert_redirected_to photostorycomments_path
  end
end
