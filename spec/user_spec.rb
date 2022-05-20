require 'user'

describe User do
  describe '.create' do
    it 'should add a user to the database' do
      expect(User.create(username: 'test', email: 'test@email.com', password: "bobbychuckle")).to be_an_instance_of(User).and have_attributes(username: 'test', email: 'test@email.com')
    end

    it 'hashes the password using BCrypt' do
      expect(BCrypt::Password).to receive(:create).with('password123').and_return('hello')
      User.create(username: 'test', email: 'test@example.com', password: 'password123')
    end

  end

  describe '.all' do
    it "returns users" do
      first_user = User.create(username: 'test', email: 'test@email.com', password: "bobbychuckle")

      user = User.all

      expect(user.first).to be_an_instance_of(User).and have_attributes(username: 'test', email: 'test@email.com')
    end
  end


  describe '.authenticate' do
    it 'checks email and password are correct and returns user' do
      user = User.create(username: 'test', email: 'test@email.com', password: "bobbychuckle")
      authenticated_user = User.authenticate(email: 'test@email.com', password: "bobbychuckle")

      expect(authenticated_user.id).to eq user.id
    end 
  end

  describe '.find' do
    it "selects specific user by id" do
      user = User.create(username: 'test', email: 'test@email.com', password: "bobbychuckle")
      found_user = User.find(id: user.id)
      

      expect(found_user).to be_an_instance_of(User).and have_attributes(username: 'test', email: 'test@email.com')
    end
  end 

  # describe do

  # end
end 