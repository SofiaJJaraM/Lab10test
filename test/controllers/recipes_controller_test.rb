require "test_helper"

class RecipesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:regular)
    @own_recipe = Recipe.create!(title: "Mine", cook_time: 5, difficulty: "Fácil", user: @user)
  end

  test "should get index" do
    get recipes_url
    assert_response :success
  end

  test "should get new" do
    sign_in @user
    get new_recipe_url
    assert_response :success
  end

  test "should create recipe" do
    sign_in @user
    assert_difference("Recipe.count") do
      post recipes_url, params: { recipe: { cook_time: 10, difficulty: "Fácil", title: "Nueva" } }
    end

    assert_redirected_to recipe_url(Recipe.last)
  end

  test "should show recipe" do
    get recipe_url(@own_recipe)
    assert_response :success
  end

  test "should get edit" do
    sign_in @user
    get edit_recipe_url(@own_recipe)
    assert_response :success
  end

  test "should update recipe" do
    sign_in @user
    patch recipe_url(@own_recipe), params: { recipe: { cook_time: @own_recipe.cook_time, difficulty: @own_recipe.difficulty, title: @own_recipe.title } }
    assert_redirected_to recipe_url(@own_recipe)
  end

  test "should destroy recipe" do
    sign_in @user
    assert_difference("Recipe.count", -1) do
      delete recipe_url(@own_recipe)
    end

    assert_redirected_to recipes_url
  end
end
