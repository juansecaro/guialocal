require 'test_helper'

class AmbassadorsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @ambassador = ambassadors(:one)
  end

  test "should get index" do
    get ambassadors_url
    assert_response :success
  end

  test "should get new" do
    get new_ambassador_url
    assert_response :success
  end

  test "should create ambassador" do
    assert_difference('Ambassador.count') do
      post ambassadors_url, params: { ambassador: { bio_english: @ambassador.bio_english, bio_native: @ambassador.bio_native, bio_original: @ambassador.bio_original, country: @ambassador.country, language: @ambassador.language, name: @ambassador.name, picture: @ambassador.picture, review_english: @ambassador.review_english, review_native: @ambassador.review_native, review_original: @ambassador.review_original, slug: @ambassador.slug, video_interview: @ambassador.video_interview, video_testimonial: @ambassador.video_testimonial } }
    end

    assert_redirected_to ambassador_url(Ambassador.last)
  end

  test "should show ambassador" do
    get ambassador_url(@ambassador)
    assert_response :success
  end

  test "should get edit" do
    get edit_ambassador_url(@ambassador)
    assert_response :success
  end

  test "should update ambassador" do
    patch ambassador_url(@ambassador), params: { ambassador: { bio_english: @ambassador.bio_english, bio_native: @ambassador.bio_native, bio_original: @ambassador.bio_original, country: @ambassador.country, language: @ambassador.language, name: @ambassador.name, picture: @ambassador.picture, review_english: @ambassador.review_english, review_native: @ambassador.review_native, review_original: @ambassador.review_original, slug: @ambassador.slug, video_interview: @ambassador.video_interview, video_testimonial: @ambassador.video_testimonial } }
    assert_redirected_to ambassador_url(@ambassador)
  end

  test "should destroy ambassador" do
    assert_difference('Ambassador.count', -1) do
      delete ambassador_url(@ambassador)
    end

    assert_redirected_to ambassadors_url
  end
end
