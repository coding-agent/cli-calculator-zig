const std = @import("std");
const parseFloat = std.fmt.parseFloat;
const eql = std.mem.eql;
const Allocator  = std.mem.Allocator;
const Token = @import("./types/Token.zig");
const Expression = @import("./types/Expression.zig");
const TokenKind = Token.TokenKind;
const BinaryOperation = Expression.BinaryOperation;
const Operator = Expression.Operator;
const AstNode = Expression.AstNode;

fn allocateAstNode(allocator: Allocator) !*AstNode{
    return Allocator.create(allocator, AstNode);
}

fn parseOperation(tokens: []Token, ast: *AstNode) !void{
    _ = ast;
    _ = tokens;
}

fn buildAst(tokens: []Token, ast: *AstNode , allocator: Allocator) !AstNode {
    if (tokens.len <= 2) { 
        return ast.*;
    }
    const currentToken = tokens[0];
    
    switch (currentToken.kind) {
        .NUMBER => {
            var left_node = try allocateAstNode(allocator);
            var right_node = try allocateAstNode(allocator);
            left_node.* = .{.value = try parseFloat(f64, currentToken.value)};
            var operator = try Expression.toEnum(tokens[1].value);
            right_node.* = try switch (tokens[2].value[0]) {
                '0' ... '9' => AstNode{
                    .value = try parseFloat(f64, tokens[2].value)
                },
                '(', ')' => error.lexer_fault,
                else => try buildAst(tokens[2..], &ast.*, allocator)
            };
            return AstNode {
                .binaryOperation = BinaryOperation {
                    .left = left_node,
                    .right = right_node,
                    .operator = operator,
                }
            };
        },

        .OPERATOR => {
            return switch (currentToken.value[0]) {
                '(', ')' => try buildAst(tokens[1..], &ast.*, allocator),
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

pub fn parser(tokens: []Token, allocator: Allocator) !AstNode{
    var ast: AstNode = undefined;
    var finalAst = try buildAst(tokens, &ast, allocator);
    return finalAst;
}