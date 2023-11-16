require 'rails_helper'

describe 'User Show Page', type: :feature do
  before do
    @user = User.create(name: 'Leo Messi', photo: 'https://example.com/leo-messi.jpg', bio: 'Best number ten',
                        posts_counter: 8)

    @post1 = Post.create(author_id: @user.id, title: 'My First Post', text: 'Amazing work of art.',
                         likes_counter: 0, comments_counter: 0)
    @post2 = Post.create(author_id: @user.id, title: 'Rails Rocks', text: 'Excited about Rails development!',
                         likes_counter: 0, comments_counter: 0)
    @post3 = Post.create(author_id: @user.id, title: 'Taking a ride', text: 'Exploring the genblogz community.',
                         likes_counter: 0, comments_counter: 0)
    visit user_path(@user.id)
  end

  it 'displays user information correctly' do
    # Top Card
    expect(page).to have_link('View Profile')

    # Bottom Card
    expect(page).to have_css('.user-photo-container')
    expect(page).to have_css('.user-info')
  end

  it 'see the user profile picture' do
    expect(page).to have_css("img[src='#{@user.photo}']")
  end

  it 'displays the users username' do
    expect(page).to have_content('Leo Messi')
  end

  it 'see the user first three posts' do
    expect(page).to have_content('Amazing work of art.')
    expect(page).to have_content('Excited about Rails development!')
    expect(page).to have_content('Exploring the genblogz community.')
  end
  it 'see the number of posts user has written' do
    expect(page).to have_content 'Posts: 3'
  end

  it 'displays users bio' do
    expect(page).to have_content('Best number ten')
  end

  it 'displays  a button that lets me view all of a users posts' do
    expect(page).to have_link('See all post')
  end

  it 'Clicking on the post should redirect to post show page' do
    click_on 'Excited about Rails development!'
    expect(page).to have_content('Leo Messi')
    expect(page).to have_content('Amazing work of art.')
    expect(page).to have_content('Excited about Rails development!')
    expect(page).to have_content('Exploring the genblogz community.')
    expect(current_path).to eq(user_posts_path(@user))
  end
end
