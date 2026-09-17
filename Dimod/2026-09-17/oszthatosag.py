print('Diszkrét modellek és alkalmazásai - Lab 2 - Number theory practice - group x xx:xx-yy:yy')

# Number theory practice
# Topics:
#  - divisibility
#  - modular arithmetic
#  - units, irreducibles and primes in Z_m
#  - twin primes
#  - sieve methods
#
# help:
#  - https://compalg.elte.gitlab-pages.hu/dimoa-web/gyakorlatok/number_theory/oszthatosag
#  - https://compalg.elte.gitlab-pages.hu/dimoa-web/gyakorlatok/number_theory/primek


# 1. Divisibility with modulo -------------------------------------------------
def divides_mod(a: int, b: int) -> bool:
    """
    Return True iff a divides b.

    Use the modulo operator.
    """
    return b % a == 0


# 2. Divisibility with divmod -------------------------------------------------
def divides_divmod(a: int, b: int) -> bool:
    """
    Return True iff a divides b.

    Use divmod().
    """
    egesz, maradek = divmod(b, a)
    return maradek == 0


# 3. Divisibility with floor division -----------------------------------------
def divides_floor(a: int, b: int) -> bool:
    """
    Return True iff a divides b.

    Do not use the modulo operator; use only //, * and comparison.
    """
    egesz = b // a
    return egesz * a == b


# 4. Universal divisibility test ----------------------------------------------
def divides_all(a: int, limit: int) -> bool:
    """
    Return True iff a divides n^3 - n for every n in {1, 2, ..., limit}.
    """
    for n in range(1, limit + 1):
        if (n ** 3 - n) % a != 0:
            return False
    return True


# 5. Largest universal divisor ------------------------------------------------
def find_largest(max_a: int, limit: int) -> int | None:
    """
    Return the largest integer a with 2 <= a <= max_a such that
    a divides n^3 - n for every n in {1, 2, ..., limit}.

    Return None if no such a exists.
    """
    for n in range(max_a, 1, -1):
        if divides_all(n, limit):
            return n
    return None


# 6. Multiplication table of Z_m ----------------------------------------------
def zn_mul_table(m: int) -> list[list[int]]:
    """
    Return the multiplication table of Z_m.

    The element in row i and column j should be (i * j) mod m.
    """
    raise NotImplementedError


# 7. Units, irreducibles and primes in Z_m ------------------------------------
def classify_zn(m: int) -> tuple[list[int], list[int], list[int]]:
    """
    Return three sorted lists:

        (units, irreducibles, primes)

    for the ring Z_m.
    """
    raise NotImplementedError


# 8. Twin primes --------------------------------------------------------------
def twin_primes(a: int, b: int) -> list[tuple[int, int]]:
    """
    Return all twin prime pairs (p, p + 2) such that

        a <= p < p + 2 <= b.
    """
    raise NotImplementedError


# 9. Sieve of Eratosthenes ----------------------------------------------------
def sieve(n: int) -> list[int]:
    """
    Return the list of all primes <= n using the sieve of Eratosthenes.
    """
    raise NotImplementedError


# 10. Odd-only sieve ----------------------------------------------------------
def odd_sieve(n: int) -> list[int]:
    """
    Return the list of all primes <= n using a sieve that stores only odd
    candidates.
    """
    raise NotImplementedError


# Do not modify this part!
# From here there are no further exercises, this part is only for testing purposes.
if __name__ == '__main__':

    tests = [
        ("divides_mod", lambda: divides_mod(12, 60) and not divides_mod(12, 62)),
        ("divides_divmod", lambda: divides_divmod(7, 49) and not divides_divmod(7, 50)),
        ("divides_floor", lambda: divides_floor(9, 72) and not divides_floor(9, 73)),
        ("divides_all", lambda: divides_all(6, 30) and not divides_all(7, 30)),
        ("find_largest", lambda: find_largest(12, 30) == 6),
        ("zn_mul_table", lambda: zn_mul_table(4) == [[0, 0, 0, 0], [0, 1, 2, 3], [0, 2, 0, 2], [0, 3, 2, 1]]),
        ("classify_zn", lambda: classify_zn(4) == ([1, 3], [2], [2])),
        ("twin_primes", lambda: twin_primes(1, 20) == [(3, 5), (5, 7), (11, 13), (17, 19)]),
        ("sieve", lambda: sieve(30) == [2, 3, 5, 7, 11, 13, 17, 19, 23, 29]),
        ("odd_sieve", lambda: odd_sieve(30) == [2, 3, 5, 7, 11, 13, 17, 19, 23, 29]),
    ]

    for name, test in tests:
        try:
            assert test()
            print(f"{name:20} OK")
        except NotImplementedError:
            print(f"{name:20} not implemented")
        except AssertionError:
            print(f"{name:20} FAILED")
 