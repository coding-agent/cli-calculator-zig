const std = @import("std");
const pow = std.math.pow;
const parseFloat = std.fmt.parseFloat;
const Expression = @import("./types/Expression.zig");
const AstNode = Expression.AstNode;
const AstNodeKind = Expression.AstNodeKind;
const toOperator = Expression.toValue;
const Allocator  = std.mem.Allocator;


pub fn evaluate(node: AstNode, allocator: Allocator) !f64 {
    try switch (node) {
        .value => |v| return v,
        .binaryOperation => |operation| {
            const left = try evaluate(operation.left.*, allocator);
            const right = try evaluate(operation.right.*, allocator);

            try switch (operation.operator) {
                .@"+" => return left + right,
                .@"-" => return left - right,
                .@"*" => return left * right,
                .@"/" => return left / right,
                .@"**" => return pow(f64, left, right),
            };
            
        }
    };
}