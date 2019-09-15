require './lib/enigma'

if ARGV.length != 4
  puts "Please give four command line arguments:"
  puts "  1) File name of encrypted message (.txt extension)"
  puts "  2) Desired file name of decrypted message (.txt extension)"
  puts "  3) The five digit key used for encryption"
  puts "  4) The date used for encryption (format DDMMYY)"
  exit
end

encryption_path = ARGV[0]
encryption_file = File.open(encryption_path, 'r')
encryption = encryption_file.read.chomp
encryption_file.close

key = ARGV[2]
date = ARGV[3]
engima = Enigma.new
decrypted = engima.decrypt(encryption, key, date)

decryption_path = ARGV[1]
decryption_file = File.open(decryption_path, 'w')
decryption_file.write(decrypted[:decryption])
decryption_file.close

puts "Created '#{decryption_path}' with the key #{key} and date #{date}"
