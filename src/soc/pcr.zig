const soc = @import("esp32c6.zig");

pub const Registers = extern struct {
    reserved0: [64]u32,
    gpio_conf: u32,
    gpio_reset: u32,
};

pub const regs: *Registers = @ptrFromInt(soc.PCR_BASE);
