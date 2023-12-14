const std = @import("std");
const pow = std.math.pow;
const parseFloat = std.fmt.parseFloat;
const Expression = @import("./types/Expression.zig");
const AstNode = Expression.AstNode;
const AstNodeKind = Expression.AstNodeKind;
const toOperator = Expression.toValue;


pub fn evaluate(node: *AstNode) f64 {
    switch (node.*) {
        AstNodeKind.value => return node.*.value,
        AstNodeKind.binaryOperation => {
            
            const left = evaluate(node.*.binaryOperation.left);
            const right = evaluate(node.*.binaryOperation.right);

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