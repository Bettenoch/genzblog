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
    expect(page).to have_css("img[src='#{@user.photo}']")
    expect(page).to have_content('Leo Messi')
    expect(page).to have_link('Add Post')
    # Bottom Card
    expect(page).to have_css('.posts-page')
    expect(page).to have_css('.header-posts')
    expect(page).to have_content('Amazing work of art.')
    expect(page).to have_content('Excited about Rails development!')
    expect(page).to have_content('Exploring the genblogz community.')
    expect(page).to have_content('Great post!')
    expect(page).to have_content('Seems exciting!')
    expect(page).to have_content('Simply the best!')
    expect(page).to have_content('Likes: 0')
    expect(page).to have_content('Pagination')
  end
  it 'see the number of posts user has written' do
    expect(page).to have_content 'Posts: 3'
  end
  it 'Clicking on a post should redirect to post show page' do
    click_on 'Excited about Rails development!'
    expect(page).to have_content('Excited about Rails development!')
    expect(page).to have_content('Seems exciting!')
    expect(page).to have_content('Comments: 1')
    expect(current_path).to eq(user_post_path(@user, @post2))
  end
end