const mmio = @import("../arch/mmio.zig");
const hw = @import("../soc/gpio.zig");
const iomux = @import("iomux.zig");
const Pin = @import("pin.zig").Pin;

pub const DriveStrength = iomux.DriveStrength;

pub const OutputConfig = struct {
    pull_up: bool = false,
    pull_down: bool = false,
    input_enable: bool = false,
    drive_strength: DriveStrength = .level2,
};

fn mask(pin: Pin) u32 {
    return @as(u32, 1) << @intFromEnum(pin);
}

pub fn enableOutput(pin: Pin) void {
    mmio.write32(
        &hw.regs.enable_w1ts,
        mask(pin),
    );
}

pub fn disableOutput(pin: Pin) void {
    mmio.write32(
        &hw.regs.enable_w1tc,
        mask(pin),
    );
}

pub fn high(pin: Pin) void {
    mmio.write32(
        &hw.regs.out_w1ts,
        mask(pin),
    );
}

pub fn low(pin: Pin) void {
    mmio.write32(
        &hw.regs.out_w1tc,
        mask(pin),
    );
}

pub fn toggle(pin: Pin) void {
    if ((readOutputs() & mask(pin)) != 0)
        low(pin)
    else
        high(pin);
}

pub fn readOutputs() u32 {
    return mmio.read32(&hw.regs.out);
}

pub fn initOutput(
    pin: Pin,
    config: OutputConfig,
) void {
    iomux.configure(pin, .{
        .pull_up = config.pull_up,
        .pull_down = config.pull_down,
        .input_enable = config.input_enable,
        .drive_strength = config.drive_strength,
    });

    enableOutput(pin);
}
