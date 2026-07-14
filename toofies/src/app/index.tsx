// Toofies — home screen (FUNCTIONAL SCAFFOLDING, un-styled by intent).
//
// Constitution §1: no color/type/layout/brand decisions are made here. This
// screen exists to prove the ported economy works on a real device. Its look
// is the explicit next step — produced as options through the design gate, not
// decided in this file. Everything below uses system defaults and structural
// spacing only.

import { useMemo, type ReactNode } from 'react';
import { Pressable, ScrollView, StyleSheet, Text, View } from 'react-native';
import { SafeAreaView } from 'react-native-safe-area-context';

import { useStore, useToofies } from '@/lib/store';
import { TREATS, type TreatKind } from '@/lib/treats';

// A short row of desserts to log with, so the mechanic is interactive.
const QUICK_LOG: TreatKind[] = ['cookie', 'iceCream', 'cake', 'donut'];

export default function HomeScreen() {
  const { logDessert, reset, state } = useStore();
  // Snapshot "now" once per render so all derived values agree.
  const now = useMemo(() => new Date(), []);
  const t = useToofies(now);

  const recency =
    t.daysSinceLastDessert === null
      ? 'No desserts logged yet.'
      : t.daysSinceLastDessert === 0
        ? 'You had a dessert today.'
        : `It's been ${t.daysSinceLastDessert} day${t.daysSinceLastDessert === 1 ? '' : 's'} since your last dessert.`;

  const safe = t.availability.affordable
    ? `Yes — you've banked ${t.availability.bankedDesserts} dessert${t.availability.bankedDesserts === 1 ? '' : 's'}.`
    : `Not yet — ${t.availability.pointsNeeded} more points (about ${t.availability.cleanDaysNeeded} clean day${t.availability.cleanDaysNeeded === 1 ? '' : 's'}).`;

  return (
    <SafeAreaView style={styles.safe}>
      <ScrollView contentContainerStyle={styles.content}>
        <View style={styles.banner}>
          <Text style={styles.bannerText}>
            UNSTYLED SCAFFOLDING — proving the mechanic. The real design comes next.
          </Text>
        </View>

        <Text style={styles.h1}>Toofies</Text>

        {/* Recency — the first-class surface. */}
        <Section title="When did I last have a dessert?">
          <Text style={styles.big}>{recency}</Text>
          <Text style={styles.muted}>
            {t.cleanSoFarToday ? 'Clean so far today.' : 'Logged one today.'}
          </Text>
        </Section>

        {/* Economy (opt-in experiment — D7–D9). */}
        <Section title="Am I safe to have a dessert?">
          <Text style={styles.big}>{safe}</Text>
          <Text style={styles.muted}>
            Balance {t.availability.balance} / {t.availability.cost} pts · +
            {t.pendingPointsToday} banks tonight
          </Text>
        </Section>

        <Section title="Days on plan">
          <Text style={styles.big}>{t.onPlanStreak}</Text>
          {t.streakMilestoneToday !== null && (
            <Text style={styles.muted}>Milestone: {t.streakMilestoneToday} days 🦷</Text>
          )}
        </Section>

        {/* Interactive: log a dessert so the numbers move. */}
        <Section title="Log a dessert">
          <View style={styles.row}>
            {QUICK_LOG.map((kind) => (
              <Pressable key={kind} style={styles.chip} onPress={() => logDessert(kind)}>
                <Text style={styles.chipText}>
                  {TREATS[kind].emoji} {TREATS[kind].name}
                </Text>
              </Pressable>
            ))}
          </View>
        </Section>

        <Section title="Last 7 days">
          <View style={styles.week}>
            {t.week.map((d) => (
              <View key={d.key} style={styles.day}>
                <Text style={styles.dayCount}>{d.count > 0 ? d.count : '·'}</Text>
                <Text style={styles.dayLabel}>{d.label.slice(0, 3)}</Text>
              </View>
            ))}
          </View>
        </Section>

        {state.entries.length > 0 && (
          <Pressable style={styles.resetBtn} onPress={reset} accessibilityLabel="Clear all logged data">
            <Text style={styles.resetText}>Reset (testing)</Text>
          </Pressable>
        )}
      </ScrollView>
    </SafeAreaView>
  );
}

function Section({ title, children }: { title: string; children: ReactNode }) {
  return (
    <View style={styles.section}>
      <Text style={styles.h2}>{title}</Text>
      {children}
    </View>
  );
}

// Structural styling only — spacing, borders, alignment. No brand color choices;
// borders/greys are neutral scaffolding to be replaced by the design pass.
const styles = StyleSheet.create({
  safe: { flex: 1 },
  content: { padding: 20, gap: 20 },
  banner: {
    borderWidth: 1,
    borderStyle: 'dashed',
    borderColor: '#999',
    borderRadius: 8,
    padding: 10,
  },
  bannerText: { fontSize: 12, color: '#666' },
  h1: { fontSize: 34, fontWeight: '700' },
  section: {
    gap: 6,
    borderWidth: StyleSheet.hairlineWidth,
    borderColor: '#ccc',
    borderRadius: 12,
    padding: 16,
  },
  h2: { fontSize: 13, fontWeight: '600', color: '#888', textTransform: 'uppercase' },
  big: { fontSize: 20, fontWeight: '600' },
  muted: { fontSize: 14, color: '#888' },
  row: { flexDirection: 'row', flexWrap: 'wrap', gap: 8 },
  chip: {
    borderWidth: 1,
    borderColor: '#bbb',
    borderRadius: 20,
    paddingVertical: 8,
    paddingHorizontal: 14,
  },
  chipText: { fontSize: 15 },
  week: { flexDirection: 'row', justifyContent: 'space-between' },
  day: { alignItems: 'center', gap: 4, flex: 1 },
  dayCount: { fontSize: 18, fontWeight: '600' },
  dayLabel: { fontSize: 11, color: '#888' },
  resetBtn: { alignSelf: 'flex-start', paddingVertical: 8 },
  resetText: { fontSize: 13, color: '#c00' },
});
