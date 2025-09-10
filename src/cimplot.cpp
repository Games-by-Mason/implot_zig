#include <implot.h>
#include <stddef.h>
#include <stdlib.h>
#include <stdint.h>

// Define structs for interop with Zig
namespace cimplot {
    typedef struct IpVec2_t IpVec2;
    typedef struct IpVec2_t {
        float x, y;
    } IpVec2;

    typedef struct ImPlotPoint_t ImPlotPoint;
    typedef struct ImPlotPoint_t {
        double x, y;
    } ImPlotPoint;
}


// Don't require libc++ just for new and delete...
void *new_impl(size_t count) {
    // New can't return nullptr, but malloc(0) can
    if (count == 0) ++count;

    // Allocate with C
    if (auto result = malloc(count)) return result;

    // Abort on failure
    abort();
}

void delete_impl(void *ptr) {
    free(ptr);
}

void* operator new(size_t count) {
    return new_impl(count);
}

void* operator new[](size_t count) {
    return new_impl(count);
}

void operator delete(void *ptr) noexcept {
    delete_impl(ptr);
}

void operator delete[](void *ptr) noexcept {
    delete_impl(ptr);
}

static inline cimplot::IpVec2 ConvertFromCPP_ImVec2(const ::ImVec2& src)
{
    cimplot::IpVec2 dest;
    dest.x = src.x;
    dest.y = src.y;
    return dest;
}

static inline ::ImVec2 ConvertToCPP_ImVec2(const cimplot::IpVec2& src)
{
    ::ImVec2 dest;
    dest.x = src.x;
    dest.y = src.y;
    return dest;
}

static inline cimplot::ImPlotPoint ConvertFromCPP_ImPlotPoint(const ::ImPlotPoint& src)
{
    cimplot::ImPlotPoint dest;
    dest.x = src.x;
    dest.y = src.y;
    return dest;
}

static inline ::ImPlotPoint ConvertToCPP_ImPlotPoint(const cimplot::ImPlotPoint& src)
{
    ::ImPlotPoint dest;
    dest.x = src.x;
    dest.y = src.y;
    return dest;
}

// Call into the C++ functions
extern "C" {
    void ImPlot_CreateContext() {
        ImPlot::CreateContext();
    }

    void ImPlot_DestroyContext() {
        ImPlot::DestroyContext();
    }

    void ImPlot_ShowDemoWindow(bool* p_open) {
        ImPlot::ShowDemoWindow(p_open);
    }

    bool ImPlot_BeginPlot(const char* title_id, cimplot::IpVec2 size, ImPlotFlags flags) {
        return ImPlot::BeginPlot(title_id, ConvertToCPP_ImVec2(size), flags);
    }

    void ImPlot_EndPlot() {
        ImPlot::EndPlot();
    }

    void ImPlot_PlotLine(
        const char* label_id,
        const float* values,
        int count,
        double xscale,
        double xstart,
        ImPlotLineFlags flags,
        int offset,
        int stride
    ) {
        ImPlot::PlotLine(
            label_id,
            values,
            count,
            xscale,
            xstart,
            flags,
            offset,
            stride
        );
    }

    void ImPlot_SetupAxis(ImAxis axis, const char *label, ImPlotAxisFlags flags) {
        ImPlot::SetupAxis(axis, label, flags);
    }

    void ImPlot_SetupAxisLimits(
        ImAxis axis,
        double min,
        double max,
        ImPlotCond cond
    ) {
        ImPlot::SetupAxisLimits(axis, min, max, cond);
    }

    void ImPlot_SetupMouseText(ImPlotLocation location, ImPlotMouseTextFlags flags) {
        ImPlot::SetupMouseText(location, flags);
    }

    void ImPlot_SetupAxisFormat(ImAxis axis, const char* fmt) {
        ImPlot::SetupAxisFormat(axis, fmt);
    }

    bool ImPlot_IsPlotHovered() {
        return ImPlot::IsPlotHovered();
    }

    cimplot::ImPlotPoint ImPlot_GetPlotMousePos(ImAxis x_axis, ImAxis y_axis) {
        return ConvertFromCPP_ImPlotPoint(ImPlot::GetPlotMousePos(x_axis, y_axis));
    }

    cimplot::IpVec2 ImPlot_PlotToPixels(double x, double y, ImAxis x_axis /*= IMPLOT_AUTO*/, ImAxis y_axis /*= IMPLOT_AUTO*/) {
        return ConvertFromCPP_ImVec2(ImPlot::PlotToPixels(x, y, x_axis, y_axis));
    }

    cimplot::IpVec2 ImPlot_GetPlotPos() {
        return ConvertFromCPP_ImVec2(ImPlot::GetPlotPos());
    }

    cimplot::IpVec2 ImPlot_GetPlotSize() {
        return ConvertFromCPP_ImVec2(ImPlot::GetPlotSize());
    }

    void ImPlot_PushPlotClipRect(float expand) {
        ImPlot::PushPlotClipRect(expand);
    }

    void ImPlot_PopPlotClipRect() {
        ImPlot::PopPlotClipRect();
    }

    void* ImPlot_GetPlotDrawList() {
        return ImPlot::GetPlotDrawList();
    }

    void ImPlot_PlotText(const char* text, double x, double y, cimplot::IpVec2 pix_offset, ImPlotTextFlags flags) {
        return ImPlot::PlotText(text, x, y, ConvertToCPP_ImVec2(pix_offset), flags);
    }

    void ImPlot_PushStyleColor(ImPlotCol idx, uint32_t color) {
        ImPlot::PushStyleColor(idx, color);
    }

    void ImPlot_PopStyleColor(int count) {
        ImPlot::PopStyleColor(count);
    }
}
