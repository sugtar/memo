require 'test_helper'

class MemoItemsControllerTest < ActionController::TestCase
  setup do
    @memo_item = memo_items(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:memo_items)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create memo_item" do
    assert_difference('MemoItem.count') do
      post :create, memo_item: { body: @memo_item.body }
    end

    assert_redirected_to memo_item_path(assigns(:memo_item))
  end

  test "should show memo_item" do
    get :show, id: @memo_item
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @memo_item
    assert_response :success
  end

  test "should update memo_item" do
    patch :update, id: @memo_item, memo_item: { body: @memo_item.body }
    assert_redirected_to memo_item_path(assigns(:memo_item))
  end

  test "should destroy memo_item" do
    assert_difference('MemoItem.count', -1) do
      delete :destroy, id: @memo_item
    end

    assert_redirected_to memo_items_path
  end
end
