const std = @import("std");
const fs = std.fs;
const print = std.debug.print;

const file_path = "./src/input/day-1-part-1.txt";

pub fn main() !void {
    const file = try fs.cwd().openFile(file_path, .{});
    defer file.close();

    var file_buffer: [4096]u8 = undefined;
    var reader = file.reader(&file_buffer);
    while (try reader.interface.takeDelimiter('\n')) |line| {
        print("{s}\n", .{ line });
    }
}
