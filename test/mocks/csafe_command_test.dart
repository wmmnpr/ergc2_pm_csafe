import 'package:ergc2_pm_csafe/ergc2_pm_csafe.dart';
import 'package:ergc2_pm_csafe/src/csafe/c2proplongsetconfigcommands.dart';
import 'package:test/test.dart';


void main() {
  group('data conversion', () {
    setUp(() {
      // Additional setup goes here.
    });
    test('Csafe command test', () {
      List<CSafeCommand>commandList = [];
      commandList.add(CSafeSetWorkoutType.build());
      commandList.add(CSafeSetWorkoutDuration.build(duration: 2000));
      commandList.add(CSafeSetSplitDuration.build(duration: 500));
      commandList.add(CSafeConfigureWorkout.build());
      commandList.add(CSafeSetScreenState.build());
      CSafeCommandFrame commandFrame = CSafeCommandFrame(commandList);
      IntList buffer = commandFrame.toBytes();
      print(DataConvUtils.intArrayToHex(buffer));
    });
  });

}