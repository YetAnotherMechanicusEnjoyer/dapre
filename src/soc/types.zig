pub fn RW(comptime T: type) type {
    return @volatileCast(T);
}

pub fn RO(comptime T: type) type {
    return @constCast(@volatileCast(T));
}

pub fn WO(comptime T: type) type {
    return @volatileCast(T);
}
