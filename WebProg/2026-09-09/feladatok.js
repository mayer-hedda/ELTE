/*
Adott két szám. Írj függvényt, amely visszaadja legnagyobb közös osztójukat!

Függvény lnko(a, b: Egész): Egész 
    Ha a < b akkor csere(a, b)
    maradek = a mod b
    Ciklus amíg maradek > 0
        a := b
        b := maradek
        maradek := a mod b
    Ciklus vége
    lnko := b
Függvény vége
*/

/**
 *
 * @param {number} numberA
 * @param {number} numberB
 * @returns
 */
function greatestCommonDivisor(numberA, numberB) {
  let largerNumber = numberA > numberB ? numberA : numberB;
  let smallerNumber = Math.min(numberA, numberB);
  let remainder = largerNumber % smallerNumber;

  while (remainder > 0) {
    largerNumber = smallerNumber;
    smallerNumber = remainder;
    remainder = largerNumber % smallerNumber;
  }

  return smallerNumber;
}

greatestCommonDivisor(12, 18); // 6

// ---

/*
Döntsd el egy mátrxiról, hogy minden eleme páros-e!
*/

function isEveryMatrixElementEven(matrix) {
  for (let row of matrix) {
    for (let element of row) {
      if (element % 2 !== 0) {
        return false;
      }
    }
  }

  return true;
}

function isEveryMatrixElementEven2(matrix) {
  return matrix.every((row) => row.every((element) => element % 2 === 0));
}
