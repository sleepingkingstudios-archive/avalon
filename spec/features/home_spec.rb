# spec/features/home_spec.rb

require 'spec_helper'

feature 'Home' do
  scenario 'User visits the home page' do
    visit '/'
    
    expect(page).to have_text 'Greetings, programs!'
  end # scenario
end # feature
