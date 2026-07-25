pub inline fn mask(comptime T: type, value: anytype) T {
    return @as(T, 1) << @intCast(value);
}
