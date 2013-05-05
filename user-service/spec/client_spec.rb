require_relative '../client.rb'

describe 'client' do
  before(:each) do
    User.base_uri = 'http://localhost:3000'
  end

  it 'should get a user' do
    user = User.find_by_name('paul')
    user['name'].should == 'paul'
    user['email'].should == 'paul@pauldix.net'
    user['bio'].should == 'rubyist'
  end

  it 'should return nil for a user not found' do
    User.find_by_name('gosling').should be_nil
  end

  it 'should create a user' do
    random_name = ('a'..'z').to_a.shuffle[0,8].join
    random_email = ('a'..'z').to_a.shuffle[0,8].join
    user = User.create(
        :name => random_name,
        :email => random_email,
        :password => 'whatev')
    user['name'].should == random_name
    user['email'].should == random_email
    User.find_by_name(random_name).should == user
  end

  it 'should update a user' do
    user = User.update('paul', :bio => 'rubyist and author')
    user['name'].should == 'paul'
    user['bio'].should  == 'rubyist and author'
    User.find_by_name('paul').should == user
  end

  it 'should destroy a user' do
    User.create(
        :name => 'bryan',
        :email => 'bryan@spamtown.usa',
        :password => 'strongpass',
        :bio => 'rubyist')
    User.destroy('bryan').should == true
    User.find_by_name('bryan').should be_nil
  end

  it 'should verify login credentials' do
    user = User.login('paul', 'strongpass')
    user['name'].should == 'paul'
  end

  it 'should return nil with invalid credentials' do
    User.login('paul', 'wrongpassword').should be_nil
  end
end