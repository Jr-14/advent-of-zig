const std = @import("std");

pub const LineReader = struct {
    file: std.fs.File,
    buffer: [4096]u8 = undefined,
    reader: *std.Io.Reader,

    const Self = @This();

    pub fn init(path: []const u8) !Self {
        const file = try std.fs.cwd().openFile(path, .{});
        
        var self: Self = .{
            .file = file,
            .buffer = undefined,
            .reader = undefined,
        };

        var file_reader = self.file.reader(&self.buffer);
        self.reader = &file_reader.interface;

        return self;
    }

    pub fn deinit(self: *Self) void {
        self.file.close();
    }

    pub fn nextLine(self: *Self) !?[]const u8 {
        return try self.reader.takeDelimiter('\n');
    }
};
