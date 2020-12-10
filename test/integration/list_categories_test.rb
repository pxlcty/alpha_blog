require 'test_helper'

class ListCategoriesTest < ActionDispatch::IntegrationTest

  # we are testing: create 2 categories and that they show up in the categories page. 
  # The categories must be links that goes to their respective pages : 

  def setup
    @category = Category.create(name: "Sports")
    @category2 = Category.create(name: "Travel")
  end


  test "index show categories and links to show page" do
    get '/categories'
    assert_select "a[href=?]", category_path(@category), text: @category.name  # will look for a link that matches categorty_path(@category)
    category_path "a[href=?]", category_path(@category2), text: @category2.name
  end
end
