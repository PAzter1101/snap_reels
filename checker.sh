#!/bin/bash
# Full snap_reels check before commit / publish:
#   1) flutter pub get
#   2) dart run build_runner build --delete-conflicting-outputs
#   3) auto-fix code style (silently):
#      - dart fix --apply       (linter refactors)
#      - dart format lib test   (final formatting)
#   4) in parallel (fail-fast): flutter analyze, flutter test,
#      dart pub publish --dry-run.

set -e

cd "$(dirname "${BASH_SOURCE[0]}")"

step() {
  echo ""
  echo "▶ $1"
}

step "flutter pub get"
flutter pub get

step "dart run build_runner build --delete-conflicting-outputs"
dart run build_runner build --delete-conflicting-outputs

step "dart fix --apply"
dart fix --apply

step "dart run import_sorter:main --no-comments"
dart run import_sorter:main --no-comments

step "dart run tool/sort_pubspec.dart"
dart run tool/sort_pubspec.dart

step "dart format lib test"
dart format lib test

TMP_DIR=$(mktemp -d)
trap 'rm -rf "$TMP_DIR"' EXIT

declare -A PROC_NAME
declare -A PROC_LOG
declare -A PROC_CODE
ALL_PIDS=()
RUNNING_PIDS=()

# setsid gives each task its own process group so we can kill the whole
# subtree on cancellation.
start() {
  local name=$1
  shift
  local log="$TMP_DIR/${name}.log"
  setsid "$@" >"$log" 2>&1 &
  local pid=$!
  PROC_NAME[$pid]=$name
  PROC_LOG[$pid]=$log
  ALL_PIDS+=("$pid")
  RUNNING_PIDS+=("$pid")
}

step "parallel (fail-fast): flutter analyze + flutter test + pub publish --dry-run"

start flutter_analyze flutter analyze --fatal-infos --fatal-warnings
start flutter_test    flutter test --fail-fast
start pub_dry_run     dart pub publish --dry-run

FAILED=0
FIRST_FAIL=""

# `flutter test` can exit 0 even when tests fail — grep the log to be sure.
finalize_code() {
  local pid=$1 code=$2
  if [ "${PROC_NAME[$pid]}" = "flutter_test" ] && [ "$code" -eq 0 ]; then
    if grep -qE '(Some tests failed|^Failed to load|^Error:)' "${PROC_LOG[$pid]}"; then
      code=1
    fi
  fi
  echo "$code"
}

remove_from_running() {
  local target=$1
  local kept=()
  local pid
  for pid in "${RUNNING_PIDS[@]}"; do
    [ "$pid" = "$target" ] || kept+=("$pid")
  done
  RUNNING_PIDS=("${kept[@]}")
}

set +e
while [ ${#RUNNING_PIDS[@]} -gt 0 ]; do
  wait -n -p FINISHED_PID "${RUNNING_PIDS[@]}"
  RAW_CODE=$?
  CODE=$(finalize_code "$FINISHED_PID" "$RAW_CODE")
  PROC_CODE[$FINISHED_PID]=$CODE
  remove_from_running "$FINISHED_PID"

  if [ "$CODE" -ne 0 ]; then
    FAILED=1
    FIRST_FAIL="${PROC_NAME[$FINISHED_PID]}"
    for pid in "${RUNNING_PIDS[@]}"; do
      kill -TERM -- "-$pid" 2>/dev/null || kill -TERM "$pid" 2>/dev/null || true
    done
    for pid in "${RUNNING_PIDS[@]}"; do
      wait "$pid" 2>/dev/null
      PROC_CODE[$pid]=$?
    done
    RUNNING_PIDS=()
    break
  fi
done
set -e

for pid in "${ALL_PIDS[@]}"; do
  echo ""
  echo "─── ${PROC_NAME[$pid]} ───"
  cat "${PROC_LOG[$pid]}"
done

echo ""
for pid in "${ALL_PIDS[@]}"; do
  NAME=${PROC_NAME[$pid]}
  CODE=${PROC_CODE[$pid]:-cancelled}
  if [ "$CODE" = "cancelled" ]; then
    echo "⏸  $NAME — not run"
  elif [ "$CODE" -eq 0 ]; then
    echo "✅ $NAME OK"
  else
    echo "❌ $NAME FAILED (exit $CODE)"
  fi
done

if [ "$FAILED" -ne 0 ]; then
  echo ""
  echo "⛔ Aborted on: $FIRST_FAIL"
fi

exit "$FAILED"
