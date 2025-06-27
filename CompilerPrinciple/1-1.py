import re

class Scanner:
    def __init__(self):
        self.keywords = [
            "int",   "void", "break", "float",  "while", "do",      "struct",
            "const", "case", "for",   "return", "if",    "default", "else"
        ]
        self.punctuation = [
            "-", "/", "(", ")", "==", "<=", "<", "+",
            "*", ">", "=", ",", ";",  "++", "{", "}"
        ]
        self.re_keywords    = re.compile(r'\b(' + '|'.join(self.keywords) + r')\b')
        self.re_punctuation = re.compile(r'==|<=|>=|\+\+|[-/()<+*>=,;{}]')
        self.re_identifier  = re.compile(r'\b[a-zA-Z_][a-zA-Z0-9_]*\b')
        self.re_number      = re.compile(r'\b\d+\b')
        self.identifiers = []
        self.constants   = []
        self.tokens      = []

    def scan(self, string):
        pos = 0
        while pos < len(string):
            match = self.re_keywords.match(string, pos)
            if match:
                self.tokens.append(('K', self.keywords.index(match.group()) + 1))
                pos = match.end()
                continue
            
            match = self.re_punctuation.match(string, pos)
            if match:
                self.tokens.append(('P', self.punctuation.index(match.group()) + 1))
                pos = match.end()
                continue
            
            match = self.re_identifier.match(string, pos)
            if match:
                identifier = match.group()
                if identifier not in self.identifiers:
                    self.identifiers.append(identifier)
                self.tokens.append(('I', self.identifiers.index(identifier) + 1))
                pos = match.end()
                continue
            
            match = self.re_number.match(string, pos)
            if match:
                constant = match.group()
                if constant not in self.constants:
                    self.constants.append(constant)
                self.tokens.append(('C', self.constants.index(constant) + 1))
                pos = match.end()
                continue
            
            pos += 1
    
    def show(self):
        print("Token :", end='')
        for token in self.tokens:
            print(f"({token[0]} {token[1]})", end='')
        print()
        print("I :" + ' '.join(self.identifiers))
        print("C :" + ' '.join(self.constants))

if __name__ == "__main__":
    scanner = Scanner()
    scanner.scan(input())
    scanner.show()
