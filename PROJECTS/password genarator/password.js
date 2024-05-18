function generatePassword() {
    const upperCase = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    const lowerCase = "abcdefghijklmnopqrstuvwxyz";
    const symbols = "!@#$%&";

    let characters = upperCase + lowerCase + symbols;
    let index;
    let generatedPassword = "";

    for (let i = 0; i < 12; i++) {
        index = Math.floor(Math.random() * characters.length);
        generatedPassword += characters[index];
    }
    return generatedPassword;
}

let login = document.getElementById("login");
let incorrectPara = document.getElementById("incorrect");
let incorrectPara1 = document.getElementById("incorrect1");
let generate = document.getElementById("generate");
let passwordField = document.getElementById("passwordField");
let recheckPassword = document.getElementById("recheckPassword");
let output = document.getElementById("output");
let view = document.getElementById("view");
let view1 = document.getElementById("view1");

generate.onclick = function() {
    passwordField.value = generatePassword();  // Use .value to set the input field
};

login.onclick = function() {
    let password = passwordField.value.trim();  // Use .value to get the input field value
    let checkPassword = recheckPassword.value.trim();  // Use .value to get the input field value

    if (password === "") {
        incorrectPara.innerText = "Fill the field";
    } else if (password.length < 11) {
        incorrectPara.innerText = "Should be more than 11 characters!";
    } else if (password !== checkPassword) {
        incorrectPara.innerText ="";
        incorrectPara1.innerText = "The password entered is incorrect!";
        output.innerText = "Login Unsuccessful";
    } else {
        incorrectPara.innerText = "";
        output.innerText = "Login Successful";
    }
};
view1.onclick = function(){
    if (passwordField.type === "password") {
        passwordField.type = "text";
    } else {
        passwordField.type = "password";
    }
};


view.onclick = function(){
    if (recheckPassword.type === "password") {
      recheckPassword.type = "text";
    } else {
      recheckPassword.type = "password";
    }
};

