const cookieButton = document.querySelector("#cookie");
const cookieCounter = document.querySelector("output");

let cookies = 0;

cookieButton.addEventListener("click", () => {
  cookies++;
  cookieCounter.textContent = `You have ${cookies} cookies.`;
});
