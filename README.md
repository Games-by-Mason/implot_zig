# Dear ImGui Zig

A *partial* port of implot to the Zig build system. Since no binding generator was used, only the parts I'm using are ported to C.

In the future if more of the library is needed and hand porting becomes cumbersome, `dear_bindings` may offer support, but it does not yet. cimgui already offers support, though we would have run the generator ourselves since the prebaked results they have up are a few years out of date.

## How to change versions
Update `build.zig.zon`, and then if the headers changed in an incompatible way, manually update the C port in `src`.
