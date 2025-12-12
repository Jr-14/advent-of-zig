const LineReader = @import("LineReader.zig").LineReader;
const std = @import("std");
const expect = std.testing.expect;

const file_path = "./src/input/day-3-part-1.txt";

const SomeBinaryData = struct {
    zeros: u32 = 0,
    ones: u32 = 0,

    const Self = @This();

    pub fn incrementCount(self: *Self, binary_number: u8) void {
        if (binary_number == 0) {
            self.zeros += 1;
        } else {
            self.ones += 1;
        }
    }

    pub fn printValues(self: Self) void {
        std.debug.print("zeros: {d},  ones: {d}\n", .{ self.zeros, self.ones });
    }

    pub fn emitMostFrequent(self: Self) u8 {
        if (self.zeros > self.ones) {
            return 0;
        } else {
            return 1;
        }
    }

    pub fn emitLeastFrequent(self: Self) u8 {
        if (self.zeros > self.ones) {
            return 1;
        } else {
            return 0;
        }
    }
};

fn arrayToInt(arr: *const [12]u8) u32 {
    var i: u32 = 12;
    var total: u32 = 0;
    while (i > 0) {
        i -= 1;
        if (arr[i] > 0) {
            total += std.math.pow(u32, 2, 11 - i);
        }
    }
    return total;
}

pub fn  dayThreePartOne() !u32 {
    var line_reader = try LineReader.init(file_path);
    defer line_reader.deinit();

    // var gpa = std.heap.DebugAllocator(.{}){};
    // defer _ = gpa.deinit();
    // const allocator = gpa.allocator();

    // var list = try std.ArrayList(u32).initCapacity(allocator, 1000);
    // defer list.deinit(allocator);

    const ARRAY_LENGTH: usize = 12;

    var some_binary_array = [ARRAY_LENGTH]SomeBinaryData{
        SomeBinaryData{},
        SomeBinaryData{},
        SomeBinaryData{},
        SomeBinaryData{},
        SomeBinaryData{},
        SomeBinaryData{},
        SomeBinaryData{},
        SomeBinaryData{},
        SomeBinaryData{},
        SomeBinaryData{},
        SomeBinaryData{},
        SomeBinaryData{},
    };

    while (try line_reader.nextLine()) |line| {
        for (line, 0..) |char, index| {
            const b = char - '0';

            some_binary_array[index].incrementCount(b);
        }
    }

    var most_frequent: [ARRAY_LENGTH]u8 = undefined;
    var least_frequent: [ARRAY_LENGTH]u8 = undefined;

    for (some_binary_array, 0..) |el, index| {
        most_frequent[index] = el.emitMostFrequent();
        least_frequent[index] = el.emitLeastFrequent();
    }

    // std.debug.print("most: {any}\n", .{ most_frequent });
    // std.debug.print("least: {any}\n", .{ least_frequent });

    const most: u32 = arrayToInt(&most_frequent);
    const least: u32 = arrayToInt(&least_frequent);
    const total_power: u32 = most * least;

    std.debug.print("most: {any}, least: {any}, total: {any}\n", .{ most, least, total_power });

    return total_power;
}

test "day three part one" {
    const value = try dayThreePartOne();
    try expect(value == 749376);
}
