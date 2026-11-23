-- SAFE FIX for an existing TaskFlow database. Run only in the TaskFlow project.
-- Does not delete or change any task rows.
begin;
grant usage on schema public to authenticated;
grant select, insert, update, delete on table public.tasks to authenticated;
revoke all on table public.tasks from anon;
alter table public.tasks enable row level security;
commit;

-- Check: rls_enabled must be true; policies should include SELECT, INSERT, UPDATE, DELETE.
select c.relname as table_name, c.relrowsecurity as rls_enabled
from pg_class c where c.oid = 'public.tasks'::regclass;
select policyname, cmd, roles, qual, with_check
from pg_policies where schemaname='public' and tablename='tasks';
