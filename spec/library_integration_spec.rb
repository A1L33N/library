require('capybara/rspec')
require('./app')
require('spec_helper')
Capybara.app = Sinatra::Application
set(:show_exceptions, false)

describe("The library homepage path!", {:type => :feature}) do
  it('takes a user to a list of books') do
    visit('/')
    click_link('See books')
    expect(page).to have_content("Here are the books we have:")
  end
end


describe("the add book path", {:type => :feature})  do
  it('allows a user to add a book and see the new list of books') do
    visit('/books')
    fill_in('new_book', :with => 'The Boxcar Children')
    click_button('Add Book')
    expect(page).to have_content('The Boxcar Children')
  end
end
