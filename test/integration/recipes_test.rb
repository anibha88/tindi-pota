require 'test_helper'

class RecipesTest < ActionDispatch::IntegrationTest
  def setup
    @chef = Chef.create!(chefname: "Nithin", email: "nithin@example.com",
                         password: "sri hari", password_confirmation: "sri hari")
    @recipe = Recipe.create(name: "Shavige payasa", description: "Great shavige payasa", chef: @chef)
    @recipe2 = @chef.recipes.build(name: "Chutney", description: "Tomoto chutney")
    @recipe2.save
  end

  test "should get recipes index" do 
    get recipes_path
    assert_response :success
  end

  test "should get recipes listing" do 
    get recipes_path
    assert_template 'recipes/index'
    assert_select "a[href=?]", recipe_path(@recipe), text: @recipe.name
    assert_select "a[href=?]", recipe_path(@recipe2), text: @recipe2.name
  end

  test "should get recipe show" do 
    sign_in_as(@chef, "sri hari")
    get recipe_path(@recipe)
    assert_template 'recipes/show'
    assert_match @recipe.name, response.body
    assert_match @recipe.description, response.body
    assert_match @chef.chefname, response.body
    assert_select "a[href=?]", edit_recipe_path(@recipe), text: "Edit this recipe"
    assert_select "a[href=?]", recipe_path(@recipe), text: "Delete this recipe"
    assert_select "a[href=?]", recipes_path, text: "Return to recipes listing"
  end

  test "create new valid recipe" do
    sign_in_as(@chef, "sri hari")
    get new_recipe_path
    assert_template 'recipes/new'
    # Lets define name of recipe and description
    name_of_recipe = "Payasa"
    description_of_recipe = "Add shavige, add milk...cook for 20 mins"
    assert_difference 'Recipe.count', 1 do
      post recipes_path, params: { recipe: { name: name_of_recipe, description: description_of_recipe }}
    end
    follow_redirect!
    assert_match name_of_recipe.capitalize, response.body
    assert_match description_of_recipe, response.body

  end

  test "reject invalid recipe submissions" do
    get new_recipe_path
    assert_template 'recipes/new'
    assert_no_difference 'Recipe.count' do 
      post recipes_path, params: { recipe: {name: "", description: ""}}
    end
    assert_template 'recipes/new'
    assert_select 'h2.panel-title'
    assert_select 'div.panel-body'
  end

end
