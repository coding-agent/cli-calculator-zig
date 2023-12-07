const std = @import("std");
const Allocator = std.heap.page_allocator;

const TokenKind =  enum {
    NUMBER,
    OPERATOR,
    
};

const Token = struct {
    kind: TokenKind,
    value: []const u8,
};

fn tokenizer(kind: TokenKind, value: []const u8) Token{
    return Token {
        .kind = kind,
        .value = value
    };
}

fn appendToken(tokens: *std.ArrayList(Token), token: Token) !void {
    try tokens.append(token);
}

pub fn lexer(arg: []const u8) ![]Token {
    var tokens_list = std.ArrayList(Token).init(Allocator);

     var i:usize = 0;
    while(i < arg.len) : (i += 1) {
        const char: u8 = arg[i];

        if(isNumber(char)) {
            const start = i;
            while(i < arg.len and isNumber(arg[i])) : (i += 1) {}
            const token = tokenizer(TokenKind.Number, arg[start..i]);
            try appendToken(&tokens_list, token);
            i-=1;
            continue;
        }

        if(isOperator(char)){
            const token = tokenizer(TokenKind.Operator, arg[i..i+1]);
            try appendToken(&tokens_list, token);
            continue;
        }
        return error.invalid_character;
    }
    return tokens_list.toOwnedSlice();
}

fn isOperator(char: u8) bool {
    return switch (char) {
        '+', '-', '*', '/', '(', ')' => true,
        else => false
    };
}

fn isNumber(char: u8) bool {
    return switch (char) {
        '0' ... '9' => true,
        else => false,
    };
}