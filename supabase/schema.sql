-- Run this once in Supabase SQL Editor.
create table if not exists public.tasks (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users(id) on delete cascade,
  title text not null check (char_length(trim(title)) between 1 and 150),
  description text not null default '',
  category text not null default 'Personal' check (category in ('Personal','School','Work')),
  priority text not null default 'Medium' check (priority in ('Low','Medium','High')),
  status text not null default 'To do' check (status in ('To do','In progress','Completed')),
  due_date date,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);
create index if not exists tasks_user_due_idx on public.tasks(user_id, due_date);
alter table public.tasks enable row level security;
create policy "Users can view own tasks" on public.tasks for select to authenticated using ((select auth.uid()) = user_id);
create policy "Users can add own tasks" on public.tasks for insert to authenticated with check ((select auth.uid()) = user_id);
create policy "Users can update own tasks" on public.tasks for update to authenticated using ((select auth.uid()) = user_id) with check ((select auth.uid()) = user_id);
create policy "Users can delete own tasks" on public.tasks for delete to authenticated using ((select auth.uid()) = user_id);
