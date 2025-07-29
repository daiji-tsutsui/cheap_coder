# frozen_string_literal: true

FLAG = :B

# This is a test code for parsing ruby syntax
def main
  test_print(name)
end

def name
  if FLAG == :A
    'Adam'
  else
    'Bob'
  end
end

def test_print(name)
  str = "Hello, #{name}!!"
  puts str
end
