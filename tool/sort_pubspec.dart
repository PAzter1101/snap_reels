import 'dart:io';

import 'package:yaml/yaml.dart';
import 'package:yaml_edit/yaml_edit.dart';

/// Sorts keys in `dependencies`, `dev_dependencies` and `dependency_overrides`
/// of `pubspec.yaml` alphabetically.
///
/// Usage:
///   dart run tools/sort_pubspec.dart           — write the sorted file
///   dart run tools/sort_pubspec.dart --check   — exit 1 if changes needed
const _sections = {
  'dependencies',
  'dev_dependencies',
  'dependency_overrides',
};

void main(List<String> args) {
  final checkOnly = args.contains('--check');
  final file = File('pubspec.yaml');
  if (!file.existsSync()) {
    stderr.writeln('pubspec.yaml not found in cwd');
    exit(2);
  }

  final original = file.readAsStringSync();
  final editor = YamlEditor(original);
  final root = editor.parseAt([]) as YamlMap;

  for (final section in _sections) {
    final node = root.nodes[section];
    if (node is! YamlMap) continue;
    final keys = node.keys.cast<String>().toList();
    final sorted = [...keys]..sort();
    if (_listEquals(keys, sorted)) continue;

    final entries = <String, dynamic>{};
    for (final key in sorted) {
      entries[key] = node.nodes[key];
    }
    editor.update([section], entries);
  }

  final updated = editor.toString();
  if (updated == original) {
    stdout.writeln('pubspec.yaml: already sorted');
    return;
  }

  if (checkOnly) {
    stderr.writeln(
      'pubspec.yaml: dependencies are not sorted alphabetically.\n'
      'Run: dart run tools/sort_pubspec.dart',
    );
    exit(1);
  }

  file.writeAsStringSync(updated);
  stdout.writeln('pubspec.yaml: sorted');
}

bool _listEquals(List<String> a, List<String> b) {
  if (a.length != b.length) return false;
  for (var i = 0; i < a.length; i++) {
    if (a[i] != b[i]) return false;
  }
  return true;
}
