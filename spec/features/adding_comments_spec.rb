require 'rails_helper'

RSpec.feature "Adding Comments to Articles" do

  before do
    @john = User.create!(email: "john@example.com", password: "password")
    @fred = User.create!(email: "fred@example.com", password: "password")
    @article = Article.create(title: 'First Article', body: 'Body of first article', user: @john)
    # login_as(@john)
  end

  scenario "permits a signed in user to write a review" do
    login_as(@fred)
    visit "/"
    # save_and_open_page
    click_link @article.title
    fill_in "New Comment", with: "An Awsome Article!"
    click_button "Add Comment"

    expect(page).to have_content("Comment has been created")
    expect(page).to have_content("An Awsome Article!")
    expect(page.current_path).to eq(article_path(@article.id))
  end

end
