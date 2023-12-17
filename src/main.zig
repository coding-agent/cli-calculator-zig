const std = @import("std");
const print = std.debug.print;
const Parser = @import("./parser.zig").parser;
const Lexer = @import("./lexer.zig").lexer;
const evaluate = @import("./evaluate.zig").evaluate;
const AstNode = @import("./types/Expression.zig").AstNode;

pub fn main() !void {
    var general_purpose_allocator = std.heap.GeneralPurposeAllocator(.{}){};
    const gpa = general_purpose_allocator.allocator();
    const args = try std.process.argsAlloc(gpa);
    var arena = std.heap.ArenaAllocator.init(general_purpose_allocator.allocator());
    const allocator = arena.allocator();
    defer std.process.argsFree(gpa, args);
    defer arena.deinit();

    for (args[1..]) |arg| {
        if (arg.len == 1) {
            switch (arg[0]) {
                '0'...'9' => print("Result: {s}\n", .{arg}),
                else => {
                    print("Wrong entry", .{});
                }
            }
            break;
        }
        var tokens = try Lexer(arg);
        var ast = try Parser(tokens, allocator);
        var result = try evaluate(ast, allocator);
        print("Result: {d}\n", .{result});
    }
}