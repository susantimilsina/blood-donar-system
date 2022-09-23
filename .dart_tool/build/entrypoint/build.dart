// ignore_for_file: directives_ordering
// ignore_for_file: no_leading_underscores_for_library_prefixes
// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:build_runner_core/build_runner_core.dart' as _i1;
import 'package:source_gen/builder.dart' as _i2;
import 'package:stacked_generator/builder.dart' as _i3;
import 'dart:isolate' as _i4;
import 'package:build_runner/build_runner.dart' as _i5;
import 'dart:io' as _i6;

final _builders = <_i1.BuilderApplication>[
  _i1.apply(r'source_gen:combining_builder', [_i2.combiningBuilder],
      _i1.toNoneByDefault(),
      hideOutput: false, appliesBuilders: const [r'source_gen:part_cleanup']),
  _i1.apply(
      r'stacked_generator:stackedBottomsheetGenerator',
      [_i3.stackedBottomsheetGenerator],
      _i1.toDependentsOf(r'stacked_generator'),
      hideOutput: false),
  _i1.apply(r'stacked_generator:stackedDialogGenerator',
      [_i3.stackedDialogGenerator], _i1.toDependentsOf(r'stacked_generator'),
      hideOutput: false),
  _i1.apply(r'stacked_generator:stackedFormGenerator',
      [_i3.stackedFormGenerator], _i1.toDependentsOf(r'stacked_generator'),
      hideOutput: false),
  _i1.apply(r'stacked_generator:stackedLocatorGenerator',
      [_i3.stackedLocatorGenerator], _i1.toDependentsOf(r'stacked_generator'),
      hideOutput: false),
  _i1.apply(r'stacked_generator:stackedLoggerGenerator',
      [_i3.stackedLoggerGenerator], _i1.toDependentsOf(r'stacked_generator'),
      hideOutput: false),
  _i1.apply(r'stacked_generator:stackedRouterGenerator',
      [_i3.stackedRouterGenerator], _i1.toDependentsOf(r'stacked_generator'),
      hideOutput: false),
  _i1.applyPostProcess(r'source_gen:part_cleanup', _i2.partCleanup)
];
void main(List<String> args, [_i4.SendPort? sendPort]) async {
  var result = await _i5.run(args, _builders);
  sendPort?.send(result);
  _i6.exitCode = result;
}
