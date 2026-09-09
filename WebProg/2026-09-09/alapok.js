console.log("Hello, World!");

() => {};       // ha zárójellel kezdődik a sor, akkor kötelező az előző sor végére a pontosvessző, különben hibát dob a JS motor.


// * Variables:
var a = 1;     // var: function scope, lehet újradefiniálni, lehet újra deklarálni
let b = 2;     // let: block scope, lehet újradefiniálni, nem lehet újra deklarálni
const c = 3;   // const: block scope, nem lehet újradefiniálni, nem lehet újra deklarálni

let foo;
console.log(foo); // undefined
console.log(typeof foo); // "undefined"         typeof mindig stringet ad vissza

console.log(typeof NaN); // "number"
console.log(NaN === NaN); // false


// * Array:
let arr = [1, 2, 3];
console.log(arr[0]); // 1
console.log(arr.length); // 3
arr.push(4); // hozzáadja a végéhez
console.log(arr); // [1, 2, 3, 4]
arr.pop(); // eltávolítja az utolsó elemet
console.log(arr); // [1, 2, 3]
arr.shift(); // eltávolítja az első elemet
console.log(arr); // [2, 3]
arr.unshift(1); // hozzáadja az elejéhez
console.log(arr); // [1, 2, 3]


// * Operations:
console.log('a' + 'b'); // "ab"
console.log('a' + 1); // "a1"  a számot stringgé konvertálja
console.log(1 + 'a'); // "1a"  a számot stringgé konvertálja

console.log(1 + 2); // 3
console.log(1 - 2); // -1
console.log(1 * 2); // 2
console.log(1 / 2); // 0.5
console.log(1 % 2); // 1

console.log(1 + true); // 2   true-t számmá konvertálja (true = 1, false = 0)
console.log(1 + false); // 1

console.log("a4" * 2); // NaN


// * Parsing:
parseInt("123"); // 123
parseInt("123abc"); // 123
parseInt("abc123"); // NaN


// * Comparison:
console.log(42 == 42); // true
console.log(42 == "42"); // true  a stringet számmá konvertálja
console.log(42 === 42); // true
console.log(42 === "42"); // false  a stringet nem konvertálja számmá


// * Programozási tételek:
// Eldöntés:
const even = (element) => element % 2 === 0;

// Maximum kiválasztás:
const array = [1, 2, 9, 4, 5];
const max = (arr) => arr.reduce((acc, val) => val > acc ? val : acc);
console.log(max(array)); // 9