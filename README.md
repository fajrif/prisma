# Prisma (prisma-ads.com)

Rails 7.1 CMS application for **Prisma Advertising OOH Indonesia** — a corporate website manager for an outdoor advertising (OOH) company. It powers multilingual (English/Indonesian) public pages and a comprehensive admin panel for managing pages, articles, reports, archives, portfolios, services, industries, locations, products, careers, banners, snippets, and more.

## Tech Stack

- **Language:** Ruby 3.3.0
- **Framework:** Rails ~> 7.1.3
- **Database:** PostgreSQL 13+ (schema search path: `myapp, sharedapp, public`)
- **Web server (dev):** Puma
- **Web server (prod):** Unicorn
- **Reverse proxy (prod):** Nginx
- **Frontend:** Sprockets asset pipeline, jQuery + jQuery UI, Quill.js rich text editor, PDF.js
- **Key gems:**
  - `mobility` — model translations (JSONB columns + ActionText backend)
  - `devise` — admin authentication
  - `pundit` — authorization
  - `friendly_id` — SEO-friendly slugs
  - `kaminari` — pagination
  - `acts_as_tree` — hierarchical snippets
  - `simple_form` — form builder
  - `image_processing` / `active_storage` — file & image uploads
  - `sib-api-v3-sdk` — Sendinblue transactional email

## Requirements

- Ruby 3.3.0 (e.g. via rbenv or rvm)
- PostgreSQL running locally on `localhost:5432`
- Node.js (optional, only needed if JS asset tooling is added)
- ImageMagick / libvips for ActiveStorage variants

## Database Credentials

Defaults are in `config/database.yml`:

- Username: `deployer`
- Password: `deployer1234!`
- Host: `localhost:5432`

Use environment variables / `config/configatron/*.rb` to override for production.

## Run Locally

```bash
bundle install
bin/rails db:create
bin/rails db:migrate
bin/rails db:seed
bin/rails server   # http://localhost:3000
```

Admin login is handled by Devise (`app/models/admin.rb`). See `db/seeds.rb` for the seeded admin account.

### Useful commands

```bash
bin/rails db:rollback    # rollback last migration
bin/rails db:reset       # drop, create, migrate, seed
bin/rails routes         # list routes
bin/rails console        # Rails console
bin/rails assets:precompile  # compile assets for production
```

## Deployment (VPS — Ubuntu 24, Nginx + Unicorn)

Deployment path on the server: `/home/deployer/prisma`.

On each deploy:

```bash
cd /home/deployer/prisma

# 1. Pull latest code
git pull origin main

# 2. Install dependencies
bundle install --deployment --without development test

# 3. Migrate database
RAILS_ENV=production bin/rails db:migrate

# 4. Precompile assets & clear cache
RAILS_ENV=production bin/rails assets:precompile
RAILS_ENV=production bin/rails tmp:cache:clear    # if asset cache issues

# 5. Restart Unicorn
kill -USR2 $(cat tmp/pids/unicorn.pid)
# or, if the process was stopped:
bundle exec unicorn -c config/unicorn.rb -E production -D
```

Notes:

- Unicorn runs as the **deployer** user, configured in `config/unicorn.rb` → socket at `tmp/sockets/unicorn.prisma.sock`.
- Nginx config references a `prisma` upstream server and proxies to the Unicorn socket. The repo ships a reference `config/nginx.conf`.
- Ensure `/home/deployer/prisma/tmp`, `log`, and `public` have the correct permissions for the `deployer` user.
- Backups: dump the `prisma_production` database before destructive migrations.
- Production config at `config/configatron/production.rb`; secrets via environment variables / dotenv.