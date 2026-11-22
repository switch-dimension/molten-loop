# Preview deploy gate

A green local build doesn't prove the change deploys. Hosting platforms build in their own environment, with their own Node version, build command and environment variables, and many failures only show up there. When the project has preview deploys, treat the preview as a gate: it must build, and the feature must load on it.

## 1. Detect the platform

Skip this gate (and record it as `n/a`) when the project has no preview deploys. Look for:

| Signal | Platform |
| --- | --- |
| `vercel.json`, a `.vercel/` folder, or a Vercel check or bot comment on the PR | Vercel |
| `wrangler.toml` / `wrangler.jsonc`, or a Cloudflare Pages or Workers Builds check on the PR | Cloudflare |
| `netlify.toml`, or a Netlify check on the PR | Netlify |
| `render.yaml`, `fly.toml`, `amplify.yml`, or another platform's check | That platform |

The PR itself is the most reliable signal: `gh pr checks <pr>` lists the deploy checks, and `gh api "repos/{owner}/{repo}/deployments?ref=<head-sha>"` lists GitHub deployments for the commit.

## 2. Wait for the preview

- Wait for the deploy check to finish, alongside CI (`gh pr checks <pr> --watch`).
- Get the preview URL from the deployment's status (`environment_url` from `gh api "repos/{owner}/{repo}/deployments/<id>/statuses"`), the platform's bot comment on the PR, or the check's details link.
- If no deploy check appears within a few minutes of pushing, say so: the Git integration may not be connected. Record the gate as `partial` rather than waiting forever.

## 3. If the deploy failed

Read the build log before touching code:

- **Vercel:** `vercel inspect <deployment-url> --logs` (needs the Vercel CLI, logged in).
- **Cloudflare:** open the check's details link, or `npx wrangler pages deployment list --project-name <name>` to find the deployment, then read its log in the dashboard.
- **Netlify:** open the check's details link, or use the Netlify CLI if it's installed.
- **Anything else, or no CLI access:** open the check's details link, or ask the user to paste the log.

Common causes worth checking first:

- **A missing environment variable** in the preview environment. Every new variable in `.env.example` must also be set for previews (e.g. `vercel env ls preview`).
- **A different runtime version**, such as Node, from the one used locally. Pin it (`engines` in `package.json`, `.nvmrc`, or the platform setting).
- **Case-sensitive imports** that work on macOS but fail on Linux builders.
- **Code that only runs on the server or only in the browser** but is bundled for the other, or an edge runtime missing a Node API.
- **Build output or a framework preset** that doesn't match the project.

Record the failure and its cause in the ship report, set `result: blocked`, and route the fix back through **mt-build**. Then run mt-ship again.

## 4. Smoke-test the preview

Once the preview is live:

- Request the preview URL and the routes the feature touches. Each should return 2xx, not an error page.
- If a browser tool is available, open the feature's main flow on the preview and check for console errors and failed network requests.
- **Protected previews** (Vercel Deployment Protection, Cloudflare Access) return 401 or redirect to a login. Use a bypass token if the project has one; otherwise ask the user to check the preview and record the gate as `partial`.

## Record it

Add a row to the Gates table in the ship report:

| Gate | Command | Result |
| --- | --- | --- |
| Preview deploy | `<platform>` check + smoke test of `<preview URL>` | pass / fail / partial / n/a |

Put the preview URL in the PR body under **Evidence**.
