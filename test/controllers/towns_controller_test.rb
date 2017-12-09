require 'test_helper'

class TownsControllerTest < ActionController::TestCase
  setup do
    @town = towns(:one)
    @inexisting = towns(:inexisting)
  end

  test "should get index" do
    VCR.use_cassette("town_index") do
      get :index
      assert_response :success
      assert_not_nil assigns(:towns)
    end
  end

  test "should get new" do
    VCR.use_cassette("town_new") do
      get :new
      assert_response :success
    end
  end

  test "should create town" do
    VCR.use_cassette("town_ok") do
      assert_difference('Town.count') do
      post :create, town: { lat: @town.lat, lon: @town.lon, name: @town.name }
    end
  end

    assert_redirected_to town_path(assigns(:town))
  end
  
  test "should fail if town does not exist" do
    VCR.use_cassette("town_inexisting") do
      assert_no_difference('Town.count') do
        post :create, town: { name: @inexisting.name }
    end
  end

    assert_response :success
  end

  test "should show town" do
    VCR.use_cassette("town_show") do
      get :show, id: @town
      assert_response :success
    end
  end

  test "should get edit" do
    VCR.use_cassette("town_edit") do
      get :edit, id: @town
      assert_response :success
    end
  end

  test "should update town" do
    VCR.use_cassette("town_update") do
      patch :update, id: @town, town: { lat: @town.lat, lon: @town.lon, name: @town.name }
    assert_redirected_to town_path(assigns(:town))
    end
  end

  test "should destroy town" do
    VCR.use_cassette("town_destroy") do
      assert_difference('Town.count', -1) do
        delete :destroy, id: @town
      end
    end

    assert_redirected_to towns_path
  end
end
