require("spec_helper")
require('capybara/rspec')
require('./app')

Capybara.app = Sinatra::Application
set(:show_exceptions, false)

def expect_page(arr)
  arr.each() do |element|
    expect(page).to have_content(element)
  end
end

describe('viewing train system home page', {:type => :feature}) do
  it('allows the viewing of the home page where you can choose what user you are') do
    visit('/')
    expect_page(["Who are you?", "Operator", "Rider"])
  end
end
