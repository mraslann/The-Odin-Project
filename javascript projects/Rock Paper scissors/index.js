let images = document.querySelectorAll(".image");
let playerScore = 0;
let computerScore = 0;
let endGame = document.querySelector("#game-over")
let roundOver = document.getElementById("round-over")
let br = document.createElement("br")
function getRandomChoice(){
    const choices = ["rock", "paper", "scissors"];
    return choices[Math.floor(Math.random()*choices.length)];
}
function gameOver(){
    if (playerScore > computerScore) {
        endGame.textContent = "Well done, you won!";
      } else {
        endGame.textContent = "LOSER :(";
        endGame
      }
    let playAgain = document.createElement("button");
    playAgain.id = "play-again";
    playAgain.textContent = "Play Again?"
    endGame.appendChild(br);
    endGame.appendChild(playAgain);
    playAgain.addEventListener("click", () => {
    playerScore = 0;
    computerScore = 0;
    roundOver.textContent = "";
    endGame.textContent = "";
    });
}
images.forEach((image) => {
    image.addEventListener("click", () => {
      playerSelection = image.alt.toLowerCase();
      computerSelection = getRandomChoice();
      playRound(playerSelection, computerSelection);
  
      if (playerScore === 5 || computerScore === 5)
        gameOver();
    });
  });
function DisplayResults(str){
    let br = document.createElement("br")
    roundOver.innerHTML = `${str}`;
    let score = document.createTextNode(`You ${playerScore} - ${computerScore} PC`)
    roundOver.appendChild(br);
    roundOver.appendChild(score);
}
function playRound(playerSelection, computerSelection){
    computerSelection = computerSelection.toLowerCase();
    playerSelection = playerSelection.toLowerCase();
    if(playerSelection === computerSelection)
        DisplayResults("It's a tie!")
        else if (
            (computerSelection == "rock" && playerSelection == "scissors") ||
            (computerSelection == "scissors" && playerSelection == "paper") ||
            (computerSelection == "paper" && playerSelection == "rock")
          ) {
            computerScore = ++computerScore;
            DisplayResults("You lost :(");
          }
          else{
            playerScore = ++playerScore;
            DisplayResults("You win!");
          }
}
