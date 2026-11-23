# TaskFlow — Student Task Management System

A complete portfolio-ready React + Supabase task manager with real email/password authentication, per-user cloud tasks, CRUD, status tracking, due dates, priorities, search, sorting, dashboard stats, responsive layout, and dark mode.

## Requirements
- Node.js 20.19+ or 22.12+ recommended
- VS Code
- Free Supabase account

## 1. Install and run
Open the `taskflow` folder in VS Code, then open Terminal:

```bash
npm install
```

Copy `.env.example` to `.env` (on Windows PowerShell: `Copy-Item .env.example .env`).

## 2. Configure Supabase
1. Go to https://supabase.com/dashboard and create a new project.
2. In **SQL Editor**, paste and run the contents of `supabase/schema.sql` **once**. If you need to rerun after policies already exist, delete the old policies first; do not delete your tasks.
3. In **Project Settings → API Keys** (or **Connect**), copy the project URL and the **publishable/anon** key.
4. Fill `.env`:

```env
VITE_SUPABASE_URL=https://your-project.supabase.co
VITE_SUPABASE_ANON_KEY=your-publishable-or-anon-key
```

**Never use a `service_role` or secret key in Vite.** Frontend environment variables are public. RLS policies protect each user's tasks.

5. In Supabase **Authentication → Providers → Email**, enable email/password sign-in. If email confirmation is enabled, sign up and click the confirmation email before logging in.
6. In **Authentication → URL Configuration**, set **Site URL** to `http://localhost:5173` for local testing and add your deployed website URL to redirect URLs later. For password reset links, include the appropriate local and deployed URLs.

## 3. Start the app

```bash
npm run dev
```

Open the localhost address shown in the terminal (usually http://localhost:5173). Sign up, confirm your email if needed, sign in, and create tasks.

## 4. Production build

```bash
npm run build
npm run preview
```

Deploy to **Vercel**, **Netlify**, or **Render Static Site**. Set the two `VITE_` environment variables in your host's dashboard. Build command: `npm install && npm run build`; publish directory: `dist`. Add the live URL to Supabase Auth redirect URLs / Site URL. No backend server is needed because Supabase hosts authentication and database.

## Portfolio description
**TaskFlow** is a responsive productivity web app built with React, Vite, and Supabase. It features secure user authentication, personal task management, live progress statistics, priorities, deadlines, filtering, sorting, and dark mode. Data is stored in Supabase Postgres with row-level security.

## Folder structure
```
taskflow/
  index.html
  package.json
  vite.config.js
  .env.example
  .gitignore
  src/
    main.jsx
    App.jsx
    style.css
    supabase.js
  supabase/
    schema.sql
  README.md
```

## Security notes
- User ID comes from the active Supabase session, not a form field.
- Database row-level security limits access to the signed-in user's tasks.
- No payment system is included.
- Supabase credentials are **not** included in this zip; provide your own public project URL and publishable key.
