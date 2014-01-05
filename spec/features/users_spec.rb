require 'spec_helper'

describe "User" do
  include OwnTestHelper

  before :each do
    @user = FactoryGirl.create :user
  end

  describe "who has signed up" do
    it "can sign in with right credentials" do
      sign_in 'Pekka', 'foobar1'

      expect(page).to have_content 'Welcome back!'
      expect(page).to have_content 'Pekka'
    end

    it "is redirected back to sign in form if wrong credentials given" do
      sign_in 'Pekka', 'wrong'

      expect(current_path).to eq(signin_path)
      expect(page).to have_content 'username and password do not match'
    end

    it "when signed up with good credentials, is added to the system" do
      visit signup_path
      fill_in('user_username', :with => 'Brian')
      fill_in('user_password', :with => 'secret55')
      fill_in('user_password_confirmation', :with => 'secret55')
  
      expect{
        click_button('Create User')
      }.to change{User.count}.by(1)
    end

    it "show ratings on user page" do
        sign_in 'Pekka', 'foobar1'
        create_ratings
        visit user_path @user
        expect(page).to have_content 'has given 2 ratings, average 15.0'
        expect(page).to have_content 'anonymous 10'
        expect(page).to have_content 'anonymous 20'
    end

    it "can delete ratings" do
      sign_in 'Pekka', 'foobar1'
      create_ratings
      visit user_path @user

      expect{
        click_link "delete", match: :first
      }.to change{Rating.count}.from(2).to(1)
    end


    it "favorite style is shown" do
        sign_in 'Pekka', 'foobar1'
        create_ratings
        visit user_path @user

        expect(page).to have_content 'Favorite style: Lager'
    end

    it "favorite brewery is shown" do
        sign_in 'Pekka', 'foobar1'
        beer = create_ratings
        beer.brewery = FactoryGirl.create :brewery
        visit user_path @user

        expect(page).to have_content "Favorite brewery: #{beer.brewery.name}"
    end
        
    def create_ratings
        beer1 = FactoryGirl.create :beer
        beer1.ratings << FactoryGirl.create(:rating2, :user => @user)
        beer1.ratings << FactoryGirl.create(:rating, :user => @user)
        beer1
    end
  end
  
end
