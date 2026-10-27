# Notes

## Where the agent broke a rule

During step 4, Codex had read columns directly instead of using the hash-style access required by AGENTS.md. In app/models/movie.rb, studio_must_exist used studio_id directly. In app/models/role.rb, movie_must_exist and actor_must_exist used movie_id and actor_id directly.

The review identified the required correction: replace both reads of each column with self["studio_id"], self["movie_id"], or self["actor_id"]. A follow-up inspection confirmed those replacements in the model files. A test run after the correction still needs to be verified before committing.

Each time your agent did something `AGENTS.md` says not to (skipped the failing run, used
`belongs_to`, wrote `movie.title`, hard-coded an id, ran `git`, edited `DONE.md`): what it did,
and what you did about it. If it never did, leave this empty.

After the correction, I ran bin/rails test: 19 tests, 19 assertions, 0 failures, 0 errors, and 0 skips.

## What the tests did

When a new rule arrives and tests you already had go red: which ones failed, and why. Leave it
empty until that happens.
