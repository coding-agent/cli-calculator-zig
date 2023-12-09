const std = @import("std");
operator: Operator,
precedence: Precedence,
left_operand: []const u8,
right_operand: []const u8,

pub const Operator = enum(u16) {
    @"+",
    @"-",
    @"/",
    @"*",
    @"**",
};

pub const Precedence = enum(i32) {
        SUM = 0,
        MINUS = 1,
        MULTIPLY = 2,
        DIVIDE = 3,
        POWER = 4,
        LPAREN = 5,
};