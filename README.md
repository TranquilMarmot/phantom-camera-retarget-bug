## Phantom Camera Retarget Bug 🎥🧑‍🧒🐛

This is a minimum reproduction project for https://github.com/ramokz/phantom-camera/issues/408

## Repro steps

- Use arrow keys to walk around and see camera following "player"
- Press Enter to enter the "car" and use the arrow keys to move it around
- Press Enter again to exit the "car" 🚙
- The player phantom camera no longer follows the player 😢

## Explanation

Relevant code is in [`_unhandled_input` inside of `node_a.gd`](./node_a.gd)

This is likely because the "visuals" of the player are moved into the car via a call to [`reparent`](https://docs.godotengine.org/en/stable/classes/class_node.html#class-node-method-reparent).

## Workaround

As a workaround, re-setting the `follow_target` will resume following:

```gdscript
phantom_camera.follow_target = null
phantom_camera.follow_target = target
```
