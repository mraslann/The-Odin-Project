let numbers = document.querySelectorAll(".number");
let operations = document.querySelectorAll(".ops");
let topScreen = document.querySelector(".screen-top");
let bottomScreen = document.querySelector(".screen-bottom");
let point = document.getElementById("point");
let equals = document.getElementById("equals");
let firstNum = '';
let secondNum = '';
let result = 0;
let currentOperation = null;
let reset = document.getElementById("reset");
let pointFlag = 0;
function resetCalc(){
    firstNum = '';
    secondNum = '';
    result = 0;
    pointFlag = 0;
    currentOperation = null;
    bottomScreen.textContent = '';
    topScreen.textContent = '';
}
numbers.forEach((number) => {
    number.addEventListener("click", () => addToScreen(number.textContent));
});

operations.forEach((operation) => {
    operation.addEventListener("click", () => addToScreen(operation.textContent));
    currentOperation = operation.textContent;
});

point.addEventListener("click", () => addToScreen(point.textContent));
equals.addEventListener("click", () => addToScreen(equals.textContent));
function addToScreen(input){
    if((input>="0" && input<="9")){
        topScreen.textContent += input;
        bottomScreen.textContent += input;
    }
    if(input === "."&& pointFlag === 0){
        topScreen.textContent += input;
        bottomScreen.textContent += input;
        pointFlag = 1;
    }
    if (input === "="){
        console.log("lol");
    }
    if(input === "+" || input === "-" || input === "x" || input === "/"){
        topScreen.textContent += " "+input+" ";
        bottomScreen.textContent = "";
        pointFlag = 0;
        result = firstNum;
    }
}
reset.addEventListener("click", () => resetCalc());

const add = function(a,b) {
    return a+b;
  };
  
  const subtract = function(a,b) {
    return a-b;
  };
  
  const multiply = function(a,b) {
    return a*b;
  };
  
  const divide = function(a,b) {
    if(b === 0)
      return "Division by zero error!"
    return a/b;
  };
  
const evaluateExpression = (expression) => {
    let firstNum = '';
    let secondNum = '';
    let result = 0;
    let currentOperation = null;
    let elements = expression.split(' ');
    if(elements.includes("x") || elements.includes("/")){
        for (let i = 0; i < elements.length; i++) {
            const element = elements[i];
            if(element === 'x' || element === '/'){
                firstNum = elements[i-1];
                secondNum = elements[i+1];
                currentOperation = element;
                p1 = elements.filter((elem, index) => {
                    return index < i-1;
                });
                currentOperation === 'x' ? result = multiply(parseFloat(firstNum), parseFloat(secondNum)):result = divide(parseFloat(firstNum), parseFloat(secondNum));
                p1.push(result);
                p2 = elements.filter((elem, index) => {
                    return index > i+1;
                });
                elements = p1.concat(p2);
            }
        } 
    }
    if(elements.includes("+") || elements.includes("-")){
        for (let i = 0; i < elements.length; i++) {
            const element = elements[i];
            if(element === '+' || element === '-'){
                firstNum = elements[i-1];
                secondNum = elements[i+1];
                currentOperation = element;
                currentOperation === '+' ? result = add(parseFloat(firstNum), parseFloat(secondNum)):result = subtract(parseFloat(firstNum), parseFloat(secondNum));
            }
        }
    }
    return result;
    };

const displayResult = (result) => {
    bottomScreen.textContent = result;
};

equals.addEventListener('click', () => {
    const expression = topScreen.textContent;
    const result = evaluateExpression(expression);
    displayResult(result)
});

resetCalc();