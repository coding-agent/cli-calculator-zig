const eql = @import("std").mem.eql;
operator: Operator,
left_operand: []const u8,
right_operand: []const u8,

pub const AstNodeKind = enum(u16) {
    Number,
    Operation,
};


pub const Operator = enum(u16) {
    @"+",
    @"-",
    @"/",
    @"*",
    @"**",
};

pub const Operation = struct {
    operator: Operator,
    left: *AstNode,
    right: *AstNode};

pub const AstNode = union (AstNodeKind) {
    Number: f64,
    Operation: Operation,
};

pub fn toEnum(c: []const u8) !Operator{
    if (eql(u8, c, "+")) {return .@"+";}
    if (eql(u8, c, "-")) {return .@"-";}
    if (eql(u8, c, "*")) {return .@"*";}
    if (eql(u8, c, "/")) {return .@"/";}
    if (eql(u8, c, "**")) {return .@"**";}
    return error.operator_not_found;
}
