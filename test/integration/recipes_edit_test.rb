require 'test_helper'

class RecipesEditTest < ActionDispatch::IntegrationTest
  def setup
    @chef = Chef.create!(chefname: "Nithin", email: "nithin_chef@example.com",
                         password: "sri hari", password_confirmation: "sri hari")
    @recipe = Recipe.create(name: "Tili Saaru", description: "Put some bele along with sarina pudi", chef: @chef)
  end

  test "reject invalid recipe update" do
    sign_in_as(@chef, "sri hari")
    get edit_recipe_path(@recipe)
    assert_template 'recipes/edit'
    patch recipe_path(@recipe), params: { recipe: { name: " ", description: "some description" } }
    assert_template 'recipes/edit'
    assert_select 'h2.panel-title'
    assert_select 'div.panel-body'
  end

  test "successfully edit a recipe" do
    sign_in_as(@chef, "sri hari")
    get edit_recipe_path(@recipe)
    assert_template 'recipes/edit'
    updated_name = "Updated recipe name"
    updated_description = "Updated recipe description"
    patch recipe_path(@recipe), params: { recipe: { name: updated_name, description: updated_description } }
    assert_redirected_to @recipe
    assert_not flash.empty?
    @recipe.reload
    assert_match updated_name, @recipe.name
    assert_match updated_description, @recipe.description
  end


end
