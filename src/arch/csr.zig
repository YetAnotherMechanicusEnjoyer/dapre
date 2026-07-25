pub inline fn wfi() void {
    asm volatile ("wfi");
}

pub inline fn nop() void {
    asm volatile ("nop");
}

pub inline fn fence() void {
    asm volatile ("fence");
}

pub inline fn readMstatus() usize {
    return asm volatile (
        \\csrr %[value], mstatus
        : [value] "=r" (-> usize),
    );
}

pub inline fn writeMstatus(value: usize) void {
    asm volatile (
        \\csrw mstatus, %[value]
        :
        : [value] "r" (value),
    );
}

pub inline fn readMcycle() u64 {
    var low: u32 = undefined;
    var high: u32 = undefined;

    asm volatile (
        \\csrr %[l], mcycle
        \\csrr %[h], mcycleh
        : [l] "=r" (low),
          [h] "=r" (high),
    );

    return (@as(u64, high) << 32) | low;
}
