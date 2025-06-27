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
''''''
first
    E:  i(
    E': +-
    T:  i(
    T': */
    F:  i(
follow
    E': )#
    T': +-)#
select
    E:  i()#
    E': +-
    T:  i(
    T': +-*/)#
    F:  i(
'''
class LL1Parser:
    def __init__(self):
        self.parse_table = {
            'E': {
                'i': ['T', 'E\''],
                '(': ['T', 'E\'']
            },
            'E\'': {
                '+': ['+', 'T', 'E\''],
                '-': ['-', 'T', 'E\''],
                ')': [],
                '#': []
            },
            'T': {
                'i': ['F', 'T\''],
                '(': ['F', 'T\'']
            },
            'T\'': {
                '+': [],
                '-': [],
                '*': ['*', 'F', 'T\''],
                '/': ['/', 'F', 'T\''],
                ')': [],
                '#': []
            },
            'F': {
                'i': ['i'],
                '(': ['(','E', ')']
            }
        }
        self.terminals     = {'+', '-', '*', '/', '(', ')', 'i', '#'}
        self.non_terminals = {'E', 'E\'', 'T', 'T\'', 'F'}

    def parse(self, tokens):
        if tokens is None:
            return False
        
        tokens.append('#')
        stack = ['#', 'E']
        index = 0

        while stack:
            top = stack.pop()
            current = tokens[index]

            if top in self.terminals:
                if top == current:
                    index += 1
                    if top == '#':
                        return True
                else:
                    return False
            elif top in self.non_terminals:
                if current in self.parse_table[top]:
                    production = self.parse_table[top][current]
                    if not production:
                        continue
                    else:
                        stack.extend(reversed(production))
                else:
                    return False
            else:
                return False
        return False

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
    parser = LL1Parser()
    tokens = tokenize(input())
    result = parser.parse(tokens)
    print("true" if result else "false")
