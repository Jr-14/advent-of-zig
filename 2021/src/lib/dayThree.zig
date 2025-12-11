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
            std.debug.print("number is: {any} - adding zero\n", .{ binary_number });
            self.zeros += 1;
        } else {
            std.debug.print("number is: {any} - adding one\n", .{ binary_number });
            self.ones += 1;
        }
    }

    pub fn printValues(self: Self) void {
        std.debug.print("zeros: {d},  ones: {d}\n", .{ self.zeros, self.ones });
    }

    pub fn emitMostFrequent(self: Self) u1 {
        if (self.zeros > self.ones) {
            return 0;
        } else {
            return 1;
        }
    }

    pub fn emitLeastFrequent(self: Self) u1 {
        if (self.zeros > self.ones) {
            return 1;
        } else {
            return 0;
        }
    }
};

pub fn  dayThreePartOne() !void {
    var line_reader = try LineReader.init(file_path);
    defer line_reader.deinit();

    var gpa = std.heap.DebugAllocator(.{}){};
    defer _ = gpa.deinit();
    const allocator = gpa.allocator();

    var list = try std.ArrayList(u32).initCapacity(allocator, 1000);
    defer list.deinit(allocator);

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

    var most_frequent: [ARRAY_LENGTH]u1 = undefined;
    var least_frequent: [ARRAY_LENGTH]u1 = undefined;

    for (some_binary_array, 0..) |el, index| {
        most_frequent[index] = el.emitMostFrequent();
        least_frequent[index] = el.emitLeastFrequent();
    }

    std.debug.print("most: {any}\n", .{ most_frequent });
    std.debug.print("least: {any}\n", .{ least_frequent });

    // const most = std.mem.readPackedInt(u12, &most_frequent, 0, .big);
    // const least = std.mem.readPackedInt(u12, &least_frequent, 0, .big);

    // const most = std.mem.readInt(u16, &most_frequent, .big);
    // const least = std.mem.readInt(u16, &least_frequent, .big);

    const most: u32 = @bitCast(most_frequent);
    const least: u32 = @bitCast(least_frequent);

    std.debug.print("{any}, {any}\n", .{ most, least });
}

test "day three part one" {
    try dayThreePartOne();
    try expect(749376 == 749376);
}
