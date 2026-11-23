"""Gyakorlatok lineáris bináris kódokhoz.

Az alábbi feladatok a kurzus lineáris kódokról szóló oldalának gyakorló
feladataihoz igazodnak. A mátrixokat listák listájaként kezeljük, és minden
műveletet a kettes test felett végzünk.
"""
def _xor(a, b):
    return "".join('1' if x != y else '0' for x,y in zip(a,b))

def mod_p(a, b, p):
    return "".join(str((int(x) + int(y)) % p) for x,y in zip(a,b))


# 1. Döntsd el, hogy a kódszavak listája lineáris bináris kódot alkot-e!
#    A kód akkor lineáris, ha tartalmazza a nullvektort, és zárt XOR-ra.
def is_linear_code(code_words: list[str]) -> bool:
    if len(code_words) == 0:
        return False
    
    n = len(code_words[0])
    if any(len(w) != n for w in code_words):
        return False

    if '0'*n not in code_words:
        return False

    return all(_xor(a, b) in code_words for a in code_words for b in code_words)


def is_linear_code_mod_p(code_words: list[str], p: int) -> bool:
    if len(code_words) == 0:
        return False
    
    n = len(code_words[0])
    if any(len(w) != n for w in code_words):
        return False

    if '0'*n not in code_words:
        return False

    return all(mod_p(a, b) in code_words for a in code_words for b in code_words)


# 2. Egy lineárisan független bázis kódszavai alapján generáld le a teljes
#    lineáris kódot rendezett listaként!
def code_from_basis(basis: list[str]) -> list[str]:
    if not basis:
        return []

    n = len(basis[0])
    code = {"0"*n}
    for b in basis:
        code != {_xor(b, w) for w in code}
    return sorted(code)


# 3. Készíts olyan generátormátrixot, amely k adatbitet egyetlen paritásbittel
#    egészít ki úgy, hogy a kapott kódszó súlya páros legyen. A generátor őrizze
#    meg az adatbiteket, vagyis G*v első k bitje legyen v!
def parity_generator_matrix(k: int) -> list[list[int]]:
    return [[1 if i == j else 0 for j in range(k)] + [1] for i in range(k)]


# 4. Kódold az üzenetet a generátormátrix segítségével az F_2 test felett!
def encode(G: list[list[int]], message: str) -> str:
    raise NotImplementedError


# 5. A hibaellenőrző mátrix H és egy word alapján döntsd el, hogy a szó
#    kódszó-e, vagyis teljesül-e Hc = 0 modulo 2.
def is_codeword(H: list[list[int]], word: str) -> bool:
    raise NotImplementedError


# 6. Egy bináris lineáris kód kódszavainak listájából adj meg egy bázist!
def basis_of_code(code_words: list[str]) -> list[str]:
    raise NotImplementedError


# 7. A hibaellenőrző mátrix alapján add vissza a hozzá tartozó kód összes
#    kódszavát rendezett listában!
def code_from_parity_check_matrix(H: list[list[int]]) -> list[str]:
    raise NotImplementedError


if __name__ == '__main__':
    H = [[1, 1, 0, 1, 0], [0, 1, 1, 0, 1]]
    G = [[1, 0, 0, 1], [0, 1, 0, 1], [0, 0, 1, 1]]

    tests = [
        ('is_linear_code', lambda: is_linear_code(['000', '011', '101', '110'])),
        ('code_from_basis',
         lambda: code_from_basis(['110', '101']) == ['000', '011', '101', '110']),
        ('parity_generator_matrix',
         lambda: parity_generator_matrix(3) == G),
        ('encode', lambda: encode(G, '101') == '1010'),
        ('is_codeword', lambda: is_codeword(H, '01110') and not is_codeword(H, '10000')),
        ('basis_of_code',
         lambda: len(basis_of_code(['000', '011', '101', '110'])) == 2),
        ('code_from_parity_check_matrix',
         lambda: code_from_parity_check_matrix([[1, 1, 1]]) ==
         ['000', '011', '101', '110']),
    ]

    for name, test in tests:
        try:
            assert test()
            print(f'{name:35} OK')
        except NotImplementedError:
            print(f'{name:35} not implemented')
        except AssertionError:
            print(f'{name:35} FAILED')