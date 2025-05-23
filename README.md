# Popcorn Panic!

**Popcorn Panic** is a retro-style 8-bit platformer featuring Mr +, a quirky blue mascotte on a mission to recover his stolen popcorn kernels from TV-world invaders.

---

## 🎮 Gameplay

- Classic platformer mechanics: run, jump, collect
- Power-ups: throwable popcorn that explodes
- Themed levels: TV channels like Sofa World, Space Pop, and more
- Final boss: the Giant CRT Mutant TV
- Levels progress automatically when you reach the end of a stage

---

## 🔧 Project Info

- Engine: [Godot 4.2](https://godotengine.org/download)
- Language: GDScript
- Target platforms: **Android & iOS** (also exports to Windows, Web)

---

## 🧠 How to Run

1. Download or clone this repo
2. Open the folder in **Godot 4.2**
3. In the Godot editor, run the `Main.tscn` scene to start the game

This repository includes `Main.tscn` as a demo level. Additional stages can be
added as separate `.tscn` files. Open any scene from the **FileSystem** dock to
edit or test it directly.

---

## 🛠️ Folder Structure

The repository contains only a few essential directories:

- `scripts/` – GDScript code for gameplay, UI, and enemy logic
- `assets/`  – game assets such as sound files in `assets/audio/`

---

## ✅ Running Tests

Unit tests are included in the `tests/` directory. To run them you need
to have **Godot 4.2** installed. From the project root, execute:

```bash
godot --headless -s tests/test_suite.gd
```

This launches Godot in headless mode and runs all test cases defined in
`tests/test_suite.gd`.

