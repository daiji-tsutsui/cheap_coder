# frozen_string_literal: true

def main
  shell_result = `ls`
  puts shell_result

  shell_result2 = %x(pwd) # rubocop:disable Style/CommandLiteral
  puts shell_result2

  system_result = system('cd ~')
  puts system_result

  exec_result = exec('ps')
  puts exec_result
end
