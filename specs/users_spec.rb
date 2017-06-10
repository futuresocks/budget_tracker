require "minitest/autorun"
require "minitest/rg"

require_relative "../models/users"

class TestBear < Minitest::Test 
  def setup
   @user1 = User.new({
     'first_name' => "Colin",
     'last_name' => "Bell",
     'budget' => 500
   })
   end

def test_full_name
  assert_equal("Colin Bell", @user1.full_name)
end



 end
