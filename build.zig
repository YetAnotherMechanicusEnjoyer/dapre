const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{ .default_target = .{
        .cpu_arch = .riscv32,
        .os_tag = .freestanding,
    } });
    const optimize = b.option(std.builtin.OptimizeMode, "mode", "") orelse .Debug;

    const exe_mod = b.createModule(.{
        .root_source_file = b.path("src/main.zig"),
        .target = target,
        .optimize = optimize,
    });

    exe_mod.addAssemblyFile(b.path("src/boot/start.S"));

    if (optimize != .Debug) {
        exe_mod.stack_protector = true;
    }

    const exe = b.addExecutable(.{
        .name = "darpe",
        .root_module = exe_mod,
    });

    exe.setLinkerScript(b.path("linker.ld"));

    b.installArtifact(exe);
}
