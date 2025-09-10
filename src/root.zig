const std = @import("std");
const imgui = @import("dear_imgui");

const Vec2 = imgui.Vec2;
const DrawList = imgui.DrawList;

pub const Color = packed struct(u32) {
    r: u8,
    g: u8,
    b: u8,
    a: u8,
};

pub const Point = extern struct {
    x: f64,
    y: f64,
};

pub const Flags = packed struct(c_uint) {
    no_title: bool = false,
    no_legend: bool = false,
    no_mouse_text: bool = false,
    no_inputs: bool = false,
    no_menus: bool = false,
    no_box_select: bool = false,
    no_child: bool = false,
    no_frame: bool = false,
    equal: bool = false,
    crosshairs: bool = false,
    _padding0: u22 = 0,
};

const Axis = enum(c_uint) {
    x1 = 0,
    x2 = 1,
    x3 = 2,
    y1 = 3,
    y2 = 4,
    y3 = 5,
    auto = std.math.maxInt(c_uint),
};

pub const AxisFlags = packed struct(c_uint) {
    no_label: bool = false,
    no_grid_lines: bool = false,
    no_tick_marks: bool = false,
    no_tick_labels: bool = false,
    no_initial_fit: bool = false,
    no_menus: bool = false,
    no_side_switch: bool = false,
    no_highlight: bool = false,
    opposite: bool = false,
    foreground: bool = false,
    invert: bool = false,
    auto_fit: bool = false,
    range_fit: bool = false,
    pan_stretch: bool = false,
    lock_min: bool = false,
    lock_max: bool = false,
    _padding0: u16 = 0,
};

pub const MouseTextFlags = packed struct(c_uint) {
    no_aux_axes: bool = false,
    no_format: bool = false,
    show_always: bool = false,
};

pub const Location = packed struct(c_uint) {
    north: bool = false,
    south: bool = false,
    west: bool = false,
    east: bool = false,
};

pub const Cond = enum(c_uint) {
    always = @intFromEnum(imgui.Cond.always),
    once = @intFromEnum(imgui.Cond.once),
};

pub const LineFlags = packed struct(c_uint) {
    _padding0: u10 = 0,
    segments: bool = false,
    loop: bool = false,
    skip_nan: bool = false,
    no_clip: bool = false,
    shaded: bool = false,
    _padding1: u17 = 0,
};

pub const TextFlags = packed struct(c_uint) {
    _padding0: u10 = 0,
    vertical: bool = false,
};

pub const PlotColor = enum(c_int) {
    line,
    fill,
    marker_outline,
    marker_fill,
    error_bar,
    frame_bg,
    plot_bg,
    plot_border,
    legend_bg,
    legend_border,
    legend_text,
    title_text,
    inlay_text,
    axis_text,
    axis_grid,
    axis_tick,
    axis_bg,
    axis_bg_hovered,
    axis_bg_active,
    selection,
    crosshairs,
};

extern fn ImPlot_CreateContext() void;
extern fn ImPlot_DestroyContext() void;
extern fn ImPlot_ShowDemoWindow(p_open: ?*bool) void;
extern fn ImPlot_BeginPlot(title_id: [*:0]const u8, size: Vec2, flags: Flags) bool;
extern fn ImPlot_EndPlot() void;
extern fn ImPlot_PlotLine(label_id: [*:0]const u8, values: [*]const f32, count: c_int, xscale: f64, xstart: f64, flags: LineFlags, offset: c_int, stride: c_int) void;
extern fn ImPlot_SetupAxis(axis: Axis, label: ?[*:0]const u8, flags: AxisFlags) void;
extern fn ImPlot_SetupAxisLimits(axis: Axis, min: f64, max: f64, cond: Cond) void;
extern fn ImPlot_SetupMouseText(location: Location, flags: MouseTextFlags) void;
extern fn ImPlot_SetupAxisFormat(axis: Axis, fmt: [*:0]const u8) void;
extern fn ImPlot_IsPlotHovered() bool;
extern fn ImPlot_GetPlotMousePos(x_axis: Axis, y_axis: Axis) Point;
extern fn ImPlot_PlotToPixels(x: f64, y: f64, x_axis: Axis, y_axis: Axis) Vec2;
extern fn ImPlot_GetPlotPos() Vec2;
extern fn ImPlot_GetPlotSize() Vec2;
extern fn ImPlot_PushPlotClipRect(expand: f32) void;
extern fn ImPlot_PopPlotClipRect() void;
extern fn ImPlot_GetPlotDrawList() ?*DrawList;
extern fn ImPlot_PlotText(text: [*:0]const u8, x: f64, y: f64, pix_offset: Vec2, flags: TextFlags) void;
extern fn ImPlot_PushStyleColor(idx: PlotColor, color: Color) void;
extern fn ImPlot_PopStyleColor(count: c_int) void;

pub const createContext = ImPlot_CreateContext;
pub const destroyContext = ImPlot_DestroyContext;
pub const showDemoWindow = ImPlot_ShowDemoWindow;
pub const beginPlot = ImPlot_BeginPlot;
pub const endPlot = ImPlot_EndPlot;
pub const plotLine = ImPlot_PlotLine;
pub const setupAxis = ImPlot_SetupAxis;
pub const setupAxisLimits = ImPlot_SetupAxisLimits;
pub const setupMouseText = ImPlot_SetupMouseText;
pub const setupAxisFormat = ImPlot_SetupAxisFormat;
pub const isPlotHovered = ImPlot_IsPlotHovered;
pub const getPlotMousePos = ImPlot_GetPlotMousePos;
pub const plotToPixels = ImPlot_PlotToPixels;
pub const getPlotPos = ImPlot_GetPlotPos;
pub const getPlotSize = ImPlot_GetPlotSize;
pub const pushPlotClipRect = ImPlot_PushPlotClipRect;
pub const popPlotClipRect = ImPlot_PopPlotClipRect;
pub const getPlotDrawList = ImPlot_GetPlotDrawList;
pub const plotText = ImPlot_PlotText;
pub const pushStyleColor = ImPlot_PushStyleColor;
pub const popStyleColor = ImPlot_PopStyleColor;
