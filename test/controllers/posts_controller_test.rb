require 'test_helper'

class PostsControllerTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  test "should get index" do
    get posts_url
    assert_response :success
  end

  test "should show post" do
    post = posts(:one)
    get post_url(post)
    assert_response :success
  end

  test "should destroy post" do
    post = posts(:one)
    assert_difference('Post.count', -1) do
      delete post_url(post)
    end
    assert_redirected_to posts_path
  end

  test "should update post" do
    post = posts(:one)
    patch post_url(post), params: { post: { title: "updated" } }
    assert_redirected_to post_path(post)
    post.reload
    assert_equal "updated", post.title
  end
end
