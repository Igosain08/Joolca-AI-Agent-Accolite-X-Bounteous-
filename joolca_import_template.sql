
-- joolca_import_template.sql
-- HOW TO USE:
-- 1) Set your project UUID and (optionally) a sprint UUID below.
-- 2) Create staging tables and import CSVs via the dashboard or psql COPY.
-- 3) Map emails to user UUIDs in temp_user_map (edit the VALUES list).
-- 4) Run the INSERT ... SELECT to populate tickets/comments using your RLS-safe create_ticket().

-- >>> EDIT THESE
\set project_id '00000000-0000-0000-0000-000000000000'   -- replace
\set sprint_id  NULL                                      -- or 'your-sprint-uuid'

-- Staging tables
create table if not exists ticket_seed_detailed (
  external_ref text primary key,
  title text not null,
  description text not null,
  type ticket_type not null,
  status ticket_status not null,
  priority ticket_priority not null,
  labels text[] not null,
  estimate numeric(6,2),
  due_date date,
  assignee_email text,
  parent_external_ref text,
  customer_name text,
  customer_email text,
  order_id text,
  region text,
  channel text,
  browser_device text,
  environment text
);

create table if not exists comment_seed_detailed (
  ticket_external_ref text,
  author_email text,
  body text,
  created_at timestamptz
);

-- Example mapping from emails to existing auth.users UUIDs.
-- Replace email/uuid pairs with your real users.
create temp table temp_user_map(email text primary key, user_id uuid);
insert into temp_user_map(email, user_id) values
  ('alex@yourcompany.com','00000000-0000-0000-0000-000000000001'),
  ('sam@yourcompany.com','00000000-0000-0000-0000-000000000002'),
  ('jordan@yourcompany.com','00000000-0000-0000-0000-000000000003'),
  ('taylor@yourcompany.com','00000000-0000-0000-0000-000000000004'),
  ('devon@yourcompany.com','00000000-0000-0000-0000-000000000005');

-- Optional sprint id
create temp table temp_sprint(sprint_id uuid);
insert into temp_sprint values (:sprint_id::uuid);

-- Insert tickets using your SECURITY DEFINER function create_ticket(...)
with cfg as (
  select :project_id::uuid as project_id
),
created as (
  select
    s.external_ref,
    (create_ticket(
      (select project_id from cfg),
      s.title,
      s.description,
      s.type,
      s.priority,
      (select user_id from temp_user_map where email = s.assignee_email),
      null,
      s.due_date
    )).id as ticket_id
  from ticket_seed_detailed s
),
resolved as (
  select c.ticket_id, s.*
  from created c
  join ticket_seed_detailed s using (external_ref)
)
update tickets t
set
  status = r.status,
  labels = r.labels,
  estimate = r.estimate,
  sprint_id = (select sprint_id from temp_sprint),
  parent_id = p.ticket_id
from resolved r
left join created p on p.external_ref = r.parent_external_ref
where t.id = r.ticket_id;

-- Insert comments
insert into comments (id, ticket_id, author, body, created_at, updated_at)
select gen_random_uuid(), c.ticket_id, m.user_id, s.body, s.created_at, s.created_at
from comment_seed_detailed s
join created c on c.external_ref = s.ticket_external_ref
left join temp_user_map m on m.email = s.author_email;
