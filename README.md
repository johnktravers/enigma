# Enigma

Enigma is an encryption algorithm which shifts a message using four repeating shift values (A, B, C, and D). Every fourth character is shifted by the same amount, so the 1st, 5th, and 9th characters are shifted with the A shift, the 2nd, 6th, and 10th characters are shifted with the B shift, etc. These shift values are computed based on a given or randomly generated five-digit number and the date of message encryption.

## Setup Instructions

To run the encryption and decryption commands on your device, clone the repository and create a message file to be encrypted using the following commands:

```
git clone git@github.com:johnktravers/enigma.git
cd enigma
touch message.txt
echo "INSERT YOUR MESSAGE HERE" >> message.txt
```

## Encryption

You can encrypt your message through the `encrypt.rb` runner file by using the following command:

```
ruby ./lib/encrypt.rb message.txt encrypted.txt
```

This will create an `encrypted.txt` file with the encrypted text contained in the `message.txt` file. It will also output the five-digit key and date used for encryption. Numbers and special characters are not shifted from their original values.

## Decryption

Decryption of an encrypted message is done in a similar manner using the `decrypt.rb` runner file:

```
ruby ./lib/decrypt.rb encrypted.txt decrypted.txt 82648 240818
```

This command takes in the file containing the encrypted text (`encrypted.txt`), the desired name for the file that will contain the decrypted text (`decrypted.txt`), the five-digit key (`82648`), and the encryption date in the format `DDMMYY` (`240818`).

## Encryption Cracking

There is also a special program designed to crack encrypted messages using only the encryption date. This technique calculates the four shift values where `' end'` are the last four characters of the decrypted message and uses linear algebra to compute the five-digit key and decrypt the message. To crack an encrypted message, use the following command:

```
ruby ./lib/crack.rb encrypted.txt cracked.txt 240818
```

Here, `encrypted.txt` is the file containing the encrypted text, `cracked.txt` is the desired name of the file where the cracked text should be stored, and `240818` is the example encryption date in the format `MMDDYY`. It is important to note that the original message must have the last four characters of `' end'` for the crack method to work correctly.
