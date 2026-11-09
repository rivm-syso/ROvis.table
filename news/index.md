# Changelog

## ROvis.table 0.1.0

First release since `ROvis.table` was split out of the `ROvis` monolith
into its own package, and the repository moved from GitLab to GitHub.

#### ✨ Added

- [`ro_gt_theme()`](https://rivm-syso.github.io/ROvis.table/reference/ro_gt_theme.md):
  RIVM-styled theme for `gt` tables.
- [`ro_dt_table()`](https://rivm-syso.github.io/ROvis.table/reference/ro_dt_table.md)
  and
  [`ro_dt_theme()`](https://rivm-syso.github.io/ROvis.table/reference/ro_dt_theme.md):
  accessible, keyboard-navigable `DT` tables.
- Added a “Getting Started” vignette.
- Added community health files: `CONTRIBUTING.md`, `CONTRIBUTORS.md`,
  and issue and pull request templates.

#### 🛠️ Changed

- Migrated the repository from GitLab to GitHub
  (`rivm-syso/ROvis.table`).
- Replaced GitLab CI with a GitHub Actions workflow covering lint, R CMD
  check, test coverage, and pkgdown.

#### 🐛 Fixed

#### ⚰️ Deprecated

- Removed the stray `.gitlab-ci.yml` left over from the pre-GitHub
  setup.
