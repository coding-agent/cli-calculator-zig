const std = @import("std");
const Allocator = std.heap.page_allocator;
const Token = @import("./types/Token.zig");
const TokenKind = @import("./types/Token.zig").TokenKind;

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
    var group_validation: i8 = 0;
    var tokens_list = std.ArrayList(Token).init(Allocator);

     var i:usize = 0;
    while(i < arg.len) : (i += 1) {
        const char: u8 = arg[i];

        if(isNumber(char)) {
            const start = i;
            while(i < arg.len and isNumber(arg[i])) : (i += 1) {}
            const token = tokenizer(TokenKind.NUMBER, arg[start..i]);
            try appendToken(&tokens_list, token);
            i-=1;
            continue;
        }

        if(isOperator(char)){
            const token = tokenizer(TokenKind.OPERATOR, arg[i..i+1]);
            try appendToken(&tokens_list, token);
            continue;
        }
        if (char == '(') {
            group_validation += 1;
            const token = tokenizer(TokenKind.GROUP, arg[i..i+1]);
            try appendToken(&tokens_list, token);
            continue;
        }

        if (char == ')') {
            group_validation -= 1;
            const token = tokenizer(TokenKind.GROUP, arg[i..i+1]);
            try appendToken(&tokens_list, token);
            continue;
        }
        return error.invalid_character;
    }
    if(group_validation != 0) {
        return error.parentisis_error;
    }
    return tokens_list.toOwnedSlice();
}

fn isOperator(char: u8) bool {
    return switch (char) {
        '+', '-', '*', '/' => true,
        else => false
    };
}

fn isNumber(char: u8) bool {
    return switch (char) {
        '0' ... '9' => true,
        else => false,
    };
}

