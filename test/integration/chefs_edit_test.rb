require 'test_helper'

class ChefsEditTest < ActionDispatch::IntegrationTest
  def setup
    @chef = Chef.create!(chefname: "Nithin", email: "nithin_chef@example.com",
                         password: "sri hari", password_confirmation: "sri hari")
    @chef1 = Chef.create!(chefname: "Nikitha", email: "nikitha_chef@example.com",
                         password: "sri hari", password_confirmation: "sri hari")
    @admin_user = Chef.create!(chefname: "Admin", email: "admin_chef@example.com",
                         password: "sri hari", password_confirmation: "sri hari", admin: true)
  end

  test "reject an invalid chef edit" do
    sign_in_as(@chef, "sri hari")
    get edit_chef_path(@chef)
    assert_template 'chefs/edit'
    patch chef_path(@chef), params: { chef: { chefname: " ", email: "nithin_chef@example.com" }}
    assert_template 'chefs/edit'
    assert_select 'h2.panel-title'
    assert_select 'div.panel-body'
  end

  test "accept valid chef edit" do
    sign_in_as(@chef, "sri hari")
    get edit_chef_path(@chef)
    assert_template 'chefs/edit'
    patch chef_path(@chef), params: { chef: { chefname: "Nithin_edit", email: "nithin_chef_edit@example.com" }}
    assert_redirected_to @chef
    assert_not flash.empty?
    @chef.reload
    assert_match "Nithin_edit", @chef.chefname
    assert_match "nithin_chef_edit@example.com", @chef.email
  end

  test "accept edit attempt by admin user" do
    sign_in_as(@admin_user, "sri hari")
    get edit_chef_path(@chef)
    assert_template 'chefs/edit'
    patch chef_path(@chef), params: { chef: { chefname: "Nithin_edit_by_admin", email: "nithin_edit_by_admin@example.com" }}
    assert_redirected_to @chef
    assert_not flash.empty?
    @chef.reload
    assert_match "Nithin_edit_by_admin", @chef.chefname
    assert_match "nithin_edit_by_admin@example.com", @chef.email
  end

  test "redirect edit attempt by another non-admin user" do
    sign_in_as(@chef1, "sri hari")
    updated_name = "test"
    updated_email = "test@example.com"
    patch chef_path(@chef), params: { chef: { chefname: updated_name, email: updated_email }}
    assert_redirected_to chefs_path
    assert_not flash.empty?
    @chef.reload
    assert_match "Nithin", @chef.chefname
    assert_match "nithin_chef@example.com", @chef.email
  end
end
