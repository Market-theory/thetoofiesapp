// The on-device Toofies store: holds the economy state, persists it locally,
// and exposes read-derived values + actions to the UI. On-device only — no
// network, no account (constitution §5 / D4).

import AsyncStorage from '@react-native-async-storage/async-storage';
import {
  createContext,
  useContext,
  useEffect,
  useMemo,
  useState,
  type ReactNode,
} from 'react';

import {
  availability,
  balance,
  daysSinceLastDessert,
  initialState,
  isCleanSoFarToday,
  lastDessertDate,
  lastSevenDays,
  onPlanStreak,
  pendingPointsToday,
  streakMilestoneToday,
  type EconomyState,
} from './economy';
import { makeEntry, type TreatEntry, type TreatKind } from './treats';

const STORAGE_KEY = 'toofies.v2';

type Store = {
  ready: boolean;
  state: EconomyState;
  // Actions
  logDessert: (kind: TreatKind, at?: Date) => void;
  removeEntry: (id: string) => void;
  setDessertCost: (cost: number) => void;
  reset: () => void;
};

const StoreContext = createContext<Store | null>(null);

export function StoreProvider({ children }: { children: ReactNode }) {
  const [state, setState] = useState<EconomyState>(() => initialState());
  const [ready, setReady] = useState(false);

  // Hydrate from disk once on mount.
  useEffect(() => {
    let alive = true;
    (async () => {
      try {
        const raw = await AsyncStorage.getItem(STORAGE_KEY);
        if (alive && raw) {
          const saved = JSON.parse(raw) as Partial<EconomyState>;
          setState((prev) => ({ ...prev, ...saved }));
        }
      } catch {
        // Corrupt or missing store — start fresh; nothing to surface.
      } finally {
        if (alive) setReady(true);
      }
    })();
    return () => {
      alive = false;
    };
  }, []);

  // Persist on every change, but only after the initial hydrate so we never
  // clobber saved data with the empty initial state.
  useEffect(() => {
    if (!ready) return;
    AsyncStorage.setItem(STORAGE_KEY, JSON.stringify(state)).catch(() => {});
  }, [state, ready]);

  const store = useMemo<Store>(
    () => ({
      ready,
      state,
      logDessert: (kind, at = new Date()) =>
        setState((s) => ({
          ...s,
          entries: [...s.entries, makeEntry(kind, s.dessertCost, at)],
        })),
      removeEntry: (id) =>
        setState((s) => ({ ...s, entries: s.entries.filter((e: TreatEntry) => e.id !== id) })),
      setDessertCost: (cost) => setState((s) => ({ ...s, dessertCost: Math.max(1, cost) })),
      reset: () => setState(initialState()),
    }),
    [ready, state],
  );

  return <StoreContext.Provider value={store}>{children}</StoreContext.Provider>;
}

export function useStore(): Store {
  const ctx = useContext(StoreContext);
  if (!ctx) throw new Error('useStore must be used within a StoreProvider');
  return ctx;
}

/** Derived view-model for the home screen, recomputed against `now`. */
export function useToofies(now: Date = new Date()) {
  const { state } = useStore();
  return useMemo(
    () => ({
      daysSinceLastDessert: daysSinceLastDessert(state, now),
      lastDessertDate: lastDessertDate(state),
      cleanSoFarToday: isCleanSoFarToday(state, now),
      balance: balance(state, now),
      availability: availability(state, now),
      pendingPointsToday: pendingPointsToday(state, now),
      onPlanStreak: onPlanStreak(state, now),
      streakMilestoneToday: streakMilestoneToday(state, now),
      week: lastSevenDays(state, now),
    }),
    // now is intentionally a snapshot for this render.
    // eslint-disable-next-line react-hooks/exhaustive-deps
    [state, now.getTime()],
  );
}
