require 'rails_helper'

feature 'Login', :js do
  it 'it has a link to login' do
    visit '/'
    expect(page).to have_css('a', text: 'Login')
  end

  it 'can create request without account' do
    visit '/'
    fill_in 'email', with: 'test@gmail.com'
    fill_in 'password', with: 'qweqwe'
    fill_in 'subject', with: 'something wrong'
    fill_in 'message', with: 'please test it'

    expect(Request).to receive(:create!).and_call_original

    expect do
      click_on 'Submit new request'
    end.to update(Request, :count)

    expect { Client.count }.to become 1

    client = Client.take
    expect(client.email).to eq 'test@gmail.com'
    expect(client.confirmed_at).to be_blank
    expect(client.confirmation_token).not_to be_blank

    expect { Request.count }.to become 1

    request = Request.take
    expect(request.subject).to eq 'something wrong'

    expect { request.messages.count }.to become 1
    expect(request.messages.take.body).to eq 'please test it'
  end

  context 'allows to login' do
    before do
      visit '/login'
    end

    it 'for client' do
      client = create(:client)
      fill_in 'email', with: client.email
      fill_in 'password', with: client.password
      click_button 'Login'

      expect(page).to have_content("Logged in with email: #{client.email} ( Client ) | Logout")
    end

    it 'for agent' do
      agent = create(:agent)
      fill_in 'email', with: agent.email
      fill_in 'password', with: agent.password
      click_button 'Login'

      expect(page).to have_content("Logged in with email: #{agent.email} ( Agent ) | Logout")
    end

    it 'for admin' do
      admin = create(:admin)

      within '.form' do
        fill_in 'email', with: admin.email
        fill_in 'password', with: admin.password
        click_button 'Login'
      end

      expect(page).to have_content("Logged in with email: #{admin.email} ( Admin ) | Logout")
    end
  end
end
