const std = @import("std");
const print = std.debug.print;
const expect = std.testing.expect;

const LineReader = @import("LineReader.zig").LineReader;

const file_path = "./src/input/day-1-part-1.txt";

pub fn dayOnePartOne() !u32 {
    var line_reader = try LineReader.init(file_path);
    defer line_reader.deinit();

    var curr: u32 = undefined;
    var prev: u32 = undefined;
    var inc_count: u32 = 0;

    if (try line_reader.nextLine()) |line| {
        curr = try std.fmt.parseInt(u32, line, 10);
    }

    while (try line_reader.nextLine()) |line| {
        prev = curr;
        curr = try std.fmt.parseInt(u32, line, 10);

        if (curr > prev) {
            inc_count += 1;
        }
    }

    print("{d}\n", .{ inc_count });
    return inc_count;
}

const Window = struct {
    acc: u32 = 0,
    count: u32 = 0,
    skip: bool = false,

    const Self = @This();

    pub fn init(skip: bool) Window {
        return Window {
            .acc = 0,
            .count = 0,
            .skip = skip,
        };
    }

    pub fn accumulate(self: *Self, value: u32) void {
        self.acc += value;
        self.count += 1;
    }

    pub fn clear(self: *Self) void {
        self.count = 0;
        self.acc = 0;
    }
};

pub fn dayOnePartTwo() !u32 {
    var line_reader = try LineReader.init(file_path);
    defer line_reader.deinit();

    var a: Window = Window.init(false);
    var b: Window = Window.init(false);
    var c: Window = Window.init(false);
    var d: Window = Window.init(true);
    var inc_count: u32 = 0;

    if (try line_reader.nextLine()) |line| {
        a.accumulate(try std.fmt.parseInt(u32, line, 10));
    }
    if (try line_reader.nextLine()) |line| {
        const parsed = try std.fmt.parseInt(u32, line, 10);
        a.accumulate(parsed);
        b.accumulate(parsed);
    }
    if (try line_reader.nextLine()) |line| {
        const parsed = try std.fmt.parseInt(u32, line, 10);
        a.accumulate(parsed);
        b.accumulate(parsed);
        c.accumulate(parsed);
    }

    var prev_inc: u32 = a.acc;

    while (try line_reader.nextLine()) |line| {
        const parsed = try std.fmt.parseInt(u32, line, 10);

        if (a.count < 3) {
            a.accumulate(parsed);
        }
        if (b.count < 3) {
            b.accumulate(parsed);
        }
        if (c.count < 3) {
            c.accumulate(parsed);
        }
        if (d.count < 3) {
            d.accumulate(parsed);
        }

        if (a.count == b.count and b.count == 3) {
            if (prev_inc < b.acc) {
                inc_count += 1;
            }
            a.clear();
            prev_inc = b.acc;
        }

        if (b.count == c.count and c.count == 3) {
            if (prev_inc < c.acc) {
                inc_count += 1;
            }
            b.clear();
            prev_inc = c.acc;
        }

        if (c.count == d.count and d.count == 3) {
            if (prev_inc < d.acc) {
                inc_count += 1;
            }
            c.clear();
            prev_inc = d.acc;
        }

        if (d.count == a.count and a.count == 3) {
            if (prev_inc < a.acc) {
                inc_count += 1;
            }
            d.clear();
            prev_inc = a.acc;
        }
    }

    print("{d}\n", .{ inc_count });
    return inc_count;
}

test "AOC 2021 Day 1 - Part 1" {
    const value = try dayOnePartOne();
    try expect(value == 1502);
}

test "AOC 2021 Day 1 - Part 2" {
    const value = try dayOnePartTwo();
    try expect(value == 1538);
}
