const std = @import("std");
const pow = std.math.pow;
const parseFloat = std.fmt.parseFloat;
const Expression = @import("./types/Expression.zig");
const AstNode = Expression.AstNode;
const AstNodeKind = Expression.AstNodeKind;
const toOperator = Expression.toValue;
const Allocator  = std.mem.Allocator;


pub fn evaluate(node: *AstNode, allocator: Allocator) f64 {
    switch (node.*) {
        AstNodeKind.value => return node.*.value,
        AstNodeKind.binaryOperation => {
            const left = evaluate(node.*.binaryOperation.left, allocator);
            const right = evaluate(node.*.binaryOperation.right, allocator);
            defer allocator.destroy(left);
            defer allocator.destroy(right);

            switch (node.binaryOperation.operator) {
                .@"+" => return left + right,
                .@"-" => return left - right,
                .@"*" => return left * right,
                .@"/" => return left / right,
                .@"**" => return pow(f64, left, right),
            }
        }
    }
}