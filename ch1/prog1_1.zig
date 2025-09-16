const std = @import("std");
const printd = std.debug.print;
const mem = std.mem;
const strToInt = std.fmt.parseInt;

const N = 10000;

pub fn main() !void {
    var id = [_]usize{0} ** N;
    var p: usize = 0;
    var q: usize = 0;
    var t: usize = 0;

    for (id, 0..) |_, i| {
        id[i] = i;
    }

    var buffer: [8]u8 = undefined;
    var reader = std.fs.File.stdin().reader(&buffer);
    var in = &reader.interface;

    // input: <nb> <nb>
    while (in.peekDelimiterExclusive('\n')) |buf| {
        defer in.tossBuffered();

        if (buf.len <= 2) continue;

        p = strToInt(usize, buf[0..1], 10) catch {
            printd("Not a digit!\n", .{});
            printd("usage: <number> <number>\n", .{});
            continue;
        };

        q = strToInt(usize, buf[2..], 10) catch {
            printd("Not a digit!\n", .{});
            printd("usage: <number> <number>\n", .{});
            continue;
        };

        if (id[p] == id[q]) continue;

        t = id[p];

        var i: u32 = 0;
        while (i < N) : (i += 1) {
            if (id[i] == t) id[i] = id[q];
        }

        printd(" {d} {d}\n", .{ p, q });
    } else |err| {
        printd("{}", .{err});
    }
}
