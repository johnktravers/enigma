require './lib/enigma'

if ARGV.length != 2
  puts "Please give two command line arguments:"
  puts "  1) File name of message (.txt extension)"
  puts "  2) Desired file name of encrypted message (.txt extension)"
  exit
end

message_path = ARGV[0]
message_file = File.open(message_path, 'r')
message = message_file.read.chomp
message_file.close

engima = Enigma.new
encrypted = engima.encrypt(message)

encryption_path = ARGV[1]
encrypted_file = File.open(encryption_path, 'w')
encrypted_file.write(encrypted[:encryption])
encrypted_file.close

puts "Created '#{encryption_path}' with the key #{encrypted[:key]} and date #{encrypted[:date]}"
