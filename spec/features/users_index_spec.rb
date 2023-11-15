require 'rails_helper'

describe 'Users Index View', type: :feature do
  before do
    @user1 = User.create(name: 'Leo Messi', photo: 'https://example.com/leo-messi.jpg', bio: 'Best number ten',
                         posts_counter: 8)
    @user2 = User.create(name: 'Khai Havertz', photo: 'https://example.com/khai-havertz.jpg', bio: 'Best winger',
                         posts_counter: 4)
    @user3 = User.create(name: 'Kh Hatz', photo: 'https://example.com/kh-hatz.jpg', bio: nil,
                         posts_counter: 4)
    visit root_path
  end

  it 'displays user information correctly' do
    expect(page).to have_content('Explore the Genzblog Community')
    expect(page).to have_content('Posts: ')
    expect(page).to have_link('View Profile')
  end

  it 'does not display bio for users without bio' do
    click_on 'Kh Hatz'
    expect(page).to have_content('See all post')
    expect(page).not_to have_content('Bio:')
  end

  it 'should return the correct CSS' do
    expect(page).to have_css('.user-photo-container')
    expect(page).to have_css('.user-info')
  end
  it 'displays the profile picture for each user' do
    expect(page).to have_css("img[src*='https://example.com/leo-messi.jpg']")
    expect(page).to have_css("img[src*='https://example.com/kh-hatz.jpg']")
  end
  # it 'displays "No users found" message when there are no users' do
  #   User.destroy_all # Remove all users from the database
  #   visit users_path
  #   expect(page).to have_content('No users found')
  # end

  it 'When I click on user, it redirects to user/show page' do
    click_on 'Leo Messi'
    expect(page).to have_content('Leo Messi')
    expect(page).to have_content('Bio')
    expect(page).to have_content('See all post')
    expect(current_path).to eq(user_path(@user1))
  end

  it 'When I click on user, it redirects to user/show page' do
    click_on 'Khai Havertz'
    expect(page).to have_content('Khai Havertz')
    expect(page).to have_content('Bio')
    expect(page).to have_content('See all post')
    expect(current_path).to eq(user_path(@user2))
  end
end
