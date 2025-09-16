const std = @import("std");
const printd = std.debug.print;
const mem = std.mem;
const strToInt = std.fmt.parseInt;

const N = 10000;

pub fn main() !void {
    var id = [_]usize{0} ** N;
    var sz = [_]usize{0} ** N;
    var p: usize = 0;
    var q: usize = 0;

    for (id, 0..) |_, i| {
        id[i] = i;
        sz[i] = 1;
    }

    var buffer: [8]u8 = undefined;
    var reader: std.fs.File.Reader = std.fs.File.stdin().reader(&buffer);
    var in = &reader.interface;

    // input: <nb> <nb>
    var i: usize = 0;
    var j: usize = 0;
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

        i = p;
        while (i != id[i]) : (i = id[i]) {
            id[i] = id[id[i]];
        }
        j = q;
        while (j != id[j]) : (j = id[j]) {
            id[j] = id[id[j]];
        }

        if (i == j) continue;

        if (sz[i] < sz[j]) {
            id[i] = j;
            sz[j] += sz[i];
        } else {
            id[j] = i;
            sz[i] += sz[j];
        }

        printd(" {d} {d}\n", .{ p, q });
    } else |err| {
        printd("{}", .{err});
    }
}
