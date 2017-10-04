require 'test_helper'

class ChefsListingTest < ActionDispatch::IntegrationTest
  def setup
    @chef = Chef.create!(chefname: "Nithin", email: "nithin@example.com",
                         password: "sri hari", password_confirmation: "sri hari")
    @chef1 = Chef.create!(chefname: "Nikitha", email: "nikitha@example.com",
                         password: "sri hari", password_confirmation: "sri hari")
    @chef2 = Chef.create!(chefname: "Ramesh", email: "ramesh@example.com",
                         password: "sri hari", password_confirmation: "sri hari")
    @chef3 = Chef.create!(chefname: "Gayathri", email: "gayathri@example.com",
                         password: "sri hari", password_confirmation: "sri hari")
    @chef4 = Chef.create!(chefname: "Vani", email: "vani@example.com",
                         password: "sri hari", password_confirmation: "sri hari")
    
  end

  test "should get recipes index" do 
    get chefs_path
    assert_response :success
  end

  test "should get recipes listing" do 
    get chefs_path
    assert_template 'chefs/index'
    assert_select "a[href=?]", chef_path(@chef), text: @chef.chefname.capitalize
    assert_select "a[href=?]", chef_path(@chef1), text: @chef1.chefname.capitalize
    assert_select "a[href=?]", chef_path(@chef2), text: @chef2.chefname.capitalize
    assert_select "a[href=?]", chef_path(@chef3), text: @chef3.chefname.capitalize
    assert_select "a[href=?]", chef_path(@chef4), text: @chef4.chefname.capitalize
    assert_select 'a>img.img-circle'
    assert_match @chef.recipes.count.to_s, response.body
  end

  test "should delete chef" do
    sign_in_as(@chef2, "sri hari")
    get chefs_path 
    assert_template 'chefs/index'
    assert_difference 'Chef.count', -1 do
      delete chef_path(@chef2)
    end
    assert_redirected_to root_path
    assert_not flash.empty?
  end
end
