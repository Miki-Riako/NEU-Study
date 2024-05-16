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
        self.re_float       = re.compile(r'\b\d+(\.\d+([eE][+-]?\d+)?|[eE][+-]?\d+)\b')
        self.re_decimal     = re.compile(r'\b\d+\b')
        self.re_hexadecimal = re.compile(r'\b0[xX][0-9a-fA-F]+\b')
        self.re_char        = re.compile(r"'([^'\\]|\\.)'")
        self.re_string      = re.compile(r'"((?:[^"\\]|\\.)*)"')
        self.identifiers      = []
        self.constants_int    = []
        self.constants_float  = []
        self.constants_char   = []
        self.constants_string = []
        self.tokens           = []
        self.error = False
    
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
            
            match = self.re_hexadecimal.match(string, pos)
            if match:
                hex_value = str(int(match.group(), 16))
                if hex_value not in self.constants_int:
                    self.constants_int.append(hex_value)
                self.tokens.append(('C1', self.constants_int.index(hex_value) + 1))
                pos = match.end()
                continue
            
            match = self.re_float.match(string, pos)
            if match:
                float_value = match.group()
                if float_value not in self.constants_float:
                    self.constants_float.append(float_value)
                self.tokens.append(('C2', self.constants_float.index(float_value) + 1))
                pos = match.end()
                continue
            
            match = self.re_decimal.match(string, pos)
            if match:
                decimal_value = match.group()
                if decimal_value not in self.constants_int:
                    self.constants_int.append(decimal_value)
                self.tokens.append(('C1', self.constants_int.index(decimal_value) + 1))
                pos = match.end()
                continue
            
            match = self.re_char.match(string, pos)
            if match:
                char_value = match.group(1)
                if char_value not in self.constants_char:
                    self.constants_char.append(char_value)
                self.tokens.append(('CT', self.constants_char.index(char_value) + 1))
                pos = match.end()
                continue
            
            match = self.re_string.match(string, pos)
            if match:
                string_value = match.group(1)
                if string_value not in self.constants_string:
                    self.constants_string.append(string_value)
                self.tokens.append(('ST', self.constants_string.index(string_value) + 1))
                pos = match.end()
                continue
            
            if not string[pos].isspace():
                self.error = True
                return
            
            pos += 1
    
    def show(self):
        if (self.error):
            print("ERROR")
            return
        
        print("Token :", end='')
        for token in self.tokens:
            print(f"({token[0]} {token[1]})", end='')
        print()
        print("I :"  + ' '.join(self.identifiers))
        print("C1 :" + ' '.join(self.constants_int))
        print("C2 :" + ' '.join(self.constants_float))
        print("CT :" + ' '.join(self.constants_char))
        print("ST :" + ' '.join(self.constants_string))

if __name__ == "__main__":
    scanner = Scanner()
    scanner.scan(input())
    scanner.show()
