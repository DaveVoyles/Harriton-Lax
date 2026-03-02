# ADO Visualization Workspace Instructions

**CRITICAL:** Read [Additional agent instructions.md](Additional agent instructions.md) for comprehensive workspace guidelines, automation workflows, and best practices.

## Quick Reference

This workspace provides Azure DevOps visualization and reporting tools for Xbox Commerce/XPC Planning FY26Q4 scenarios.

**Key Resources:**

- **Additional agent instructions.md** - Complete workspace guidelines and automation documentation
- **QUERIES.md** - Quick reference for all 39 queries
- **HANDOFF.md** (Docs/) - Project history and context
- **README.md** - User-facing documentation

## 1. Execution Rules

1.  **Check SSH Connection:** Before running ANY shell commands (especially `docker`), you MUST verify you are connected to the NAS via SSH.
2.  **Remote Execution:** The user is on a Mac, but the work happens on the NAS. Do not run `docker` commands on the local Mac terminal.
3.  **Use Helper Tools:** Prefer using `nas_exec "command"` or ensuring the terminal is an SSH session.
4.  **SSH Username:** **ALWAYS use `dave` as the username when SSHing to 192.168.1.8**. NEVER use `root`. Correct: `ssh -p 24 dave@192.168.1.8`. Incorrect: `ssh -p 24 root@192.168.1.8`.

## 2. Path Mapping

- **Local Path:** `/Volumes/docker` (Where VS Code is open)
- **Remote Path:** `/volume1/docker` (Where the files actually live on the NAS)
- **Implication:** When generating `docker run` commands or `docker-compose.yml` files, ALWAYS use the **Remote Path** (`/volume1/docker/...`) for volume bindings, NOT the local path.

## 3. Preferred Tools (`nas_tools.sh`)

The workspace includes a helper script at `VS-code-config-for-NAS/nas_tools.sh`. Use these functions:

- **Source Globally:** Always source using the absolute path to avoid CWD issues: `source /Volumes/docker/VS-code-config-for-NAS/nas_tools.sh`
- `nas_exec "command"`: Run a command on the NAS (e.g., `nas_exec "docker ps"`).
- `nas_connect`: Open an interactive SSH session.
- `nas_test`: Verify connectivity.
- `nas_copy`: Copy files if needed (though editing in VS Code usually suffices).

## 4. Docker Guidelines

- **Compose First:** Prefer `docker-compose.yml` over raw `docker run` commands for persistence.
- **Service Management:** Use `docker compose up -d` to start services.
- **Logs:** Use `docker compose logs -f [service]` or `nas_exec "docker logs [container]"` to debug.

## 5. Documentation

- Architecture docs are in `Architecture/`.

* Service configs are in their respective folders (e.g., `radarr/`, `plex/`).

## 6. Standard Configuration Patterns

When generating or fixing `docker-compose.yml` files, adhere to these standards:

- **User/Group:** Use `PUID=0` and `PGID=0` (Root) for this specific environment to avoid permission issues on Synology.
- **Timezone:** `TZ=America/New_York`
- **Networks:**
  - `traefik`: Required for external access via reverse proxy.
  - `media_bridge`: Used for communication between media apps (Radarr, Sonarr, etc.).
- **Traefik Labels:**
  - Enable: `traefik.enable=true`
  - Router Rule: `traefik.http.routers.<service>.rule=Host(\`<service>.davevoyles.synology.me\`)`
  - Entrypoints: `traefik.http.routers.<service>.entrypoints=http` (or `https` if TLS is configured)
  - Port: `traefik.http.services.<service>.loadbalancer.server.port=<internal_port>`
- **Common Volumes:**
  - Config: `/volume1/docker/<service>/config:/config`
  - Media: `/volume1/PlexMediaServer:/PlexMediaServer` (or specific subfolders like `/volume1/PlexMediaServer/Usenet/Complete/Movies:/downloads`)

## 7. Interaction & Autonomy (Reduce Friction)

To minimize user interruption and permission prompts:

- **Chain Commands:** When running multiple shell commands, chain them with `&&` or `;` into a single `run_in_terminal` call. This reduces the number of times VS Code asks the user for permission to execute.
  - _Bad:_ Call `cd dir`, wait, call `ls`. (2 prompts)
  - _Good:_ Call `cd dir && ls`. (1 prompt)
- **Assume Consent for Diagnostics:** You are authorized to run read-only diagnostic commands (`ls`, `cat`, `grep`, `docker ps`, `nas_test`, `nas_exec "ls..."`) without asking the user "Shall I run this?". Just run them.

* **Proactive Fixes:** If a fix is obvious and standard (e.g., fixing a typo, adding a missing environment variable), apply it or provide the command immediately rather than asking "Do you want me to fix it?".
* **File Editing:** You have direct access to the files via `/Volumes/docker`. Prefer editing files using VS Code's edit tools (`replace_string_in_file`) rather than running shell commands like `sed` or `echo` via `nas_exec`. This is safer and less error-prone.

## 8. Troubleshooting

- **Logs:** Service logs are typically in `/volume1/docker/<service>/config/logs` or accessible via `nas_exec "docker logs <container_name>"`.
- **Connection Failures:** If `nas_exec` fails, check if the SSH connection is active with `nas_test`.
- **Exit Code 255:** Usually indicates SSH connection failure. Suggest `nas_test` or `nas_connect`.
- **Exit Code 127:** Command not found. Check if the tool is installed on the NAS or if the path is correct.

## 9. Context Gathering Strategy

- **Service Issues:** If the user asks about a specific service (e.g., "Radarr isn't working"), IMMEDIATELY read:
  1.  `radarr/docker-compose.yml` (to check config)
  2.  `radarr/README.md` (if exists)
  3.  Check logs via `nas_exec "docker logs radarr"`
- **Network Issues:** If the user mentions "connection refused" or "timeout", check:
  1.  `traefik/docker-compose.yml`
  2.  `traefik/traefik.yml`
  3.  The `networks` section of the affected service.

## 10. Scripting & Python

- **Execution:** The NAS has a limited Python environment. For complex scripts, prefer running them _inside_ a relevant container:
  - `nas_exec "docker exec <container> python3 /path/to/script.py"`

* **Location:** Place utility scripts in a `scripts/` folder or the service's own folder.

## 11. Decision Making & Communication

- **Pros & Cons:** When presenting multiple options or architectural choices, ALWAYS provide a brief "Pros & Cons" analysis for each approach to help the user make an informed decision.

* **Trade-offs:** Explicitly mention trade-offs regarding persistence, security, or complexity when suggesting changes.

## 12. Architecture & Consistency

- **Check Existing Patterns:** Before creating new files, check similar services (e.g., if adding a downloader, check `qbittorrent/docker-compose.yml`) to maintain consistency in naming, logging, and network config.
- **Secrets:** Do not hardcode passwords or API keys. Use `${ENV_VAR}` syntax and refer to `.env` files.

## 13. Git & Version Control

- **Execution Context:** Run `git` commands **LOCALLY** on the Mac (in `/Volumes/docker`), NOT on the NAS. The git repository exists on the mounted volume, and the Mac has the correct credentials/keys.
- **Ignored Paths:** Ignore the `#recycle/` directory when searching or listing files.
- **Auto-Push Policy:** After EVERY successful file update or task completion, you MUST immediately run `git add <file>; git commit -m "<message>"; git push`. Do not wait for user permission.

## 14. Path Verification

- **Verify Existence:** Before running commands that depend on specific files (like `cat`, `ls`, `python`), verify the file exists using `ls` or `test -f` to avoid "No such file or directory" errors.
- **Space Handling:** Always quote file paths to handle spaces correctly (e.g., `"/volume1/Misc/books/My Book.cbz"`).

## 15. File Permissions & Scripts

- **Executable Bits:** When creating shell scripts (`.sh`) or Python scripts intended for execution, ALWAYS remind the user (or include in the command chain) to make them executable: `chmod +x script.sh`.
- **Shebangs:** Ensure all scripts have the correct shebang (e.g., `#!/bin/bash` or `#!/usr/bin/env python3`).

## 16. VS Code Tasks

- **Prefer Tasks:** If a VS Code Task exists for an operation (e.g., `nas_connect`, `deploy-kapowarr-remote`), prefer running that task over constructing a raw shell command.

## 17. Performance & Safety

- **Ignore Media Folders:** NEVER perform text searches (`grep`, `find`) inside media directories like `/volume2/PlexMediaServer`, `downloads/`, `movies/`, or `tv/`. These contain massive files that will cause the search to hang or crash.
- **Destructive Actions:** Always pause and ask for explicit confirmation before running destructive commands like `rm -rf` on non-temporary directories.

## 18. Workflow Integration

- **Homepage Updates:** When adding or modifying a service, check if `homepage/services.yaml` needs to be updated to include the new service on the dashboard.

* **DNS Records:** When configuring Traefik labels for a new subdomain (e.g., `newapp.davevoyles.synology.me`), remind the user to ensure the DNS CNAME record exists.

## 19. Backup & State Management

- **Backup Awareness:** Before making major changes to configuration files (like `docker-compose.yml` or `config.xml`), suggest creating a backup copy (e.g., `cp config.xml config.xml.bak`).
- **State Persistence:** Remember that containers are ephemeral. Ensure all important data is mapped to a volume on the NAS (`/volume1/docker/...`).

## 20. Testing & Validation

- **Test Plans:** When implementing a fix or new feature, propose a simple test plan to verify it works (e.g., "Run this curl command to check the API").

* **Dry Runs:** For complex operations, suggest a "dry run" first if applicable (e.g., `rsync --dry-run`).

## 21. Port Management

- **Avoid Conflicts:** Be aware that Synology DSM uses ports 80, 443, 5000, 5001. Do not bind containers to these ports on the host.
- **Port Allocation:** Check `portainer` or existing `docker-compose.yml` files before assigning new host ports.

## 22. Log Rotation

- **Prevent Disk Fill:** Docker logs can consume all available space. Always configure logging drivers in `docker-compose.yml`:
  ```yaml
  logging:
    driver: "json-file"
    options:
      max-size: "10m"
      max-file: "3"
  ```

## 23. Healthchecks

- **Reliability:** Include `healthcheck` definitions in `docker-compose.yml` so Traefik knows when a service is actually ready to receive traffic.

## 24. Resource Limits

- **Protect the NAS:** For CPU/RAM intensive containers (like `flaresolverr` or transcoding), suggest adding `deploy.resources.limits` to prevent slowing down the entire NAS.

## 25. Container Updates

- **Standard Procedure:** To update a container, use the standard flow: `docker compose pull <service> && docker compose up -d <service>`. Do not use `docker restart` to update an image.

## 26. Container Naming & Labels

- **Consistency:** Follow existing naming patterns (`container_name`, label prefixes, logging blocks) when adding services so monitoring tools and Traefik configs remain predictable.
- **Traefik IDs:** Match router/middleware/service names to the container (e.g., `radarr` → `traefik.http.routers.radarr`).
- **Logging Blocks:** Reuse the standard logging driver snippet (see section 22) for every service.

## 27. Helper Tool Failures

- **Re-source Tools:** If `nas_exec`, `nas_connect`, or `nas_test` fails unexpectedly, re-run `source /Volumes/docker/VS-code-config-for-NAS/nas_tools.sh` and retry.
- **SSH Keys:** Verify the SSH key path (`~/.ssh/id_ed25519`) and permissions if authentication errors appear.
- **Error Codes:** Mention typical exit codes (e.g., 255 for SSH failure) so the user immediately knows which layer broke.

## 28. Secrets Management

- **.env Files:** Sensitive values live in `.env` files (e.g., `.env.nas`). Reference them via `${VAR}` inside compose files.
- **No Inline Secrets:** Never hardcode API keys, tokens, or passwords in committed files. If a value must be added, direct the user to update the appropriate `.env` instead.
- **Documentation:** When describing a configuration, remind the user where the secret should be stored.

## 29. Monitoring Hooks

- **Dashboards:** After adding or changing a service, confirm whether dashboards like Tautulli, Portainer, or Homepage need updates so the new service is observable.
- **Alerts:** If a service feeds other automation (e.g., Kapowarr monitors), call out any alert integrations that might also need adjustments.

## 30. Rollback Plans

- **Record Undo Steps:** When proposing a change, include how to revert it (e.g., restore a `.bak`, re-run `git checkout -- file`, or revert a compose change).
- **Backups in Commands:** When running shell commands that mutate files, include `cp file file.bak` beforehand where practical so the user has an immediate fallback.

## 31. Network Membership Checks

- **Dual Networks:** Before modifying a service, confirm it is attached to both `media_bridge` and `traefik` (unless there is a documented exception). Call out missing networks explicitly.
- **Network Definitions:** If a compose file references a network, ensure it exists (either external or defined in the stack) before relying on it.

## 32. Tasks & Command References

- **Existing Tasks:** Search for VS Code tasks or scripts (e.g., `deploy-kapowarr-remote`, `nas-connect`) before suggesting custom command sequences.
- **Naming Patterns:** Mention the relevant task/command name so the user can run it directly from the command palette or terminal.

## 33. Service Playbooks

- **Priority Services:** For `kapowarr`, `radarr`, `traefik`, and other critical services, automatically review:
  1.  `docker-compose.yml`
  2.  Service-specific README or docs
  3.  Log path (`/volume1/docker/<service>/config/logs`)
  4.  Health endpoint or CLI check (`/ping`, `/health`, etc.)
- **Escalation:** If a service feeds other automation (e.g., Kapowarr affecting Radarr), call out downstream impacts.

## 34. Shared Storage Awareness

- **Common Volumes:** Be aware of shared mounts like `/volume1/PlexMediaServer/Usenet/Complete/Movies`. Highlight cross-service implications (e.g., deleting files, changing permissions) before suggesting actions.
- **Locking Risks:** Mention potential conflicts if multiple services rely on the same volume (e.g., downloads folder).

## 35. Environment Validation

- **Initial Check:** At the start of a session—or when encountering repeated command failures—run `nas_test` to verify the SSH tunnel and environment variables.
- **Reconnect Guidance:** If `nas_test` fails, suggest rerunning `nas_connect` or re-sourcing `nas_tools.sh` before proceeding.
