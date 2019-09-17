require './lib/enigma'

if ARGV.length != 3
  puts "Please give three command line arguments:"
  puts "  1) File name of encrypted message (.txt extension)"
  puts "  2) Desired file name of cracked message (.txt extension)"
  puts "  3) The date used for encryption (format DDMMYY)"
  exit
end

encryption_path = ARGV[0]
encryption_file = File.open(encryption_path, 'r')
encryption = encryption_file.read.chomp
encryption_file.close

date = ARGV[2]
engima = Enigma.new
cracked = engima.crack(encryption, date)

crack_path = ARGV[1]
crack_file = File.open(crack_path, 'w')
crack_file.write(cracked[:decryption])
crack_file.close

puts "Created '#{crack_path}' with the cracked key #{cracked[:key]} and date #{date}"
