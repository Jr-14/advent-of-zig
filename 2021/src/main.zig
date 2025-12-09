const std = @import("std");
const fs = std.fs;
const print = std.debug.print;
const expect = std.testing.expect;

pub fn main() !void {
}

pub fn dayOnePartOne() !u32 {
    const file_path = "./src/input/day-1-part-1.txt";
    const file = try fs.cwd().openFile(file_path, .{});
    defer file.close();

    var file_buffer: [4096]u8 = undefined;
    var reader = file.reader(&file_buffer);

    var curr: u32 = undefined;
    var prev: u32 = undefined;
    var inc_count: u32 = 0;
    if (try reader.interface.takeDelimiter('\n')) |line| {
        curr = try std.fmt.parseInt(u32, line, 10);
    }
    while (try reader.interface.takeDelimiter('\n')) |line| {
        prev = curr;
        curr = try std.fmt.parseInt(u32, line, 10);
        
        if (curr > prev) {
            inc_count += 1;
        }
    }

    print("{d}\n", .{ inc_count });
    return inc_count;
}

test "AOC 2021 Day 1 - Part 1" {
    const value = try dayOnePartOne();
    try expect(value == 1502);
}
