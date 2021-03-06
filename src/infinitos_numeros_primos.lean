import data.nat.factorial
import data.nat.prime
import tactic

open nat

-- Para que no use la notación con puntos
set_option pp.structure_projections false

theorem infinitos_numeros_primos:
  ∀ n, ∃ p ≥ n, prime p:=
begin
  intro n,

  let m := factorial n + 1,
  let p := min_fac m,
  have hp : prime p ,
  { refine min_fac_prime _,
    have : 0 < factorial n := factorial_pos n,
    linarith,},

  use p,
  split,
  { by_contradiction,
    have h1 : p ∣ factorial n + 1 := min_fac_dvd m,
    have h2 : p ∣ factorial n,
    exact iff.mpr (prime.dvd_factorial hp) (le_of_not_ge h),
    have h3 : p ∣ 1 := (nat.dvd_add_right h2).mp h1,
    exact prime.not_dvd_one hp h3,},
  { exact hp, },
end

lemma h2
  (n : ℕ)
  (m = factorial n + 1)
  (p = min_fac m)
  (hp : prime p)
  (h : ¬p ≥ n)
  (h1 : p ∣ factorial n + 1)
  : p ∣ factorial n:=
begin
  refine (prime.dvd_factorial hp).mpr _,
  exact le_of_not_ge h,
end

lemma hp
  (n m p : ℕ)
  (h1p : m = factorial n + 1)
  (h2p : p = min_fac m)
  : prime p :=
begin
  rw h2p,
  refine min_fac_prime _,
  have : 0 < factorial n := factorial_pos n,
  linarith,
end
