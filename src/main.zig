const std = @import("std");
const print = std.debug.print;
const parser = @import("./parser.zig").parser;

pub fn main() !void {
    var general_purpose_allocator = std.heap.GeneralPurposeAllocator(.{}){};
    const gpa = general_purpose_allocator.allocator();
    const args = try std.process.argsAlloc(gpa);
    defer std.process.argsFree(gpa, args);

    for (args[1..]) |arg| {
        try parser(arg);
    }
}