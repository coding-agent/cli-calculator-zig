kind: TokenKind,
value: []const u8,

pub const TokenKind = enum {
    NUMBER,
    OPERATOR,
};