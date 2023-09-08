const palindromes = function (text) {
    otherString = text.toLowerCase().replace(/[^a-z]/g, "");
    return (otherString.split("").reverse().join("") == otherString);
};

// Do not edit below this line
module.exports = palindromes;
