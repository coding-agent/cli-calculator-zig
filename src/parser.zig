const std = @import("std");
const parseFloat = std.fmt.parseFloat;
const eql = std.mem.eql;
const heap_allocator = std.heap.page_allocator;
const Token = @import("./types/Token.zig");
const Expression = @import("./types/Expression.zig");
const TokenKind = Token.TokenKind;
const BinaryOperation = Expression.BinaryOperation;
const Operator = Expression.Operator;
const AstNode = Expression.AstNode;


fn parseOperation(tokens: []Token, ast: *AstNode) !void{
    _ = ast;
    _ = tokens;
}

fn buildAst(tokens: []Token, ast: *AstNode) !AstNode {
    if (tokens.len <= 2) { 
        return ast.*;
    }
    const currentToken = tokens[0];
    
    switch (currentToken.kind) {
        .NUMBER => {
            var left_node = AstNode{
                .value = try parseFloat(f64, currentToken.value)
            };
            var operator = try Expression.toEnum(tokens[1].value);
            var nextToken = tokens[2];
            var right_node = try switch (nextToken.value[0]) {
                '0' ... '9' => AstNode{
                    .value = try parseFloat(f64, currentToken.value)
                },
                '(', ')' => error.lexer_fault,
                else => try buildAst(tokens[2..], &ast.*)
            };
            return AstNode {
                .binaryOperation = BinaryOperation {
                    .left = &left_node,
                    .right = &right_node,
                    .operator = operator,
                }
            };
        },

        .OPERATOR => {
            return switch (currentToken.value[0]) {
                '(', ')' => try buildAst(tokens[1..], &ast.*),
                '+', '-', '/', '*' => error.expected_number,
                else => {
                    std.debug.print("{s}\n", .{currentToken.value});
                    return error.lexer_fault;
                }
            };
        },
    }

    return ast.*;
}

pub fn parser(tokens: []Token) !AstNode{
    var ast: AstNode = undefined;
    _ = try buildAst(tokens, &ast);
    //std.debug.print("{any}", .{ast});
    return ast;
}