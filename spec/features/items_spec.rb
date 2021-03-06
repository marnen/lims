require 'spec_helper'

describe Item do
  before (:each) do
    somebody = FactoryGirl.create(:user)
    r = FactoryGirl.create(:role, name: 'Editor')
    somebody.roles << r
    visit new_user_session_path
    fill_in 'user_email', :with => somebody.email
    fill_in 'user_password', :with => somebody.password
    click_on 'Sign in'
  end

  it "a new item form with appropriate fields" do
    visit new_item_path
    fill_in('Model', :with => 'Model T')
    find_field('item_status').value.should have_content('Available')
  end

  it "an edit form with values filled in" do
    @item = FactoryGirl.create(:item)
    visit edit_item_path(@item)
    page.should have_field("Model", :with => @item.model)
  end

  get_basic_editor_views('item',['name', 'description', 'status'])
end
