module ChefsIndexHelper
  def recipe_count(chef)
    if chef.recipes.count > 0
      msg = pluralize(chef.recipes.count, "recipe")
    elsif chef.recipes.count == 0
      msg = "#{chef.chefname} doesn't have any recipe."
    end
    msg
  end
end