def caesar_cipher(sentence, shift)
    result = ""
    sentence.each_char do |c|
        index = c.ord
        if index.between?(65,90) || index.between?(97,122)
            base = index < 91 ? 65 : 97
            new_index = (index - base + shift) % 26 +base
            new_char = new_index.chr
        else
            new_char = c
        end
        result+=new_char
    end
    result
end

puts caesar_cipher("What a string!", 5)