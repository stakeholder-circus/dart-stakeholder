import 'dart:convert';

import 'catalog.dart';

class RunResult {
  const RunResult(this.exitCode, this.stdoutText, this.stderrText);

  final int exitCode;
  final String stdoutText;
  final String stderrText;
}

class StakeholderRuntime {
  RunResult run(List<String> args) {
    final parsed = _parseArgs(args);
    if (parsed.error != null) {
      return RunResult(1, '', '${parsed.error}\n');
    }

    final provider = parsed.values['experimental-provider'] as String?;
    final hasOrphanExperimental = experimentalFlags
        .where((flag) => flag != 'experimental-provider')
        .any((flag) => parsed.values.containsKey(flag));
    if (provider == null && hasOrphanExperimental) {
      return const RunResult(
          1, '', 'experimental flags require --experimental-provider\n');
    }
    if (provider != null) {
      return const RunResult(1, '',
          'experimental-provider is not implemented yet in dart-stakeholder\n');
    }

    if ((parsed.values['list-values'] as bool?) ?? false) {
      return RunResult(0,
          '${const JsonEncoder.withIndent('  ').convert(_listValues())}\n', '');
    }

    final family = parsed.values['focus-family'] as String?;
    if (family == null || !generatorFamilies.contains(family)) {
      return const RunResult(1, '',
          'focus-family is required and must be a known generator family\n');
    }

    final format = (parsed.values['output-format'] as String?) ?? 'text';
    final seed = (parsed.values['seed'] as String?) ?? 'default-seed';
    final payload = _payloadFor(family, seed);
    if (format == 'json') {
      return RunResult(
          0, '${const JsonEncoder.withIndent('  ').convert(payload)}\n', '');
    }
    return RunResult(0, '${_textFor(payload)}\n', '');
  }

  Map<String, Object> _listValues() {
    return <String, Object>{
      'complexities': complexities,
      'devTypes': devTypes,
      'experimentalFlags': experimentalFlags,
      'experimentalModes': experimentalModes,
      'experimentalProviders': experimentalProviders,
      'flags': <String>[
        'alerts',
        'project',
        'minimal',
        'team',
        'framework',
        'seed',
        'output-format',
        'no-color',
        'trace',
        'list-values',
        ...experimentalFlags,
      ],
      'generatorFamilies': generatorFamilies.map((family) {
        final dedicated = dedicatedFamilyMap[family];
        final rendererKey = dedicated?.rendererKey ??
            fallbackRendererKeys[family] ??
            'fallback.unknown';
        final tranche = dedicated?.tranche ??
            rendererKey.split('.').first.replaceAll('_', '-');
        return <String, Object>{
          'id': family,
          'registryId': family.replaceAll('_', '-'),
          'rendererKey': rendererKey,
          'tranche': tranche,
        };
      }).toList(),
      'jargonLevels': jargonLevels,
      'outputFormats': outputFormats,
      'personalizationProfiles': personalizationProfiles,
      'promptAssets': promptAssets,
    };
  }

  Map<String, Object> _payloadFor(String family, String seed) {
    final context = _contextFor(family, seed);
    return <String, Object>{
      'eventType': 'stakeholder.generator.output',
      'sequence': _sequenceFor(seed, family),
      'family': family,
      'message': 'Deterministic dart tranche for $family',
      'timestamp': _timestampFor(seed, family),
      'context': context,
    };
  }

  Map<String, Object> _contextFor(String family, String seed) {
    final dedicated = dedicatedFamilyMap[family];
    if (dedicated != null) {
      return <String, Object>{
        'rendererKey': dedicated.rendererKey,
        dedicated.contextKey: dedicated.contextValue,
        'seedFingerprint': _fingerprint(seed, family),
        'dartProfile': 'publication-held-wider-matrix',
      };
    }

    final rendererKey = fallbackRendererKeys[family] ?? 'fallback.unknown';
    return <String, Object>{
      'rendererKey': rendererKey,
      'fallbackFamily': rendererKey.split('.').last,
      'seedFingerprint': _fingerprint(seed, family),
      'dartProfile': 'publication-held-wider-matrix',
    };
  }

  String _textFor(Map<String, Object> payload) {
    final context = payload['context']! as Map<String, Object>;
    return [
      'family: ${payload['family']}',
      'renderer: ${context['rendererKey']}',
      'sequence: ${payload['sequence']}',
      'timestamp: ${payload['timestamp']}',
      'message: ${payload['message']}',
    ].join('\n');
  }

  int _sequenceFor(String seed, String family) =>
      (_hash('$seed::$family') % 9000) + 1000;

  String _timestampFor(String seed, String family) {
    final value = _hash('timestamp::$seed::$family');
    final seconds = value % 86400;
    final hour = seconds ~/ 3600;
    final minute = (seconds % 3600) ~/ 60;
    final second = seconds % 60;
    String pad(int v) => v.toString().padLeft(2, '0');
    return '2026-01-01T${pad(hour)}:${pad(minute)}:${pad(second)}Z';
  }

  String _fingerprint(String seed, String family) =>
      '${family.replaceAll('_', '-')}-${_hash('$seed::$family').toRadixString(16)}';

  int _hash(String input) {
    var hash = 0x811C9DC5;
    for (final unit in input.codeUnits) {
      hash ^= unit;
      hash = (hash * 0x01000193) & 0xFFFFFFFF;
    }
    return hash;
  }
}

class _ParsedArgs {
  _ParsedArgs(this.values, this.error);

  final Map<String, Object> values;
  final String? error;
}

_ParsedArgs _parseArgs(List<String> args) {
  final values = <String, Object>{};
  const knownValueFlags = <String>{
    'focus-family',
    'output-format',
    'seed',
    'experimental-provider',
    'experimental-mode',
    'experimental-profile',
    'experimental-prompt-asset',
    'experimental-prompt-version',
    'experimental-personalization-profile',
    'experimental-model',
    'experimental-base-url',
    'experimental-session-file',
    'experimental-store',
    'experimental-bootstrap-command',
  };
  const knownBoolFlags = <String>{
    'list-values',
    'alerts',
    'minimal',
    'team',
    'no-color',
    'trace',
    'experimental-disable-cache',
  };

  var index = 0;
  while (index < args.length) {
    final arg = args[index];
    if (!arg.startsWith('--')) {
      return _ParsedArgs(values, 'unknown positional argument: $arg');
    }
    final flag = arg.substring(2);
    if (knownBoolFlags.contains(flag)) {
      values[flag] = true;
      index += 1;
      continue;
    }
    if (!knownValueFlags.contains(flag)) {
      return _ParsedArgs(values, 'unknown flag: --$flag');
    }
    if (index + 1 >= args.length) {
      return _ParsedArgs(values, 'missing value for --$flag');
    }
    values[flag] = args[index + 1];
    index += 2;
  }

  return _ParsedArgs(values, null);
}
