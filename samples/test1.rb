# frozen_string_literal: true

# This is a test code for parsing ruby syntax
def main
  test_print(name)
end

def name
  'Adam'
end

def test_print(name)
  str = "Hello, #{name}!!"
  puts str
end
