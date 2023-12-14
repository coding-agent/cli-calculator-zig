const eql = @import("std").mem.eql;
operator: Operator,
left_operand: []const u8,
right_operand: []const u8,

pub const Operator = enum(u16) {
    @"+",
    @"-",
    @"/",
    @"*",
    @"**",
};

pub const BinaryOperation = struct {
    operator: Operator,
    left: *AstNode,
    right: *AstNode
};

pub const AstNode = union (AstNodeKind) {
    value: f64,
    binaryOperation: BinaryOperation,
};

pub const AstNodeKind = enum(u16) {
    value,
    binaryOperation,
};

pub fn toEnum(c: []const u8) !Operator{
    if (eql(u8, c, "+"))  {return .@"+";}
    if (eql(u8, c, "-"))  {return .@"-";}
    if (eql(u8, c, "*"))  {return .@"*";}
    if (eql(u8, c, "/"))  {return .@"/";}
    if (eql(u8, c, "**")) {return .@"**";}
    return error.operator_not_found;
}

pub fn toValue(c: Operator) ![]const u8{
    if (c == .@"+") {return "+";}
    if (c == .@"-") {return "-";}
    if (c == .@"*") {return "*";}
    if (c == .@"/") {return "/";}
    if (c == .@"**") {return "**";}
    return error.operator_not_found;
}