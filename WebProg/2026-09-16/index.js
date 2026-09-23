// console.log("asdf")
// const paragraphs = document.querySelectorAll("p")
// const allStrong = []
// for (const p of paragraphs) {
//     const strongs = p.querySelectorAll("strong")

//     for (const element of strongs) {
//         allStrong.push(element.textContent)
//     }
// }
const buttonElement = document.querySelector("button")
buttonElement.addEventListener("click", onButtonClick)

function onButtonClick(){
const allStrong = Array.from(document.querySelectorAll(" p strong")).map(element => element.textContent);
const outputElement = document.querySelector("output")
outputElement.innerHTML = renderList(allStrong)

}
function renderList(list){
    return `
    <ul>
        ${list.map(renderListItem).join("\n")}
    </ul>
`;
}

function renderListItem(text){
    return `<li>${text}</li>`
//const renderListItem = (text) => <li>${text}</li>
// for (const element of allStrong) {
//     outhtml += '<li>'+element+'</li>'
// }
// outhtml += "</ul>"
}

