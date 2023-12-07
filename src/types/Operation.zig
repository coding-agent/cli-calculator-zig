operator: Operator,
operand1: []const u8,
operand2: []const u8,

pub const Operator = enum ([]u8) {
    SUM = "+",
    MINUS = "-",
    DIVISION = "/",
    MULTIPLICATION = "*",
};