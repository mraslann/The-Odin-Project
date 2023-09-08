const fibonacci = function(num) {
    if (num<0)
        return "OOPS";
    if (num===0 || num === 1)
        return num;
    let first=0;
    let second=1;
    for(let i=2;i<=num;i++){
        let temp=second;
        second = second+first;
        first = temp
    }
    return second;

};

// Do not edit below this line
module.exports = fibonacci;
