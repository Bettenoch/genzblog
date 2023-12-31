require 'rails_helper'
describe 'post index Page', type: :feature do
  before do
    @user = User.create(name: 'Leo Messi', photo: 'https://example.com/leo-messi.jpg', bio: 'Best number ten',
                        posts_counter: 8)
    @post1 = Post.create(author_id: @user.id, title: 'My First Post', text: 'Amazing work of art.',
                         likes_counter: 0, comments_counter: 0)
    @post2 = Post.create(author_id: @user.id, title: 'Rails Rocks', text: 'Excited about Rails development!',
                         likes_counter: 0, comments_counter: 0)
    @post3 = Post.create(author_id: @user.id, title: 'Taking a ride', text: 'Exploring the genblogz community.',
                         likes_counter: 0, comments_counter: 0)
    @comment1 = Comment.create(user_id: @user.id, post_id: @post1.id, text: 'Great post!')
    @comment2 = Comment.create(user_id: @user.id, post_id: @post2.id, text: 'Seems exciting!')
    @comment3 = Comment.create(user_id: @user.id, post_id: @post3.id, text: 'Simply the best!')
    visit user_posts_path(@user.id)
  end
  it 'displays user information correctly' do
    # Top Card
    expect(page).to have_link('View Profile')

    expect(page).to have_link('Add Post')
    # Bottom Card
    expect(page).to have_css('.posts-page')
    expect(page).to have_css('.header-posts')

    expect(page).to have_content('Great post!')
  end
  it 'see the user profile picture' do
    expect(page).to have_css("img[src='#{@user.photo}']")
  end

  it 'I can see a posts title.' do
    expect(page).to have_content('My First Post')
    expect(page).to have_content('Rails Rocks')
    expect(page).to have_content('Taking a ride')
  end

  it 'can see some of the posts body' do
    expect(page).to have_content('Amazing work of art.')
    expect(page).to have_content('Excited about Rails development!')
  end

  it 'see the users username.' do
    expect(page).to have_content('Leo Messi')
  end

  it 'see the number of posts user has written' do
    expect(page).to have_content 'Posts: 3'
  end

  it 'see the first comments on a post' do
    expect(page).to have_content('Seems exciting!')
    expect(page).to have_content('Simply the best!')
  end

  it 'see how many likes a post has.' do
    expect(page).to have_content('Likes: 0')
  end

  it 'see a section for pagination if there are more posts than fit on the view..' do
    expect(page).to have_content('Pagination')
  end

  it 'can see the posts user has written' do
    expect(page).to have_content('Amazing work of art.')
    expect(page).to have_content('Excited about Rails development!')
    expect(page).to have_content('Exploring the genblogz community.')
  end

  it 'Clicking on a post should redirect to post show page' do
    click_on 'Amazing work of art.'
    expect(page).to have_content('Amazing work of art.')
    expect(page).to have_content('Great post!')
    expect(page).to have_content('Comments: 1')
    expect(current_path).to eq(user_post_path(@user, @post1))
  end
end
