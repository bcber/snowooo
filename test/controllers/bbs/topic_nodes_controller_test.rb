require 'test_helper'

class Bbs::TopicNodesControllerTest < ActionController::TestCase
  setup do
    @bbs_topic_node = bbs_topic_nodes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:bbs_topic_nodes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create bbs_topic_node" do
    assert_difference('Bbs::TopicNode.count') do
      post :create, bbs_topic_node: { title: @bbs_topic_node.title }
    end

    assert_redirected_to bbs_topic_node_path(assigns(:bbs_topic_node))
  end

  test "should show bbs_topic_node" do
    get :show, id: @bbs_topic_node
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @bbs_topic_node
    assert_response :success
  end

  test "should update bbs_topic_node" do
    patch :update, id: @bbs_topic_node, bbs_topic_node: { title: @bbs_topic_node.title }
    assert_redirected_to bbs_topic_node_path(assigns(:bbs_topic_node))
  end

  test "should destroy bbs_topic_node" do
    assert_difference('Bbs::TopicNode.count', -1) do
      delete :destroy, id: @bbs_topic_node
    end

    assert_redirected_to bbs_topic_nodes_path
  end
end
