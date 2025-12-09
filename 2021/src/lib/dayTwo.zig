const LineReader = @import("LineReader.zig").LineReader;
const std = @import("std");
const expect = std.testing.expect;

const file_path = "./src/input/day-2-part-1.txt";

pub fn dayTwoPartOne() !u32 {
    var line_reader = try LineReader.init(file_path);
    defer line_reader.deinit();

    var horizontal_amount: u32 = 0;
    var depth: u32 = 0;

    while (try line_reader.nextLine()) |line| {
        var direction: []const u8 = undefined;
        var amount: u32 = undefined;
        var s = std.mem.splitAny(u8, line, " ");

        if (s.next()) |dir| {
            direction = dir;
        }
        if (s.next()) |amnt| {
            amount = try std.fmt.parseInt(u32, amnt, 10);
        }

        if (std.mem.eql(u8, direction,"forward")) {
            horizontal_amount += amount;
        } else if (std.mem.eql(u8, direction, "down")) {
            depth += amount;
        } else {
            depth -= amount;
        }
    }

    const value = horizontal_amount * depth;
    std.debug.print("{d}\n", .{ value });
    return value;
}

test "AOC 2021 Day 2 - Part 1" {
    const value = try dayTwoPartOne();
    try expect(value == 1507611);
}
