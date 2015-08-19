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

describe("the add patron path", {:type => :feature})  do
  it('allows a user to add a patron and see the new list of patrons') do
    visit('/patrons')
    fill_in('patron_name', :with => 'Boxcar Child')
    click_button('Join our library')
    expect(page).to have_content('Boxcar Child')
  end
end

describe("the add book path", {:type => :feature})  do
  it('allows a user to add a book and see the new list of books') do
    visit('/authors')
    fill_in('new_author', :with => 'Boxcar Rick')
    click_button('Add Author')
    expect(page).to have_content('Boxcar Rick')
  end
end
