pub inline fn read(comptime T: type, ptr: *T) T {
    return @as(*volatile T, @volatileCast(ptr)).*;
}

pub inline fn write(comptime T: type, ptr: *T, value: T) void {
    @as(*volatile T, @volatileCast(ptr)).* = value;
}

pub inline fn read32(ptr: *u32) u32 {
    return read(u32, ptr);
}

pub inline fn write32(ptr: *u32, value: u32) void {
    write(u32, ptr, value);
}

pub inline fn modify32(ptr: *u32, clear_mask: u32, set_mask: u32) void {
    var value = read32(ptr);

    value &= ~clear_mask;
    value |= set_mask;

    write32(ptr, value);
}
