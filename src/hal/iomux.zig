const hw = @import("../soc/iomux.zig");
const Pin = @import("pin.zig").Pin;

pub const DriveStrength = hw.DriveStrength;

pub const Config = struct {
    pull_up: bool = false,

    pull_down: bool = false,

    input_enable: bool = false,

    drive_strength: DriveStrength = .level2,
};

fn pad(pin: Pin) *hw.PadRegister {
    return &hw.regs[@intFromEnum(pin)];
}

pub fn configure(
    pin: Pin,
    cfg: Config,
) void {
    var reg = pad(pin);

    reg.fun_wpu = cfg.pull_up;
    reg.fun_wpd = cfg.pull_down;
    reg.fun_ie = cfg.input_enable;
    reg.fun_drv = cfg.drive_strength;

    reg.fun_sel = true;
}
