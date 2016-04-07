require "rails_helper"
require "support/authentication"

RSpec.configure do |c|
  c.include Authentication
end

RSpec.feature "user can log in with spotify" do
  before(:each) do
    stub_omniauth
  end

  scenario "they see their user-specific page" do
    visit root_path
    click_link "Login"

    within(".nav") do
      expect(page).to have_content("Logout")
    end
  end
end
