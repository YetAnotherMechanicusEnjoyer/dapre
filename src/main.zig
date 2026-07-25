const gpio = @import("hal/gpio.zig");

export fn main() void {
    gpio.initOutput(.gpio8, .{});

    while (true) {
        gpio.high(.gpio8);

        for (0..5_000_000) |_| {
            asm volatile ("nop");
        }

        gpio.low(.gpio8);

        for (0..5_000_000) |_| {
            asm volatile ("nop");
        }
    }
}
