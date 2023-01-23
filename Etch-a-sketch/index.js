let smallBox = document.querySelector(".small-box");
let currentColor = '#000000';
let cellSize = document.getElementById("size");
let currentSize = 8;
let cellColour = document.getElementById("colour-wheel");
function draw(size){
    smallBox.style.gridTemplateColumns = `repeat(${size}, 1fr)`
    smallBox.style.gridTemplateRows = `repeat(${size}, 1fr)`
    for(let i = 0;i<=size*size;i++){
        let cell = document.createElement("div");
        cell.classList.add("cell");
        cell.addEventListener("mouseover", changeColour)
        smallBox.append(cell);
    cellSize.addEventListener("change", changeSize);
    cellColour.oninput = (e) => currentColor = e.target.value;
    }
}

function changeColour(event){
    event.target.style.backgroundColor = currentColor;
}

function changeSize(){
    currentSize = this.value;
    smallBox.innerHTML = "";
    draw(currentSize);
}

draw(currentSize);