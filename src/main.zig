const std = @import("std");
const print = std.debug.print;
const Parser = @import("./parser.zig").parser;
const Lexer = @import("./lexer.zig").lexer;
const evaluate = @import("./evaluate.zig").evaluate;
const AstNode = @import("./types/Expression.zig").AstNode;

pub fn main() !void {
    var general_purpose_allocator = std.heap.GeneralPurposeAllocator(.{}){};
    const gpa = general_purpose_allocator.allocator();
    const gpa_ast = general_purpose_allocator.allocator();
    const args = try std.process.argsAlloc(gpa);
    defer std.process.argsFree(gpa, args);

    for (args[1..]) |arg| {
        var tokens = try Lexer(arg);
        var ast = try Parser(tokens, gpa_ast);
        var result = evaluate(&ast, gpa_ast);
        _ = result;
        //print("{any}", .{ast});
        //print("result: {d}", .{result});
    }
}