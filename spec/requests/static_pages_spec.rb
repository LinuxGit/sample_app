require 'spec_helper'

describe "Static pages" do

	subject { page }

	describe "Home Page" do
		before { visit root_path }
    it { should have_selector('h1', text: 'Linux News')}
    it { should have_selector('title', text: full_title('')) }
    it { should_not have_selector('title', text: '| Home') }

    describe "for signed_in users" do
      let(:user) { FactoryGirl.create(:user) }
      before do
        FactoryGirl.create(:micropost, user: user, content: "Lorem ipsum")
        FactoryGirl.create(:micropost, user: user, content: "I love ubuntu.")
        sign_in user
        visit root_path
      end

      it "should render user's feed" do
        user.feed.each do |item|
        page.should have_selector("li##{item.id}", text: item.content)
        end
      end
    end
  end

  describe "Help Page" do
    before { visit help_path }
    it { should have_selector('h1', text: 'Help') }
    it { should have_selector('title', text: full_title('Help')) }
  end

  describe "About us" do
	  before  { visit about_path }
	  it { should have_selector('h1', text: 'About Us') }
    it { should have_selector('title', text: full_title('About Us')) }
  end

  describe "Contact Us" do
    before { visit contact_path }
    it { should have_selector('h1', text: 'Contact Us') }
    it { should have_selector('title', text: full_title('Contact Us')) }
	end

  it "should have the right links on the layout" do
	  visit root_path
	  click_link "Linux News"
	  page.should have_selector 'h1', text: 'Linux News'
	  click_link "Home"
	  click_link "Sign up now!"
	  page.should have_selector 'title', text: full_title('Sign up')
	  click_link "Help"
	  page.should have_selector 'title', text: full_title('Help')
	  click_link "Contact"
	  page.should have_selector 'title', text: full_title('Contact Us')
	  click_link "About"
	  page.should have_selector 'title', text: full_title('About Us')
	end
end
