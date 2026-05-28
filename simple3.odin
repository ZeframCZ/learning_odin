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
            padding      = {left = 12, right = 12, top = 8, bottom = 8},
            childGap     = 8,
            childAlignment = {y = .Center},
        },
        backgroundColor = {30, 30, 45, 255},
        border = {color = {60, 60, 80, 255}, width = {bottom = 1}},
    }) {
        if clay.UI(clay.ID("TopBtn1"))({
            layout = {padding = {left = 14, right = 14, top = 6, bottom = 6}},
            backgroundColor = clay.Hovered() ? {80, 80, 120, 255} : {55, 55, 85, 255},
            cornerRadius = clay.CornerRadiusAll(6),
        }) {
            if clay.Hovered() && rl.IsMouseButtonPressed(.LEFT) {
                fmt.println("Top button 1: Load data")
            }
            clay.Text("Load", {fontId = 0, fontSize = 16, textColor = {220, 220, 255, 255}})
        }

        if clay.UI(clay.ID("TopBtn2"))({
            layout = {padding = {left = 14, right = 14, top = 6, bottom = 6}},
            backgroundColor = clay.Hovered() ? {80, 80, 120, 255} : {55, 55, 85, 255},
            cornerRadius = clay.CornerRadiusAll(6),
        }) {
            if clay.Hovered() && rl.IsMouseButtonPressed(.LEFT) {
                fmt.println("Top button 2: Export graph")
            }
            clay.Text("Export", {fontId = 0, fontSize = 16, textColor = {220, 220, 255, 255}})
        }
    }

    // Middle row: sidebar + graph
    if clay.UI(clay.ID("Middle"))({
        layout = {
            sizing          = {clay.SizingGrow({}), clay.SizingGrow({})},
            layoutDirection = .LeftToRight,
            childGap        = 0,
        },
    }) {
        // Sidebar
        if clay.UI(clay.ID("Sidebar"))({
            layout = {
                sizing          = {clay.SizingFixed(260), clay.SizingGrow({})},
                layoutDirection = .TopToBottom,
                padding         = clay.PaddingAll(16),
                childGap        = 12,
            },
            backgroundColor = {25, 25, 35, 255},
            border = {color = {60, 60, 80, 255}, width = {right = 1}},
        }) {}

        // Graph area
        if clay.UI(clay.ID("GraphArea"))({
            layout = {
                sizing = {clay.SizingGrow({}), clay.SizingGrow({})},
            },
            backgroundColor = {20, 20, 28, 255},
        }) {}
    }

    // Bottom bar
    if clay.UI(clay.ID("BottomBar"))({
        layout = {
            sizing          = {clay.SizingGrow({}), clay.SizingFixed(40)},
            layoutDirection = .LeftToRight,
            padding         = {left = 12, right = 12, top = 6, bottom = 6},
            childGap        = 8,
            childAlignment  = {y = .Center},
        },
        backgroundColor = {30, 30, 45, 255},
        border = {color = {60, 60, 80, 255}, width = {top = 1}},
    }) {
        if clay.UI(clay.ID("BotBtn1"))({
            layout = {padding = {left = 14, right = 14, top = 4, bottom = 4}},
            backgroundColor = clay.Hovered() ? {80, 80, 120, 255} : {55, 55, 85, 255},
            cornerRadius = clay.CornerRadiusAll(6),
        }) {
            if clay.Hovered() && rl.IsMouseButtonPressed(.LEFT) {
                fmt.println("Bottom button 1: Reset view")
            }
            clay.Text("Reset", {fontId = 0, fontSize = 14, textColor = {220, 220, 255, 255}})
        }

        if clay.UI(clay.ID("BotBtn2"))({
            layout = {padding = {left = 14, right = 14, top = 4, bottom = 4}},
            backgroundColor = clay.Hovered() ? {80, 80, 120, 255} : {55, 55, 85, 255},
            cornerRadius = clay.CornerRadiusAll(6),
        }) {
            if clay.Hovered() && rl.IsMouseButtonPressed(.LEFT) {
                fmt.println("Bottom button 2: Settings")
            }
            clay.Text("Settings", {fontId = 0, fontSize = 14, textColor = {220, 220, 255, 255}})
        }
    }
}

render_commands := clay.EndLayout(rl.GetFrameTime())






        rl.BeginDrawing()
        rl.ClearBackground({15, 15, 20, 255})
        clay_raylib_render(&render_commands)
        rl.EndDrawing()
    }
}
