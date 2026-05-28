package main

import "base:runtime"
import "core:fmt"
import clay "clay-odin"
import rl "vendor:raylib"

WINDOW_WIDTH  :: 1280
WINDOW_HEIGHT :: 720

error_handler :: proc "c" (err: clay.ErrorData) {
    context = runtime.default_context()
    fmt.eprintln("Clay error:", err.errorText.chars)
}

main :: proc() {
    rl.InitWindow(WINDOW_WIDTH, WINDOW_HEIGHT, "Graph App")
    defer rl.CloseWindow()
    rl.SetTargetFPS(60)

    min_memory := clay.MinMemorySize()
    memory     := make([]u8, uint(min_memory))
    arena      := clay.CreateArenaWithCapacityAndMemory(uint(min_memory), raw_data(memory))
    clay.Initialize(arena, {WINDOW_WIDTH, WINDOW_HEIGHT}, {handler = error_handler})
    clay.SetMeasureTextFunction(measure_text, nil)

    // Load default font at index 0
    append(&raylib_fonts, Raylib_Font{fontId = 0, font = rl.GetFontDefault()})

    for !rl.WindowShouldClose() {
        clay.SetLayoutDimensions({f32(rl.GetScreenWidth()), f32(rl.GetScreenHeight())})
        clay.SetPointerState(
            transmute(clay.Vector2)rl.GetMousePosition(),
            rl.IsMouseButtonDown(.LEFT),
        )
        clay.UpdateScrollContainers(true, transmute(clay.Vector2)rl.GetMouseWheelMoveV(), rl.GetFrameTime())





clay.BeginLayout()

if clay.UI(clay.ID("Root"))({
    layout = {
        sizing          = {clay.SizingGrow({}), clay.SizingGrow({})},
        layoutDirection = .TopToBottom,
        childGap        = 0,
    },
    backgroundColor = {15, 15, 20, 255},
}) {
    // Top bar
    if clay.UI(clay.ID("TopBar"))({
        layout = {
            sizing       = {clay.SizingGrow({}), clay.SizingFixed(48)},
            layoutDirection = .LeftToRight,
            padding      = clay.PaddingAll(8),
            childGap     = 8,
        },
        backgroundColor = {30, 30, 45, 255},
    }) {
        if clay.UI(clay.ID("TopBtn1"))({
            layout = {
                sizing  = {clay.SizingFixed(120), clay.SizingGrow({})},
                padding = clay.PaddingAll(8),
            },
            backgroundColor = clay.PointerOver(clay.ID("TopBtn1")) ? {80, 80, 140, 255} : {60, 60, 110, 255},
            cornerRadius = clay.CornerRadiusAll(6),
        }) {
            clay.Text("Load Data", {fontId = 0, fontSize = 16, textColor = {220, 220, 255, 255}})
        }

        if clay.UI(clay.ID("TopBtn2"))({
            layout = {
                sizing  = {clay.SizingFixed(120), clay.SizingGrow({})},
                padding = clay.PaddingAll(8),
            },
            backgroundColor = clay.PointerOver(clay.ID("TopBtn2")) ? {80, 80, 140, 255} : {60, 60, 110, 255},
            cornerRadius = clay.CornerRadiusAll(6),
        }) {
            clay.Text("Export", {fontId = 0, fontSize = 16, textColor = {220, 220, 255, 255}})
        }
    }

    // Graph area — grows to fill all remaining space
    if clay.UI(clay.ID("GraphArea"))({
        layout = {
            sizing = {clay.SizingGrow({}), clay.SizingGrow({})},
        },
        backgroundColor = {20, 20, 28, 255},
    }) {}

    // Bottom bar
    if clay.UI(clay.ID("BottomBar"))({
        layout = {
            sizing          = {clay.SizingGrow({}), clay.SizingFixed(48)},
            layoutDirection = .LeftToRight,
            padding         = clay.PaddingAll(8),
            childGap        = 8,
        },
        backgroundColor = {30, 30, 45, 255},
    }) {
        if clay.UI(clay.ID("BotBtn1"))({
            layout = {
                sizing  = {clay.SizingFixed(120), clay.SizingGrow({})},
                padding = clay.PaddingAll(8),
            },
            backgroundColor = clay.PointerOver(clay.ID("BotBtn1")) ? {80, 140, 80, 255} : {60, 110, 60, 255},
            cornerRadius = clay.CornerRadiusAll(6),
        }) {
            clay.Text("Settings", {fontId = 0, fontSize = 16, textColor = {220, 255, 220, 255}})
        }

        if clay.UI(clay.ID("BotBtn2"))({
            layout = {
                sizing  = {clay.SizingFixed(120), clay.SizingGrow({})},
                padding = clay.PaddingAll(8),
            },
            backgroundColor = clay.PointerOver(clay.ID("BotBtn2")) ? {80, 140, 80, 255} : {60, 110, 60, 255},
            cornerRadius = clay.CornerRadiusAll(6),
        }) {
            clay.Text("Reset View", {fontId = 0, fontSize = 16, textColor = {220, 255, 220, 255}})
        }
    }
}

render_commands := clay.EndLayout(rl.GetFrameTime())

// --- click handling (after EndLayout, before BeginDrawing) ---
if rl.IsMouseButtonPressed(.LEFT) {
    if clay.PointerOver(clay.ID("TopBtn1")) { fmt.println("Load Data clicked") }
    if clay.PointerOver(clay.ID("TopBtn2")) { fmt.println("Export clicked") }
    if clay.PointerOver(clay.ID("BotBtn1")) { fmt.println("Settings clicked") }
    if clay.PointerOver(clay.ID("BotBtn2")) { fmt.println("Reset View clicked") }
}






        rl.BeginDrawing()
        rl.ClearBackground({15, 15, 20, 255})
        clay_raylib_render(&render_commands)
        rl.EndDrawing()
    }
}
