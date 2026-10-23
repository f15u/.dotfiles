import { spawnSync } from "node:child_process"

// RTK OpenCode plugin — rewrites commands to use rtk for token savings.
// Requires: rtk >= 0.23.0 in PATH.
//
// This is a thin delegating plugin: all rewrite logic lives in `rtk rewrite`,
// which is the single source of truth (src/discover/registry.rs).
// To add or change rewrite rules, edit the Rust registry — not this file.

function hasRtk(): boolean {
  const result = spawnSync("rtk", ["--version"], { stdio: "ignore" })
  return !result.error && result.status === 0
}

// `rtk rewrite` prints the rewritten command to stdout, or nothing when no rule
// applies. It exits non-zero to flag a rewrite, so drive off stdout, not status.
function rewrite(command: string): string {
  const result = spawnSync("rtk", ["rewrite", command], { encoding: "utf8" })
  if (result.error) return command
  const out = String(result.stdout ?? "").trim()
  return out || command
}

export default {
  id: "rtk",
  setup: async (ctx: any) => {
    if (!hasRtk()) {
      console.warn("[rtk] rtk binary not found in PATH — plugin disabled")
      return
    }

    await ctx.tool.hook("execute.before", async (evt: any) => {
      const tool = String(evt?.tool ?? "").toLowerCase()
      if (tool !== "bash" && tool !== "shell") return

      const input = evt?.input
      if (!input || typeof input !== "object") return

      const command = (input as Record<string, unknown>).command
      if (typeof command !== "string" || !command) return

      const rewritten = rewrite(command)
      if (rewritten && rewritten !== command) {
        ;(input as Record<string, unknown>).command = rewritten
      }
    })
  },
}
