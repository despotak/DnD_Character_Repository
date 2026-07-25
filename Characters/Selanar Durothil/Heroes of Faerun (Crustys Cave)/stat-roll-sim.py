#!/usr/bin/env python3
"""
Monte Carlo simulation of Heroes of Faerun's (Crusty's) stat-rolling house rule.

Mechanic (per direct GM clarification, see gm-correspondence.md):
  - An array = 5 stats rolled 4d6-drop-lowest, plus a derived 6th stat = 75 - sum(other five).
  - If that derived 6th stat falls outside 3-18 (physically impossible on the dice),
    the WHOLE array is mulliganed and re-rolled from scratch.
  - Each player rolls 4 arrays and discards 1, keeping 3.
  - All kept arrays go into a shared pool anyone at the table can draw from
    (no array reused by two people).

Usage:
  python stat-roll-sim.py [--trials N] [--players N] [--seed N]
"""

import argparse
import random
from statistics import mean, median


def roll_stat():
    dice = sorted(random.randint(1, 6) for _ in range(4))
    return sum(dice[1:])  # drop lowest


def roll_array():
    while True:
        five = [roll_stat() for _ in range(5)]
        sixth = 75 - sum(five)
        if 3 <= sixth <= 18:
            return five + [sixth]
        # else: whole array mulligans, loop again


def fit_score(array):
    """Heuristic for 'how good is this array': top stat + half the second.
    Also used to decide which array a player discards (lowest score dropped)
    and, from a shared pool, which array is the best pick for a build that
    wants one strong primary stat and one solid secondary."""
    top, second = sorted(array, reverse=True)[:2]
    return top + 0.5 * second


def player_kept_arrays(n_roll=4, n_keep=3):
    arrays = [roll_array() for _ in range(n_roll)]
    arrays.sort(key=fit_score, reverse=True)
    return arrays[:n_keep]


def percentile(values, p):
    s = sorted(values)
    idx = min(int(len(s) * p), len(s) - 1)
    return s[idx]


def main():
    parser = argparse.ArgumentParser(
        description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter
    )
    parser.add_argument(
        "--trials",
        type=int,
        default=50000,
        help="number of pool simulations to run (default 50000)",
    )
    parser.add_argument(
        "--players",
        type=int,
        default=3,
        help="number of players contributing arrays to the pool (default 3)",
    )
    parser.add_argument(
        "--seed",
        type=int,
        default=None,
        help="RNG seed for reproducible results (default: random each run)",
    )
    args = parser.parse_args()

    if args.seed is not None:
        random.seed(args.seed)

    # --- Single array shape ---
    single_arrays = [roll_array() for _ in range(args.trials * 4)]
    sorted_positions = list(zip(*[sorted(a, reverse=True) for a in single_arrays]))

    # --- Full pool (players x keep-3-of-4), best-fit array per trial ---
    best_top, best_second, pool_top_stat = [], [], []
    for _ in range(args.trials):
        pool = []
        for _ in range(args.players):
            pool.extend(player_kept_arrays())
        best = max(pool, key=fit_score)
        top, second = sorted(best, reverse=True)[:2]
        best_top.append(top)
        best_second.append(second)
        pool_top_stat.append(max(max(a) for a in pool))

    # --- Solo comparison: only your own 3 kept arrays, no shared pool ---
    solo_top, solo_second = [], []
    for _ in range(args.trials):
        mine = player_kept_arrays()
        best = max(mine, key=fit_score)
        top, second = sorted(best, reverse=True)[:2]
        solo_top.append(top)
        solo_second.append(second)

    print(f"=== Single array shape ({len(single_arrays)} arrays rolled) ===")
    print("Mean of each sorted position (highest -> lowest):")
    print(" ", [round(mean(p), 2) for p in sorted_positions])
    print("Median of each sorted position:")
    print(" ", [median(p) for p in sorted_positions])

    print()
    print(
        f"=== Shared pool: {args.players} players x keep-3-of-4 = {args.players * 3} arrays ({args.trials} trials) ==="
    )
    print("Best-fit array's top stat (e.g. INT), picking optimally from the pool:")
    print(
        f"  mean={mean(best_top):.2f}  median={median(best_top)}  p10={percentile(best_top, 0.10)}  p90={percentile(best_top, 0.90)}"
    )
    print("Same array's second stat (e.g. DEX):")
    print(
        f"  mean={mean(best_second):.2f}  median={median(best_second)}  p10={percentile(best_second, 0.10)}  p90={percentile(best_second, 0.90)}"
    )
    print("Single highest stat anywhere in the full pool (upper bound):")
    print(
        f"  mean={mean(pool_top_stat):.2f}  median={median(pool_top_stat)}  p90={percentile(pool_top_stat, 0.90)}"
    )

    print()
    print(
        "=== For comparison: picking only from your OWN 3 kept arrays (no shared pool) ==="
    )
    print(
        f"Best-fit array's top stat:    mean={mean(solo_top):.2f}  median={median(solo_top)}"
    )
    print(
        f"Same array's second stat:     mean={mean(solo_second):.2f}  median={median(solo_second)}"
    )


if __name__ == "__main__":
    main()
