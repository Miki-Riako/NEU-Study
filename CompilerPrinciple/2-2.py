'''
Automata

E -> T | E+T | E-T
T -> F | T*F | T/F
F -> i | (E)
''''''
Precedence Table

\ | + - * / ( ) i #
--+----------------
+ | > > < < < > < >
- | > > < < < > < >
* | > > > > < > < >
/ | > > > > < > < >
( | < < < < < = <  
) | > > > >   >   >
i | > > > >   >   >
# | < < < < <   < =
'''
class OperatorPrecedenceParser:
    def __init__(self):
        # self.non_terminal_table = {
        #     ...
        # }
        
        self.precedence_table = {
            '+': {'+': '>', '-': '>', '*': '<', '/': '<', '(': '<', ')': '>', 'i': '<', '#': '>'},
            '-': {'+': '>', '-': '>', '*': '<', '/': '<', '(': '<', ')': '>', 'i': '<', '#': '>'},
            '*': {'+': '>', '-': '>', '*': '>', '/': '>', '(': '<', ')': '>', 'i': '<', '#': '>'},
            '/': {'+': '>', '-': '>', '*': '>', '/': '>', '(': '<', ')': '>', 'i': '<', '#': '>'},
            '(': {'+': '<', '-': '<', '*': '<', '/': '<', '(': '<', ')': '=', 'i': '<', '#': '' },
            ')': {'+': '>', '-': '>', '*': '>', '/': '>', '(': '',  ')': '>', 'i': '',  '#': '>'},
            'i': {'+': '>', '-': '>', '*': '>', '/': '>', '(': '',  ')': '>', 'i': '',  '#': '>'},
            '#': {'+': '<', '-': '<', '*': '<', '/': '<', '(': '<', ')': '',  'i': '<', '#': '='}
        }

    def parse(self, tokens):
        if tokens is None:
            return False
        tokens = ['#'] + tokens + ['#']
        stack = ['#']
        i = 1
        while i < len(tokens):
            top = stack[-1]
            current = tokens[i]
            if top == '#' and current == '#':
                return len(stack) == 1
            precedence = self.precedence_table[top][current]
            
            if precedence == '<' or precedence == '=':
                stack.append(current)
                i += 1
            elif precedence == '>':
                while True:
                    top = stack[-1]
                    stack.pop()
                    if self.precedence_table[stack[-1]][top] == '<':
                        break
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
    parser = OperatorPrecedenceParser()
    tokens = tokenize(input())
    result = parser.parse(tokens)
    print("true" if result else "false")
