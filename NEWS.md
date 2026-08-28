# ROvis.table v0.1.0

First release since `ROvis.table` was split out of the `ROvis` monolith into its own
package, and the repository moved from GitLab to GitHub.

### :sparkles: Added

- `ro_gt_theme()`: RIVM-styled theme for `gt` tables.
- `ro_dt_table()` and `ro_dt_theme()`: accessible, keyboard-navigable `DT` tables.
- Added a "Getting Started" vignette.
- Added community health files: `CONTRIBUTING.md`, `CONTRIBUTORS.md`, and issue and
pull request templates.

### :hammer_and_wrench: Changed

- Migrated the repository from GitLab to GitHub (`rivm-syso/ROvis.table`).
- Replaced GitLab CI with a GitHub Actions workflow covering lint, R CMD check, test
coverage, and pkgdown.

### :bug: Fixed 

### :coffin: Deprecated
- Removed the stray `.gitlab-ci.yml` left over from the pre-GitHub setup.

