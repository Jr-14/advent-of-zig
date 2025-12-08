const std = @import("std");

pub fn main() !void {
    var arena = std.heap.ArenaAllocator.init(std.heap.page_allocator);
    defer arena.deinit();
    const allocator = arena.allocator();

    var file = try std.fs.cwd().openFile("./src/input/day-1-part-1.txt", .{});
    defer file.close();

    const contents = try file.readToEndAlloc(allocator, 5000000);
    defer allocator.free(contents);

    std.debug.print("{s}", .{contents});
}

