const std = @import("std");
const eql = std.mem.eql;
const heap_allocator = std.heap.page_allocator;
const Token = @import("./types/Token.zig");
const Expression = @import("./types/Expression.zig");
const TokenKind = Token.TokenKind;
const Operator = Expression.Operator;
const AstNode = Expression.AstNode;



fn parseToken(tokens: []Token, ast: *AstNode) !AstNode{
    _ = tokens;
    return ast.*;
}

fn buildAst(tokens: []Token) !AstNode{
    var current_token = tokens[0];
    var ast: AstNode = undefined;
    switch (current_token.kind) {
        .NUMBER => {
            var number = try std.fmt.parseFloat(f64, current_token.value);
            ast = AstNode {
                .Number = number,
            };
        },

        .LEFT_PARENTISIS => {
            _ = try parseToken(tokens[1..], &ast);
        },

        else => return error.must_start_with_number_or_opening_parentisis,
    }
    return ast;
}

pub fn parser(tokens: []Token) !f64{
    const ast = try buildAst(tokens);
    std.debug.print("ast {any}", .{ast});
    return 0;
}