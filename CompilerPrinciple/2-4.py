'''
Automata

E -> T | E+T | E-T
T -> F | T*F | T/F
F -> i | (E)
''''''
Automata Replaced

E -> TE'
E'-> +TE' | -TE' | ε
T -> FT'
T'-> *FT' | /FT' | ε
F -> i | (E)
'''
class RecursiveDescentParser:
    def __init__(self):
        self.tokens = []
        self.current_index = 0

    def parse(self, expression):
        self.tokens = expression
        if self.tokens is None:
            return False
        self.tokens.append('#')
        self.current_index = 0

        try:
            self.E()
            return self.current() == '#'
        except Exception:
            return False

    def current(self):
        return self.tokens[self.current_index]

    def next(self):
        self.current_index += 1

    def E(self):
        self.T()
        self.E_p()

    def E_p(self):
        if self.current() in ['+', '-']:
            self.next()
            self.T()
            self.E_p()

    def T(self):
        self.F()
        self.T_p()

    def T_p(self):
        if self.current() in ['*', '/']:
            self.next()
            self.F()
            self.T_p()

    def F(self):
        if self.current() == 'i':
            self.next()
        elif self.current() == '(':
            self.next()
            self.E()
            if self.current() == ')':
                self.next()
            else:
                raise Exception("Syntax Error")
        else:
            raise Exception("Syntax Error")

def tokenize(expression):
    tokens = []
    i = 0
    while i < len(expression):
        if expression[i].isspace():
            i += 1
        elif expression[i] in '+-*/()':
            tokens.append(expression[i])
            i += 1
        elif expression[i].isalpha() or expression[i].isdigit():
            while i < len(expression) and (expression[i].isalpha() or expression[i].isdigit()):
                i += 1
            tokens.append('i')
        else:
            return None
    return tokens

if __name__ == "__main__":
    parser = RecursiveDescentParser()
    tokens = tokenize(input())
    result = parser.parse(tokens)
    print("true" if result else "false")
