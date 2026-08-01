-- Flappy Face — ortak rekor tablosu
-- Supabase panelinde SQL Editor'e yapıştırıp "Run" demek yeterli.

create table if not exists public.char_scores (
  char_id    int primary key,
  name       text,
  best       int not null default 0,
  updated_at timestamptz not null default now()
);

alter table public.char_scores enable row level security;

-- Rekorları herkes okuyabilir.
drop policy if exists "rekorlari herkes okur" on public.char_scores;
create policy "rekorlari herkes okur"
  on public.char_scores for select
  to anon, authenticated
  using (true);

-- Yazma yalnızca bu fonksiyon üzerinden: skor ancak mevcut rekoru geçerse yükselir,
-- kimse doğrudan tabloya insert/update/delete yapamaz.
create or replace function public.submit_score(p_char int, p_name text, p_score int)
returns int
language plpgsql
security definer
set search_path = public
as $$
declare v_best int;
begin
  if p_char is null or p_char < 0 or p_char > 99 then
    raise exception 'gecersiz karakter';
  end if;
  if p_score is null or p_score < 0 or p_score > 100000 then
    raise exception 'gecersiz skor';
  end if;

  insert into char_scores (char_id, name, best)
  values (p_char, left(coalesce(p_name, ''), 40), p_score)
  on conflict (char_id) do update
    set best       = greatest(char_scores.best, excluded.best),
        name       = excluded.name,
        updated_at = now();

  select best into v_best from char_scores where char_id = p_char;
  return v_best;
end;
$$;

revoke all on function public.submit_score(int, text, int) from public;
grant execute on function public.submit_score(int, text, int) to anon, authenticated;
