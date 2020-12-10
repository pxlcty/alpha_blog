require 'test_helper'

class CategoryTest < ActiveSupport::TestCase

    def setup # runs as first line in every test below : 
        @category = Category.new(name: "Sports")
    end

    test "category should be valid" do

        assert @category.valid?
    end

    test "name should be present" do
        @category.name = " " # this allows for a name to be an empty string. 
        assert_not @category.valid?#this wants the name to fail as valid.
    end

    test "name should be unique" do
        @category.save
        @category2 = Category.new(name: "Sports")
        assert_not @category2.valid?
    end

    test "name should not be too long" do
        @category.name = "a" * 26
        assert_not @category.valid?
    end

    test "name should not be too short" do
        @category.name = "aa"
        assert_not @category.valid?
    end

end