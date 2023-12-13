const std = @import("std");
const eql = std.mem.eql;
const heap_allocator = std.heap.page_allocator;
const Token = @import("./types/Token.zig");
const Expression = @import("./types/Expression.zig");
const TokenKind = Token.TokenKind;
const Operator = Expression.Operator;
const AstNode = Expression.AstNode;


fn parseToken(tokens: []Token, ast: *AstNode) !void{
    _ = ast;
    _ = tokens;
}

fn buildAst(tokens: []Token) !void {
    _ = tokens;
}

pub fn parser(tokens: []Token) !f64{
    try buildAst(tokens);
    //std.debug.print("ast {any}", .{ast});
    return 0;
}