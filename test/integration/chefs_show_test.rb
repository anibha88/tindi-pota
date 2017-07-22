require 'test_helper'

class ChefsShowTest < ActionDispatch::IntegrationTest
  def setup
    @chef = Chef.create!(chefname: "Nithin", email: "nithin@example.com",
                         password: "sri hari", password_confirmation: "sri hari")
    @recipe = Recipe.create(name: "Shavige payasa", description: "Great shavige payasa", chef: @chef)
    @recipe2 = @chef.recipes.build(name: "Chutney", description: "Tomoto chutney")
    @recipe2.save
  end

  test "should get chefs show" do
    get chef_path(@chef)
    assert_template 'chefs/show'
    assert_select "a[href=?]", recipe_path(@recipe), text: @recipe.name
    assert_select "a[href=?]", recipe_path(@recipe2), text: @recipe2.name
    assert_match @recipe.description, response.body
    assert_match @recipe2.description, response.body
    assert_match @chef.chefname, response.body
  end
end
