let num = document.getElementById("num");
let cel = document.getElementById("cel");
let fah = document.getElementById("fah");
let btn = document.getElementById("Submit");
let output = document.getElementById("output");
let answer;

btn.onclick = function(){
    let value = parseFloat(num.value);
    if(cel.checked){
        answer = (value * 9 / 5) + 32;
        console.log(answer);
        output.textContent = answer.toFixed(3);
    }else if(fah.checked){
        answer = (value - 32) * 5 / 9;
        console.log(answer);
        output.textContent = answer.toFixed(3);
    }else{
        output.textContent = "Error!";
    }
}