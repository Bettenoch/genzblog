require 'rails_helper'
describe 'Post Show Page', type: :feature do
  before do
    @user = User.create(name: 'Leo Messi', photo: 'https://example.com/leo-messi.jpg', bio: 'Best number ten',
                        posts_counter: 8)
    @post1 = Post.create(author_id: @user.id, title: 'My First Post', text: 'Amazing work of art.',
                         likes_counter: 0, comments_counter: 0)
    @post2 = Post.create(author_id: @user.id, title: 'Rails Rocks', text: 'Excited about Rails development!',
                         likes_counter: 0, comments_counter: 0)
    @comment1 = Comment.create(user_id: @user.id, post_id: @post1.id, text: 'Great post!')
    @comment2 = Comment.create(user_id: @user.id, post_id: @post1.id, text: 'Seems exciting!')
    @comment3 = Comment.create(user_id: @user.id, post_id: @post2.id, text: 'Simply the best!')
    @like1 = Like.create(user_id: @user.id, post_id: @post1.id)
    @like2 = Like.create(user_id: @user.id, post_id: @post1.id)
    visit user_post_path(@user.id, @post1.id)
  end
  it 'displays user information correctly' do
    # Top Card
    expect(page).to have_content('Comments:')
    expect(page).to have_content('Likes: ')
    expect(page).to have_content('Leo Messi')
    expect(page).to have_link(':arrow_left:')
    expect(page).to have_link(' Add a comment')
    # Bottom Card
    expect(page).to have_css('.custom-post-container')
    expect(page).to have_css('.post-interactions')
    expect(page).to have_content('Amazing work of art.')
    expect(page).to have_content('Great post!')
    expect(page).to have_content('Seems exciting!')
    expect(page).to have_content('Likes: 1')
  end
  it 'see the number of comments a post has' do
    expect(page).to have_content('Comments: 2')
  end
  it 'see the username of each commentor' do
    expect(page).to have_content(@comment1.user.name)
    expect(page).to have_content(@comment2.user.name)
  end
  it 'Clicking on  Add a comment button should redirect to add comment page' do
    click_on ' Add a comment'
    expect(page).to have_content('Create a New Comment')
    expect(page).to have_content('Post ')
    expect(page).to have_content('User: ')
    expect(page).to have_link('Create Comment')
  end
end