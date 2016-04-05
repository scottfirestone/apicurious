require "rails_helper"

RSpec.feature "user can log in with spotify" do
    def setup
      Capybara.app = OauthWorkshop::Application
      user = create(:user)
      stub_omniauth
      before :each do
        OAuth::Controllers::ApplicationControllerMethods::Filter.
        any_instance.stub(:filter).and_return(true)
      end
    end

  scenario "they see their user-specific page" do
    visit root_path

    assert_equal 200, page.status_code

    click_link "Login"

    assert_equal "/", current_path
    assert page.has_content?("User 1")
    assert page.has_link?("Logout")
  end
end
