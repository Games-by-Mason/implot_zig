const std = @import("std");

const flags: []const []const u8 = &.{
    "-fno-exceptions",
    "-fno-rtti",
    "-fno-threadsafe-statics",
};

pub fn build(b: *std.Build) void {
    // Compilation options
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});
    const optimize_external = switch (optimize) {
        .Debug => .ReleaseSafe,
        else => optimize,
    };

    // Get the upstream code
    const upstream = b.dependency("implot", .{});
    const dear_imgui = b.dependency("dear_imgui", .{
        .target = target,
        .optimize = optimize,
    });

    // Create the library
    const lib = b.addLibrary(.{
        .name = "implot",
        .root_module = b.createModule(.{
            .target = target,
            .optimize = optimize_external,
        }),
    });

    // Add the headers and dependencies
    lib.addIncludePath(upstream.path(""));
    lib.installHeadersDirectory(upstream.path("."), "", .{});
    lib.linkLibrary(dear_imgui.artifact("dear_imgui"));
    lib.linkLibC();

    // Add the main source
    lib.addCSourceFiles(.{
        .root = upstream.path(""),
        .files = &.{
            "implot.cpp",
            "implot_items.cpp",
            "implot_demo.cpp",
        },
        .flags = flags,
    });

    // Add the C bindings to the main library
    lib.addCSourceFiles(.{
        .root = b.path("src"),
        .files = &.{"cimplot.cpp"},
        .flags = flags,
    });
    lib.installHeadersDirectory(b.path("src"), "", .{});

    // Install the library
    b.installArtifact(lib);

    // Expose the library as a Zig module
    const module = b.addModule("implot", .{
        .root_source_file = b.path("src/root.zig"),
        .target = target,
        .optimize = optimize,
    });
    module.addImport("dear_imgui", dear_imgui.module("dear_imgui"));
    module.linkLibrary(lib);
}
