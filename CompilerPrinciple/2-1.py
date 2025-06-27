'''
Automata

E -> T | E+T | E-T
T -> F | T*F | T/F
F -> i | (E)
''''''
Automata Extended

0) E'-> E
1) E -> T
2) E -> E+T
3) E -> E-T
4) T -> F
5) T -> T*F
6) T -> T/F
7) F -> i
8) F -> (E)
''''''
Item Set Families

I0: 
    E'-> `E
    E -> `T
    E -> `E+T
    E -> `E-T
    T -> `F
    T -> `T*F
    T -> `T/F
    F -> `i
    F -> `(E)
I1:
    E'-> E`
    E -> E`+T
    E -> E`-T
I2:
    E -> T`
    T -> T`*F
    T -> T`/F
I3:
    T -> F`
I4:
    F -> i`
I5:
    F -> (`E)
    E -> `T
    E -> `E+T
    E -> `E-T
    T -> `F
    T -> `T*F
    T -> `T/F
    F -> `i
    F -> `(E)
I6:
    E -> E+`T
    T -> `F
    T -> `T*F
    T -> `T/F
    F -> `i
    F -> `(E)
I7:
    E -> E-`T
    T -> `F
    T -> `T*F
    T -> `T/F
    F -> `i
    F -> `(E)
I8:
    T -> T*`F
    F -> `i
    F -> `(E)
I9:
    T -> T/`F
    F -> `i
    F -> `(E)
I10:
    F -> (E`)
    E -> E`+T
    E -> E`-T
I11:
    E -> E+T`
    T -> T`*F
    T -> T`/F
I12:
    E -> E-T`
    T -> T`*F
    T -> T`/F
I13:
    T -> T*F`
I14:
    T -> T/F`
I15:
    F -> (E)`

''''''
Action and Goto table

|State|        Action          |   Goto    |
|State| i  +  -  *  /  (  )  # | E   T   F |
| 0   | s4             s5      | 1   2   3 |
| 1   |    s6 s7            acc|           |
| 2   | r1 r1 r1 s8 s9 r1 r1 r1|           |
| 3   | r4 r4 r4 r4 r4 r4 r4 r4|           |
| 4   | r7 r7 r7 r7 r7 r7 r7 r7|           |
| 5   | s4             s5      | 10  2   3 |
| 6   | s4             s5      |     11  3 |
| 7   | s4             s5      |     12  3 |
| 8   | s4             s5      |         13|
| 9   | s4             s5      |         14|
| 10  |    s6 s7          s15  |           |
| 11  | r2 r2 r2 s8 s9 r2 r2 r2|           |
| 12  | r3 r3 r3 s8 s9 r3 r3 r3|           |
| 13  | r5 r5 r5 r5 r5 r5 r5 r5|           |
| 14  | r6 r6 r6 r6 r6 r6 r6 r6|           |
| 15  | r8 r8 r8 r8 r8 r8 r8 r8|           |
'''
class LR1Parser:
    def __init__(self):
        self.action_table = {
            0:  {'i': ('S', 4), '(': ('S', 5)},
            1:  {'+': ('S', 6), '-': ('S', 7), '#': ('ACC',)},
            2:  {'+': ('R', 1), '-': ('R', 1), '*': ('S', 8), '/': ('S', 9), ')': ('R', 1), '#': ('R', 1)},
            3:  {'+': ('R', 4), '-': ('R', 4), '*': ('R', 4), '/': ('R', 4), ')': ('R', 4), '#': ('R', 4)},
            4:  {'+': ('R', 7), '-': ('R', 7), '*': ('R', 7), '/': ('R', 7), ')': ('R', 7), '#': ('R', 7)},
            5:  {'i': ('S', 4), '(': ('S', 5)},
            6:  {'i': ('S', 4), '(': ('S', 5)},
            7:  {'i': ('S', 4), '(': ('S', 5)},
            8:  {'i': ('S', 4), '(': ('S', 5)},
            9:  {'i': ('S', 4), '(': ('S', 5)},
            10: {'+': ('S', 6), '-': ('S', 7), ')': ('S', 15)},
            11: {'+': ('R', 2), '-': ('R', 2), '*': ('S', 8), '/': ('S', 9), ')': ('R', 2), '#': ('R', 2)},
            12: {'+': ('R', 3), '-': ('R', 3), '*': ('S', 8), '/': ('S', 9), ')': ('R', 3), '#': ('R', 3)},
            13: {'+': ('R', 5), '-': ('R', 5), '*': ('R', 5), '/': ('R', 5), ')': ('R', 5), '#': ('R', 5)},
            14: {'+': ('R', 6), '-': ('R', 6), '*': ('R', 6), '/': ('R', 6), ')': ('R', 6), '#': ('R', 6)},
            15: {'+': ('R', 8), '-': ('R', 8), '*': ('R', 8), '/': ('R', 8), ')': ('R', 8), '#': ('R', 8)},
        }
        self.goto_table = {
            0: {'E': 1, 'T': 2, 'F': 3},
            5: {'E': 10, 'T': 2, 'F': 3},
            6: {'T': 11, 'F': 3},
            7: {'T': 12, 'F': 3},
            8: {'F': 13},
            9: {'F': 14}
        }
        self.rules = [
            ('E', 'T'),    # Rule 1
            ('E', 'E+T'),  # Rule 2
            ('E', 'E-T'),  # Rule 3
            ('T', 'F'),    # Rule 4
            ('T', 'T*F'),  # Rule 5
            ('T', 'T/F'),  # Rule 6
            ('F', 'i'),    # Rule 7
            ('F', '(E)'),  # Rule 8
        ]

    def parse(self, tokens):
        if tokens is None:
            return False
        stack = [0]  # State stack
        ptr = 0

        while True:
            state = stack[-1]
            token = tokens[ptr] if ptr < len(tokens) else '#'
            action = self.action_table.get(state, {}).get(token)
            if not action:
                return False

            if action[0] == 'S':
                stack.append(action[1])
                ptr += 1
            elif action[0] == 'R':
                rule = self.rules[action[1] - 1]
                for _ in range(len(rule[1])):
                    stack.pop()
                state = stack[-1]
                stack.append(self.goto_table[state][rule[0]])
            elif action[0] == 'ACC':
                return True

def tokenize(expression):
    tokens = []
    i = 0
    while i < len(expression):
        if expression[i].isspace():
            i += 1
        elif expression[i] in '+-*/()':
            tokens.append(expression[i])
            i += 1
        elif expression[i].isalpha():
            while i < len(expression) and expression[i].isalpha():
                i += 1
            tokens.append('i')
        elif expression[i].isdigit():
            while i < len(expression) and expression[i].isdigit():
                i += 1
            tokens.append('i')
        else:
            return None
    return tokens

if __name__ == "__main__":
    parser = LR1Parser()
    tokens = tokenize(input())
    result = parser.parse(tokens)
    print("true" if result else "false")
