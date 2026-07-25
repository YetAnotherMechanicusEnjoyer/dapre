const mmio = @import("../arch/mmio.zig");
const soc = @import("esp32c6.zig");

pub const DriveStrength = enum(u2) {
    /// 5 mA
    level0 = 0,

    /// 10 mA
    level1 = 1,

    /// 20 mA (reset)
    level2 = 2,

    /// 40 mA
    level3 = 3,
};

pub const PadRegister = packed struct(u32) {
    reserved0: u4,

    /// input filter
    filter_en: bool,

    /// select
    fun_sel: bool,

    /// input enable
    fun_ie: bool,

    /// pull down
    fun_wpd: bool,

    /// pull up
    fun_wpu: bool,

    /// drive
    fun_drv: DriveStrength,

    reserved1: u21,
};

pub const Registers = [31]PadRegister;

pub const regs: *Registers =
    @ptrFromInt(soc.IO_MUX_BASE + 0x04);
