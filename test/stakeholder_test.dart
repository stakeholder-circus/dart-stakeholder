import 'dart:convert';

import 'package:dart_stakeholder/src/runtime.dart';
import 'package:test/test.dart';

void main() {
  final runtime = StakeholderRuntime();
  const dedicatedFamilies = <(String, String, String)>[
    ('code_analyzer', 'analysisFocus', 'classic-six.code_analyzer'),
    ('data_processing', 'dataWindow', 'classic-six.data_processing'),
    ('jargon', 'languagePolicy', 'classic-six.jargon'),
    ('metrics', 'signalBlend', 'classic-six.metrics'),
    ('network_activity', 'transportMix', 'classic-six.network_activity'),
    ('system_monitoring', 'telemetryScope', 'classic-six.system_monitoring'),
    ('agent_workflows', 'coordinationMode', 'modern-core.agent_workflows'),
    (
      'platform_engineering',
      'platformSurface',
      'modern-core.platform_engineering'
    ),
    (
      'observability_ai_runtime',
      'runtimeSignals',
      'modern-core.observability_ai_runtime'
    ),
    (
      'delivery_preview_ops',
      'deliveryGuardrail',
      'modern-core.delivery_preview_ops'
    ),
    (
      'supply_chain_security',
      'supplyChainPosture',
      'modern-core.supply_chain_security'
    ),
  ];

  test('list-values exposes the full registry and dedicated renderer keys', () {
    final result = runtime.run(const ['--list-values']);
    expect(result.exitCode, 0);

    final payload = jsonDecode(result.stdoutText) as Map<String, dynamic>;
    final families = payload['generatorFamilies'] as List<dynamic>;

    expect(families.length, greaterThanOrEqualTo(30));
    expect(
        families.any(
            (item) => (item as Map<String, dynamic>)['id'] == 'code_analyzer'),
        isTrue);
    expect(
        families.any((item) =>
            (item as Map<String, dynamic>)['id'] == 'delivery_preview_ops'),
        isTrue);
    expect(
        families.every((item) =>
            (item as Map<String, dynamic>).containsKey('rendererKey')),
        isTrue);
  });

  for (final tuple in dedicatedFamilies) {
    test('${tuple.$1} emits dedicated metadata', () {
      final result = runtime.run([
        '--focus-family',
        tuple.$1,
        '--output-format',
        'json',
        '--seed',
        'smoke'
      ]);
      expect(result.exitCode, 0);
      final payload = jsonDecode(result.stdoutText) as Map<String, dynamic>;
      final context = payload['context'] as Map<String, dynamic>;
      expect(payload['family'], tuple.$1);
      expect(context[tuple.$2], isNotNull);
      expect(context['rendererKey'], tuple.$3);
    });
  }

  test('deterministic json stays stable for the same seed', () {
    const args = [
      '--focus-family',
      'platform_engineering',
      '--output-format',
      'json',
      '--seed',
      'same-seed'
    ];
    final first = runtime.run(args);
    final second = runtime.run(args);
    expect(first.exitCode, 0);
    expect(first.stdoutText, second.stdoutText);
  });

  test('experimental provider flags fail fast', () {
    final result =
        runtime.run(const ['--experimental-provider', 'openai-compatible']);
    expect(result.exitCode, 1);
    expect(
        result.stderrText,
        contains(
            'experimental-provider is not implemented yet in dart-stakeholder'));
  });

  test('orphan experimental flags fail fast', () {
    final result =
        runtime.run(const ['--experimental-mode', 'consumer-session']);
    expect(result.exitCode, 1);
    expect(result.stderrText,
        contains('experimental flags require --experimental-provider'));
  });
}
