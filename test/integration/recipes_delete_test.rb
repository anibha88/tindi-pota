require 'test_helper'

class RecipesDeleteTest < ActionDispatch::IntegrationTest
  def setup
    @chef = Chef.create!(chefname: "Nithin", email: "nithin@example.com", 
                         password: "sri hari", password_confirmation: "sri hari")
    @recipe = Recipe.create(name: "Jamun", description: "Add jamun mix and water", chef: @chef)
  end

  test "successfully delete a recipe" do 
    sign_in_as(@chef, "sri hari")
    get recipe_path(@recipe)
    assert_template 'recipes/show'    
    assert_select 'a[href=?]', recipe_path(@recipe), text: "Delete this recipe"
    assert_difference 'Recipe.count', -1 do
      delete recipe_path(@recipe)
    end
    assert_redirected_to recipes_path
    assert_not flash.empty?
  end
end
