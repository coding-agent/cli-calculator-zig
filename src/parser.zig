const std = @import("std");
const heap_allocator = std.heap.page_allocator;
const eql = std.mem.eql;
const Token = @import("./types/Token.zig");
const TokenKind = Token.TokenKind;
const Operation = @import("./types/Operation.zig");
const Operator = Operation.Operator;

fn search_precedence(operator: Operator) !Operation.Precedence{
    return switch (operator) {
        .@"+" => return .SUM,
        .@"-" => return .MINUS,
        .@"/" => return .DIVIDE,
        .@"*" => return .MULTIPLY,
        .@"**" => return .POWER
    };
}
fn split_operations(tokens: []Token, operations_list: std.AutoHashMap(i32, Operation)) ![]Operation {
    for(tokens, 0..) |token, i| {
        if (token.kind == .LEFT_PARENTISIS) {
            _ = try split_operations(tokens[i..], operations_list);
        }
        

        if (token.kind == .OPERATOR) {
            const operator = std.meta.stringToEnum(Operator, token.value) orelse return error.Foo;
            const left = if(tokens[i-1].kind != .NUMBER) "x" else tokens[i-1].value;
            const right = if(tokens[i+1].kind != .NUMBER) "x" else tokens[i+1].value;
            var operation = Operation {
                .operator = operator,
                .precedence = try search_precedence(operator),
                .left_operand = left,
                .right_operand = right,
            };
            try operations_list.put(0, operation);
        }
    }
    return operations_list.toOwnedSlice();
}

fn calculate_operands(operation: Operation) !f16{
    return switch (operation) {
        Operator.@"+" => return operation.left_operand + operation.right_operand,
        Operator.@"-" => return operation.left_operand - operation.right_operand,
        Operator.@"*" => return operation.left_operand * operation.right_operand,
        Operator.@"/" => return operation.left_operand / operation.right_operand,

        _ => return error.unrecognized_operator,
    };
}

pub fn parser(tokens: []Token) !void{
    var Operations = std.AutoHashMap(i32, Operation).init(heap_allocator);
    defer Operations.clearAndFree();
    const operations_list = try split_operations(tokens, Operations);
    _ = operations_list;

    // for (operations_list) |operation| {
    //     std.debug.print("[operation] {c} {any} {c}\n", .{operation.left_operand, operation.operator, operation.right_operand});
    // }
    return;
}