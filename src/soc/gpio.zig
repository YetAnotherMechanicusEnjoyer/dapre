const soc = @import("esp32c6.zig");

pub const Registers = extern struct {
    // GPIO_BT_SELECT_REG
    // Offset : 0x0000
    bt_select: u32,

    // GPIO_OUT_REG
    // Offset : 0x0004
    out: u32,

    // GPIO_OUT_W1TS_REG
    // Offset : 0x0008
    out_w1ts: u32,

    // GPIO_OUT_W1TC_REG
    // Offset : 0x000C
    out_w1tc: u32,

    // GPIO_ENABLE_REG
    // Offset : 0x0010
    enable: u32,

    // GPIO_ENABLE_W1TS_REG
    // Offset : 0x0014
    enable_w1ts: u32,

    // GPIO_ENABLE_W1TC_REG
    // Offset : 0x0018
    enable_w1tc: u32,

    reserved0: [13]u32,

    // GPIO_STATUS_REG
    status: u32,
    status_w1ts: u32,
    status_w1tc: u32,
};

pub const regs: *Registers =
    @ptrFromInt(soc.GPIO_BASE);
