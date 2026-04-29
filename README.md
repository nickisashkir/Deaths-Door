# Death's Door

A lightweight overlay datapack for Vanilla Tweaks Graves that lets any player click their grave's location in chat to teleport back, with a brief invulnerability window on arrival. No op required, no permission plugin needed.

## Requirements

- Minecraft 26.1 (pack format 101)
- Vanilla Tweaks Graves v4.1.0 or compatible (https://vanillatweaks.net)

Both packs must be loaded together. This overlay does nothing on its own.

## Installation

1. Place the `Death's Door` zip in your world's `datapacks/` folder alongside the Vanilla Tweaks Graves zip.
2. Run `/reload` in-game, or restart the server.
3. Verify both packs loaded with `/datapack list`.

No config files, no permissions setup.

## What it does

When a player dies, the Vanilla Tweaks `/trigger graves` list shows their grave locations. By default those chat entries suggest a `/tp` command which only ops can actually run. This overlay rewrites the click action to use a player-runnable trigger instead, so any player can click their own grave entry in chat to teleport back.

On arrival the player gets:

- 10 seconds of Resistance V (full damage immunity, except the void)
- 10 seconds of Fire Resistance
- A chat confirmation showing the coordinates they landed at

The pack only ever teleports a player to their own graves. Ownership is verified at click time via UUID match, so a player who manually runs `/trigger graves.tp set <id>` with someone else's grave id receives "That isn't your grave." and is not teleported.

## How it works

The pack is a thin overlay that does not modify the Vanilla Tweaks pack itself. It does two things:

1. Overrides `data/graves/function/creation/update_grave_listing.mcfunction` to inject a unique `grave_id` into each newly created grave and swap the chat click action from `suggest_command /tp ...` to `run_command /trigger graves.tp set <grave_id>`.
2. Adds a `graves_back` namespace containing a tick scheduler that processes pending teleport triggers, looks up the requested grave in a flat index keyed by `grave_id`, verifies ownership via entity NBT match, and performs the dimension-aware teleport.

Because the override and namespace stay self-contained, removing this pack restores stock Vanilla Tweaks behavior with no residual state.

## Configuration

To change the grace effects, edit `data/graves_back/function/do_tp.mcfunction`:

```
effect give @s minecraft:resistance 10 4 false
effect give @s minecraft:fire_resistance 10 0 false
```

The format is `effect give <target> <effect> <seconds> <amplifier> <hideParticles>`.

- Amplifier `4` is Resistance V (100% reduction). Drop to `2` for Resistance III (60%), `0` for Resistance I (20%).
- Set `false` to `true` to hide the swirl particles.
- Adjust the `10` to change the duration in seconds.

To change the chat confirmation message, edit the `tellraw` line in the same file.

## Caveats

**Pre-install graves.** Graves created before this pack was installed do not have a `grave_id` baked into their click action, and are not present in the flat index. Their chat links will return "That grave no longer exists." Players need to die once after install for new graves to be teleportable.

**Void deaths.** Resistance V does not protect against void damage. A grave at Y=-100 in the void will still kill a returning player.

**No cooldown.** A player can repeatedly click the same grave entry while the grave is still alive. Cooldowns and one-shot-per-death modes are easy additions to the tick handler if you want them.

## File structure

```
pack.mcmeta
data/
  minecraft/tags/function/load.json
  graves/function/creation/
    update_grave_listing.mcfunction       (overrides Vanilla Tweaks)
  graves_back/function/
    load.mcfunction
    schedule_2t.mcfunction
    teleport_self.mcfunction
    do_lookup.mcfunction
    check_owner.mcfunction
    do_tp.mcfunction
    build_listing.mcfunction
```

## Compatibility

Built against Vanilla Tweaks Graves v4.1.0 (MC 26.1). If Vanilla Tweaks changes the structure of `update_grave_listing.mcfunction` or the macro args it consumes, the override may need to be re-synced. The internal `graves_back` namespace is independent of Vanilla Tweaks internals and should remain stable across minor updates.

## License

This pack overrides one file from Vanilla Tweaks Graves and is intended to be used alongside it. Refer to Vanilla Tweaks's terms of use before redistributing.
