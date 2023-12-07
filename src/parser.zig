const std = @import("std");
const Token = @import("./types/Token.zig");
const TokenKind = Token.TokenKind;
const Operation = @import("./types/Operation.zig");
const Operator = Operation.Operator;

fn disjunctor(tokens: []Token) []Operation {
    for(tokens) |token| {
        if (token.kind == TokenKind.OPERATOR) {}
    }
}

fn calculate_operands(op: Operation) f16{
    _ = op;
    return "";
}

pub fn parser(tokens: []Token) !void{
    for (tokens) |token| {
        std.debug.print("[tokens] kind: {any} and value: {s}\n", .{token.kind, token.value});
    }
    return;
}