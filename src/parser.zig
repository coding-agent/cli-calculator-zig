const std = @import("std");
const lexer = @import("./lexer.zig").lexer;

const Operator = enum (u8) {
    SUM = '+',
    MINUS = '-'
    
};

const Operation = struct {
    operator: []const u8,
    operand1: []const u8,
    operand2: []const u8
};

fn disjunctor() void {}

fn calculate_operands(operator: []const u8, operand1: []const u8, operand2: []const u8) ![]const u8{
    _ = operator;
    _ = operand2;
    _ = operand1;
    return "";
}

pub fn parser(arg: []const u8) !void{
    const tokens = try lexer(arg);
    for (tokens) |token| {
        std.debug.print("[tokens] kind: {any} and value: {s}\n", .{token.kind, token.value});
    }
    return;
}