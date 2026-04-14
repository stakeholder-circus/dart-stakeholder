class FamilySpec {
  const FamilySpec(this.id, this.rendererKey, this.tranche, this.contextKey,
      this.contextValue);

  final String id;
  final String rendererKey;
  final String tranche;
  final String contextKey;
  final String contextValue;

  String get registryId => id.replaceAll('_', '-');
}

const List<String> generatorFamilies = <String>[
  'code_analyzer',
  'data_processing',
  'jargon',
  'metrics',
  'network_activity',
  'system_monitoring',
  'agent_workflows',
  'ai_inference_ops',
  'platform_engineering',
  'supply_chain_security',
  'observability_ai_runtime',
  'delivery_preview_ops',
  'evaluation_and_guardrails',
  'knowledge_retrieval',
  'edge_client_runtime',
  'identity_and_trust',
  'aibom_provenance',
  'agent_boundary_security',
  'embedded_agentic_pipeline',
  'data_governance_compliance',
  'finops_capacity',
  'blockchain_protocol_ops',
  'cross_chain_interop',
  'proof_and_sequencer_ops',
  'hybrid_runtime_ops',
  'capacity_cost_controller',
  'batch_execution_tuner',
  'compiler_maintainer',
  'interop_adapter_engineer',
  'preflight_capacity_planner',
  'simulator_performance_engineer',
  'fhir_profile_generator',
  'smart_launch_oauth',
  'bulk_fhir_population_ops',
  'hl7v2_feed_ops',
  'clinical_workflow_events',
  'dicomweb_imaging_ops',
  'openehr_semantic_record_ops',
  'device_telemetry_clinical',
  'emr_vendor_adapter',
  'ocpp_chargepoint_ops',
  'ocpi_roaming_ops',
  'mcp_a2a_ops',
  'streaming_bus_ops',
  'service_mesh_rpc_ops',
];

const List<FamilySpec> dedicatedFamilies = <FamilySpec>[
  FamilySpec('code_analyzer', 'classic-six.code_analyzer', 'classic-six',
      'analysisFocus', 'code-path-static-review'),
  FamilySpec('data_processing', 'classic-six.data_processing', 'classic-six',
      'dataWindow', 'batch-stream-reconciliation'),
  FamilySpec('jargon', 'classic-six.jargon', 'classic-six', 'languagePolicy',
      'operator-plain-language'),
  FamilySpec('metrics', 'classic-six.metrics', 'classic-six', 'signalBlend',
      'latency-errors-saturation'),
  FamilySpec('network_activity', 'classic-six.network_activity', 'classic-six',
      'transportMix', 'http-rpc-queue'),
  FamilySpec('system_monitoring', 'classic-six.system_monitoring',
      'classic-six', 'telemetryScope', 'host-service-runtime'),
  FamilySpec('agent_workflows', 'modern-core.agent_workflows', 'modern-core',
      'coordinationMode', 'planner-worker-handoff'),
  FamilySpec('platform_engineering', 'modern-core.platform_engineering',
      'modern-core', 'platformSurface', 'delivery-platform-routines'),
  FamilySpec('observability_ai_runtime', 'modern-core.observability_ai_runtime',
      'modern-core', 'runtimeSignals', 'token-latency-judge-mix'),
  FamilySpec('delivery_preview_ops', 'modern-core.delivery_preview_ops',
      'modern-core', 'deliveryGuardrail', 'preview-release-checkpoints'),
  FamilySpec('supply_chain_security', 'modern-core.supply_chain_security',
      'modern-core', 'supplyChainPosture', 'provenance-sbom-signing'),
];

const Map<String, FamilySpec> dedicatedFamilyMap = <String, FamilySpec>{
  'code_analyzer': FamilySpec('code_analyzer', 'classic-six.code_analyzer',
      'classic-six', 'analysisFocus', 'code-path-static-review'),
  'data_processing': FamilySpec(
      'data_processing',
      'classic-six.data_processing',
      'classic-six',
      'dataWindow',
      'batch-stream-reconciliation'),
  'jargon': FamilySpec('jargon', 'classic-six.jargon', 'classic-six',
      'languagePolicy', 'operator-plain-language'),
  'metrics': FamilySpec('metrics', 'classic-six.metrics', 'classic-six',
      'signalBlend', 'latency-errors-saturation'),
  'network_activity': FamilySpec(
      'network_activity',
      'classic-six.network_activity',
      'classic-six',
      'transportMix',
      'http-rpc-queue'),
  'system_monitoring': FamilySpec(
      'system_monitoring',
      'classic-six.system_monitoring',
      'classic-six',
      'telemetryScope',
      'host-service-runtime'),
  'agent_workflows': FamilySpec(
      'agent_workflows',
      'modern-core.agent_workflows',
      'modern-core',
      'coordinationMode',
      'planner-worker-handoff'),
  'platform_engineering': FamilySpec(
      'platform_engineering',
      'modern-core.platform_engineering',
      'modern-core',
      'platformSurface',
      'delivery-platform-routines'),
  'observability_ai_runtime': FamilySpec(
      'observability_ai_runtime',
      'modern-core.observability_ai_runtime',
      'modern-core',
      'runtimeSignals',
      'token-latency-judge-mix'),
  'delivery_preview_ops': FamilySpec(
      'delivery_preview_ops',
      'modern-core.delivery_preview_ops',
      'modern-core',
      'deliveryGuardrail',
      'preview-release-checkpoints'),
  'supply_chain_security': FamilySpec(
      'supply_chain_security',
      'modern-core.supply_chain_security',
      'modern-core',
      'supplyChainPosture',
      'provenance-sbom-signing'),
};

const Map<String, String> fallbackRendererKeys = <String, String>{
  'ai_inference_ops': 'fallback.ai_governance',
  'evaluation_and_guardrails': 'fallback.ai_governance',
  'knowledge_retrieval': 'fallback.ai_governance',
  'edge_client_runtime': 'fallback.ai_governance',
  'identity_and_trust': 'fallback.ai_governance',
  'aibom_provenance': 'fallback.ai_governance',
  'agent_boundary_security': 'fallback.security_blockchain',
  'embedded_agentic_pipeline': 'fallback.security_blockchain',
  'data_governance_compliance': 'fallback.security_blockchain',
  'finops_capacity': 'fallback.security_blockchain',
  'blockchain_protocol_ops': 'fallback.security_blockchain',
  'cross_chain_interop': 'fallback.security_blockchain',
  'proof_and_sequencer_ops': 'fallback.security_blockchain',
  'hybrid_runtime_ops': 'fallback.health_protocol',
  'capacity_cost_controller': 'fallback.health_protocol',
  'batch_execution_tuner': 'fallback.health_protocol',
  'compiler_maintainer': 'fallback.health_protocol',
  'interop_adapter_engineer': 'fallback.health_protocol',
  'preflight_capacity_planner': 'fallback.health_protocol',
  'simulator_performance_engineer': 'fallback.health_protocol',
  'fhir_profile_generator': 'fallback.health_protocol',
  'smart_launch_oauth': 'fallback.health_protocol',
  'bulk_fhir_population_ops': 'fallback.health_protocol',
  'hl7v2_feed_ops': 'fallback.health_protocol',
  'clinical_workflow_events': 'fallback.health_protocol',
  'dicomweb_imaging_ops': 'fallback.health_protocol',
  'openehr_semantic_record_ops': 'fallback.health_protocol',
  'device_telemetry_clinical': 'fallback.health_protocol',
  'emr_vendor_adapter': 'fallback.health_protocol',
  'ocpp_chargepoint_ops': 'fallback.overlay_quantum',
  'ocpi_roaming_ops': 'fallback.overlay_quantum',
  'mcp_a2a_ops': 'fallback.overlay_quantum',
  'streaming_bus_ops': 'fallback.overlay_quantum',
  'service_mesh_rpc_ops': 'fallback.overlay_quantum',
};

const List<String> complexities = <String>['low', 'medium', 'high', 'extreme'];
const List<String> devTypes = <String>[
  'backend',
  'frontend',
  'fullstack',
  'data_science',
  'dev_ops',
  'blockchain',
  'machine_learning',
  'systems_programming',
  'game_development',
  'security',
];
const List<String> jargonLevels = <String>['low', 'medium', 'high', 'extreme'];
const List<String> outputFormats = <String>['text', 'json'];
const List<String> experimentalFlags = <String>[
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
  'experimental-disable-cache',
];
const List<String> experimentalModes = <String>[
  'prompt-versioned',
  'personalized',
  'consumer-session'
];
const List<String> experimentalProviders = <String>[
  'local-demo',
  'openai-compatible',
  'anthropic',
  'openai-consumer',
  'claude-consumer',
];
const List<String> personalizationProfiles = <String>['local-operator'];
const List<String> promptAssets = <String>[
  'stakeholder-live-brief',
  'consumer-replay-brief'
];
