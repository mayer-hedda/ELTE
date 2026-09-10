from __future__ import annotations

print('Diszkrét modellek és alkalmazásai - Lab 1 - Python practice - group 6 12:00 - 14:00')


# Python practice
# Topics:
#  - branches
#  - loops
#  - lists
#  - dictionaries
#  - simple algorithms

# help: https://compalg.elte.gitlab-pages.hu/dimoa-web/category/python

# https://colab.research.google.com/drive/1TPriIOKj4ph-PeXZl33hUI25ccUhRn_Q?usp=sharing

# 1. Triangle area ------------------------------------------------------------
# Calculate the area of a triangle from its side lengths.
# Return None if the sides cannot form a triangle.
def triangle_area(a: float | int, b: float | int, c: float | int) -> float | None:
    """Return the area of a triangle with sides a, b, c."""
    if a + b <= c or a + c <= b or b + c <= a:
        return None

    s = (a + b + c) / 2
    area = (s * (s - a) * (s - b) * (s - c)) ** 0.5

    return area


# 2. Maximum of three numbers -------------------------------------------------
def max3(a, b, c):
    """Return the largest of the three numbers."""
    if a > b and a > c:
        return a
    elif b > a and b > c:
        return b
    else:
        return c


# 3. Leap year ----------------------------------------------------------------
def is_leap(year: int) -> bool:
    """Return True if year is a leap year."""
    if year % 4 == 0:
        return True


# 4. Factorial ----------------------------------------------------------------
def factorial(n: int) -> int | None:
    """Return n!, or None if n is negative."""
    if n < 0:
        return None
    res = 1
    for i in range(1, n + 1):
        res *= i

    return res


# 5. Digit sum ----------------------------------------------------------------
def digit_sum(n: int, base: int = 10) -> int:
    """Return the sum of the digits of n."""
    res = 0
    for i in range(1, n + 1):
        res += i

    return res


# 6. Prime test ---------------------------------------------------------------
def is_prime(n: int) -> bool:
    """Return True iff n is prime."""
    if n % 2 == 0:
        return False

    s = 0

    for i in range(3, n, 2):
        if n % i == 0:
            s += 1

    if s == 1:
        return True

    return False


# 7. Fibonacci ----------------------------------------------------------------
def fibonacci(n: int) -> int:
    """
      Return the nth Fibonacci number.

      Your solution should also work efficiently for n=1000.
    """
    a = 0
    p = 1

    for _ in range(n):
        a = a + p
        p = a

    return a


print(fibonacci(1))
print(fibonacci(2))
print(fibonacci(3))
print(fibonacci(4))
print(fibonacci(5))


# 8. Horner polynomial evaluation ---------------------------------------------
def horner(coeffs: list[int | float], x: int | float) -> int | float:
    result = coeffs[0]
    for c in coeffs[1:]:
        result = result * x + c

    return result
    """
      coeffs=[2,3,5] represents
  
          2x² + 3x + 5
  
      Evaluate the polynomial using Horner's method.
    """


# 9. Pascal row ---------------------------------------------------------------
def pascal_row(n: int) -> list[int]:
    """
    Return the nth row of Pascal's triangle.

    Examples:
        pascal_row(0) -> [1]
        pascal_row(4) -> [1,4,6,4,1]

    Use only lists and calculate level-by-level (the list behaves as a queue, only `[0], pop(0)` and `append` can be used).
    """
    l = [1, 1]

    for _ in range(n):
        uj = [1]

        for i in range(len(l) - 1):
            uj.append(l[i] + l[i + 1])

        uj.append(1)
        l = uj

    return uj


print(pascal_row(2))
print(pascal_row(3))
print(pascal_row(4))


# 10. Character histogram -----------------------------------------------------
def char_count(text: str) -> dict[str, int]:
    """
    Example:
        banana -> {'b':1,'a':3,'n':2}
    """
    set = {}

    for i in text:
        if i in set:
            set[i] += 1
        else:
            set[i] = 1

    return set


# 11. Word histogram ----------------------------------------------------------
def word_count(words: str) -> dict[str, int]:
    raise NotImplementedError


# 12. Sparse polynomial -------------------------------------------------------
def sparse_poly(poly: list[int | float]) -> dict[int, int | float]:
    """
    Polynomial representation: [5,0,0,1,-7]

        5x⁴ + 3x - 7

    becomes

        {
            4: 5,
            1: 3,
            0: -7
        }
    """
    raise NotImplementedError


# Matrix multiply
def matrix_mul(a: list[list[int | float]], b: list[list[int | float]]) -> list[list[int | float]]:
    raise NotImplementedError


# +1 Complete the Set class.
# ---------------------------------------------------------------------------
class MySet:

    def __init__(self, values=None):
        self.data = []

        if values is not None:
            for v in values:
                if v not in self.data:
                    self.data.append(v)

    def __repr__(self):
        return "{" + ", ".join(map(str, self.data)) + "}"

    def contains(self, value):
        return value in self.data

    # Equality check with '=='
    def __eq__(self, other):
        return self.data == other.data

    # Implement the union of two sets.
    def union(self, other):
        raise NotImplementedError

    # + operator
    def _add__(self, other):
        return self.union(other)

    # Implement the intersection of two sets.
    def intersection(self, other):
        raise NotImplementedError


# Do not modify this part!
# From here there are no further exercises, this part is only for testing purposes.
if __name__ == '__main__':

    tests = [
        ("triangle_area", lambda: triangle_area(3, 4, 5) == 6),
        ("max3", lambda: max3(1, 7, 2) == 7),
        ("is_leap", lambda: is_leap(2024) and not is_leap(2023)),
        ("factorial", lambda: factorial(5) == 120),
        ("digit_sum", lambda: digit_sum(12345) == 15),
        ("is_prime", lambda: is_prime(17) and not is_prime(21)),
        ("fibonacci", lambda: fibonacci(10) == 55),
        ("horner", lambda: horner([2, 3, 5], 2) == 19),
        ("pascal_row", lambda: pascal_row(4) == [1, 4, 6, 4, 1]),
        ("char_count", lambda: char_count("banana") == {'b': 1, 'a': 3, 'n': 2}),
        ("word_count", lambda: word_count("aa a b aa bb c bb") == {'a': 1, 'aa': 2, 'b': 1, 'bb': 2, 'c': 1}),
        ("sparse_poly", lambda: sparse_poly([2, 0, 1]) == {2: 2, 0: 1}),
        ("matrix_mul", lambda: matrix_mul([[1, 2], [3, 4]], [[5, 6], [7, 8]]) == [[19, 22], [43, 50]])
    ]

    for name, test in tests:
        try:
            assert test()
            print(f"{name:20} OK")
        except NotImplementedError:
            print(f"{name:20} not implemented")
        except AssertionError:
            print(f"{name:20} FAILED")

    s1 = MySet([1, 2, 3])
    s2 = MySet([3, 4, 5])
    try:
        assert MySet([i for i in range(1, 6)]) == s1.union(s2)
        print(f"{'Set:union':20} OK")
    except NotImplementedError:
        print(f"{'Set:union':20} not implemented")
    except AssertionError:
        print(f"{'Set:union':20} FAILED")
    try:
        assert MySet([3]) == s1.intersection(s2)
        print(f"{'Set:intersection':20} OK")
    except NotImplementedError:
        print(f"{'Set:intersection':20} not implemented")
    except AssertionError:
        print(f"{'Set:intersection':20} FAILED")