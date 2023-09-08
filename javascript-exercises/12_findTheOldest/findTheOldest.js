const findTheOldest = function(people) {
    return people.reduce((oldest, current) => {
        if(!current.yearOfDeath)
            current.yearOfDeath = new Date().getFullYear();
            if(!oldest.yearOfDeath)
                oldest.yearOfDeath = new Date().getFullYear();
        return current.yearOfDeath-current.yearOfBirth>oldest.yearOfDeath-oldest.yearOfBirth? current: oldest;
    });
};

// Do not edit below this line
module.exports = findTheOldest;
