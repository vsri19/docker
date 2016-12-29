This requires GitLab Runner using Docker Executor in Privileged mode.
`/etc/gitlab-runner/config.toml`

```
[[runners]]
  name = "runner"
  url = "https://gitlab.com/ci"
  token = "TOKEN"
  executor = "docker"
  [runners.docker]
    privileged = true
```
