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

pub fn dayTwoPartTwo() !i32 {
    var line_reader = try LineReader.init(file_path);
    defer line_reader.deinit();
    
    var horizontal_amount: i32 = 0;
    var depth: i32 = 0;
    var aim: i32 = 0;

    while (try line_reader.nextLine()) |line| {
        var line_iter = std.mem.splitAny(u8, line, " ");

        var direction: []const u8 = undefined;
        var amount: i32 = undefined;
        if (line_iter.next()) |n| {
            direction = n;
        }
        if (line_iter.next()) |n| {
            amount = try std.fmt.parseInt(i32, n, 10);
        }

        if (std.mem.eql(u8, direction, "down")) {
            aim += amount;
        } else if (std.mem.eql(u8, direction, "up")) {
            aim -= amount;
        } else { // forward
            horizontal_amount += amount;
            depth += (aim * amount);
        }
    }

    const total = depth * horizontal_amount;

    std.debug.print("{d}\n", .{ total });
    return total;
}

test "AOC 2021 Day 2 - Part 1" {
    const value = try dayTwoPartOne();
    try expect(value == 1507611);
}

test "AOC 2021 Day 2 - Part 2" {
    const value = try dayTwoPartTwo();
    try expect(value == 1880593125);
}
