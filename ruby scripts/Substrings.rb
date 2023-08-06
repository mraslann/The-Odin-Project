def substrings(substring, dictionary)
    result = {}
    dictionary.each do |word|
        matches = substring.downcase.scan(word)
        count = matches.length
        result[word] = count if count > 0
    end
    result
end

dictionary = ["below","down","go","going","horn","how","howdy","it","i","low","own","part","partner","sit"]
puts substrings("Howdy partner, sit down! How's it going?", dictionary)