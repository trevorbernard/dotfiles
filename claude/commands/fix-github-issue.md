Please analyze and fix the GitHub issue: $ARGUMENTS.

Follow these steps:

1. Use `gh issue view` to get the issue details
2. Understand the problem described in the issue
3. Search the codebase for relevant files. This project has a three-layer pipeline architecture:
   - **Historical** (source → interim → final): Parses raw Sparkplug JSON, deduplicates, merges with production Flink
   - **Upsampled** (source → interim → final): Forward-fills gaps for complete time-series
   - **Aggregated** (source → 1m): Time-weighted 1-minute aggregations
   - **ops_device_catalog** (source → interim → final): Multi-site operational monitoring from heterogeneous sources
   - Changes cascade downstream: Historical → Upsampled → Aggregated (and ops reads from upsampled)
4. Check if the issue involves a macro change, model change, or configuration change
   - Macros are in `macros/` organized by pipeline
   - Models are generated from scripts in `bin/` — if the fix needs to apply across many models, fix the generator instead
   - Equipment-specific logic lives in macros, not individual model files
5. Implement the necessary changes to fix the issue
6. Validate changes compile correctly:
   ```bash
   dbt compile --select <changed_model>
   ```
7. If the fix touches data logic, verify with a Snowflake query:
   ```bash
   snow sql -q "<validation query>"
   ```
8. Run relevant tests:
   ```bash
   dbt test --select <changed_model>
   ```
9. Create a descriptive commit message using conventional commit format
10. Push and create a PR

Remember to use the GitHub CLI (`gh`) for all GitHub-related tasks and `snow sql` (not `snowsql`) for Snowflake queries.
