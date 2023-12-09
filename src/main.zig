const std = @import("std");
const Parser = @import("./parser.zig").parser;
const Lexer = @import("./lexer.zig").lexer;

pub fn main() !void {
    var general_purpose_allocator = std.heap.GeneralPurposeAllocator(.{}){};
    const gpa = general_purpose_allocator.allocator();
    const args = try std.process.argsAlloc(gpa);
    defer std.process.argsFree(gpa, args);

    for (args[1..]) |arg| {
        var tokens = try Lexer(arg);
        var parser = try Parser(tokens);
        _ = parser;
        for (tokens) |token| {
            std.debug.print("[operation] {any}: {s}\n", .{token.kind, token.value});
        }
        //var parser = try Parser(lexer);
    }
}