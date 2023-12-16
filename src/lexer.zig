const std = @import("std");
const heap_allocator = std.heap.page_allocator;
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

fn group_validator(char: u8, validator: *i8) void {
    if (char == '(') {
        validator.* += 1;
    }

    if (char == ')') {
        validator.* -= 1;
    }
}

pub fn lexer(arg: []const u8) ![]Token {
    var group_validation: i8 = 0;
    var tokens_list = std.ArrayList(Token).init(heap_allocator);

     var i:usize = 0;
    while(i < arg.len) : (i += 1) {
        const char: u8 = arg[i];

        if(isNumber(char)) {
            const start = i;
            while(i < arg.len and isNumber(arg[i])) : (i += 1) {}
            const token = tokenizer(TokenKind.NUMBER, arg[start..i]);
            if(arg[i-1] == '.') {return error.invalid_input;}
            try appendToken(&tokens_list, token);
            i-=1;
            continue;
        }

        if(isOperator(char)){
            if (arg[i] == '*' and arg[i+1] == '*') {
                const token = tokenizer(TokenKind.OPERATOR, arg[i..i+2]);
                i += 1;
                try appendToken(&tokens_list, token);
            } else {
                const token = tokenizer(TokenKind.OPERATOR, arg[i..i+1]);
                try appendToken(&tokens_list, token);
            }
            group_validator(char, &group_validation);
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
        '+', '-', '*', '/', '(', ')' => true,
        else => false
    };
}

fn isNumber(char: u8) bool {
    return switch (char) {
        '0' ... '9', '.' => true,
        else => false,
    };
}

