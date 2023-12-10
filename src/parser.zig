const std = @import("std");
const eql = std.mem.eql;
const heap_allocator = std.heap.page_allocator;
const Token = @import("./types/Token.zig");
const Expression = @import("./types/Expression.zig");
const TokenKind = Token.TokenKind;
const Operator = Expression.Operator;

fn parseExpression(tokens: []Token) ![]Expression{
    _ = tokens;
    return;
}

fn calculate() f64{
    return;
}

pub fn parser(tokens: []Token) !void{
    var expessions = std.ArrayList(Expression).init(heap_allocator);
    defer expessions.clearAndFree();

    _ = try parseExpression(tokens);

    return;
}