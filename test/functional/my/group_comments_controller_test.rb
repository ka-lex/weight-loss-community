require 'test_helper'

class My::GroupCommentsControllerTest < ActionController::TestCase
  setup do
    @my_group_comment = my_group_comments(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:my_group_comments)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create my_group_comment" do
    assert_difference('My::GroupComment.count') do
      post :create, :my_group_comment => @my_group_comment.attributes
    end

    assert_redirected_to my_group_comment_path(assigns(:my_group_comment))
  end

  test "should show my_group_comment" do
    get :show, :id => @my_group_comment.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @my_group_comment.to_param
    assert_response :success
  end

  test "should update my_group_comment" do
    put :update, :id => @my_group_comment.to_param, :my_group_comment => @my_group_comment.attributes
    assert_redirected_to my_group_comment_path(assigns(:my_group_comment))
  end

  test "should destroy my_group_comment" do
    assert_difference('My::GroupComment.count', -1) do
      delete :destroy, :id => @my_group_comment.to_param
    end

    assert_redirected_to my_group_comments_path
  end
end
