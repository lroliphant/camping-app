require 'rails_helper'
require 'helpers'

RSpec.configure do |c|
  c.include Helpers
end

feature 'requests' do
  context 'when a potential customer' do
    before do
      sign_up_as_vendor
      create_full_site
    end

    scenario 'clicks on Book button, they are taken to Contact page' do
      visit '/'
      click_link 'ABC Camping'
      click_button 'Book'
      expect(current_path).to eq '/requests/new'
    end

    scenario 'can fill in a form' do
      visit '/'
      click_link 'ABC Camping'
      click_button 'Book'
      expect(page).to have_content 'Name'
      expect(page).to have_button 'Create Request'
    end

    scenario 'submits a request they recieve a message stating the request has been sent' do
      visit '/'
      click_link 'ABC Camping'
      click_button 'Book'
      request_booking
      expect(current_path).to eq '/'
      expect(page).to have_content 'Thank you. Your request has been made.'
    end

  end

  scenario 'should be destroyed with relevant site' do
    sign_up_as_vendor
    create_full_site
    request_booking
    visit '/vendors'
    click_link 'Delete'
    expect(page).not_to have_content 'ABC Camping'
  end
end
