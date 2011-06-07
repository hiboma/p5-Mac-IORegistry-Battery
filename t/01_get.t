use strict;
use warnings;
use Test::More tests => 3;
use_ok 'Mac::IORegistry::Battery';

my $registry = Mac::IORegistry::Battery->_parse(<<'....');
+-o AppleSmartBattery  <class AppleSmartBattery, id 0x100000216, registered, matched, active, busy 0 (1 ms), retain 5>
    {
      "ExternalConnected" = Yes
      "TimeRemaining" = 54
      "InstantTimeToEmpty" = 65535
      "ExternalChargeCapable" = Yes
      "CellVoltage" = (4175,4162,4164,0)
      "PermanentFailureStatus" = 0
      "BatteryInvalidWakeSeconds" = 30
      "AdapterInfo" = 0
      "MaxCapacity" = 6806
      "Voltage" = 12500
      "DesignCycleCount70" = 65535
      "Quick Poll" = No
      "Manufacturer" = "SMP"
      "Location" = 0
      "CurrentCapacity" = 5761
      "LegacyBatteryInfo" = {"Amperage"=2486,"Flags"=7,"Capacity"=6806,"Current"=5761,"Voltage"=12500,"Cycle Count"=46}
      "LatestErrorType" = "Capacity Read Zero"
      "FirmwareSerialNumber" = 37805
      "BatteryInstalled" = Yes
      "CycleCount" = 46
      "DesignCapacity" = 6900
      "AvgTimeToFull" = 54
      "ManufactureDate" = 15928
      "BatterySerialNumber" = "AAAAAAAAAAAAA"
      "PostDischargeWaitSeconds" = 120
      "Temperature" = 3094
      "MaxErr" = 1
      "ManufacturerData" = <aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa>
      "FullyCharged" = No
      "InstantAmperage" = 2465
      "DeviceName" = "bq20z451"
      "IOGeneralInterest" = "IOCommand is not serializable"
      "Amperage" = 2486
      "IsCharging" = Yes
      "DesignCycleCount9C" = 1000
      "PostChargeWaitSeconds" = 120
      "AvgTimeToEmpty" = 65535
    }
....

is_deeply $registry, {
      "ExternalConnected" => "Yes",
      "TimeRemaining" => 54,
      "InstantTimeToEmpty" => 65535,
      "ExternalChargeCapable" => "Yes",
      "CellVoltage" => [4175,4162,4164,0],
      "PermanentFailureStatus" => 0,
      "BatteryInvalidWakeSeconds" => 30,
      "AdapterInfo" => 0,
      "MaxCapacity" => 6806,
      "Voltage" => 12500,
      "DesignCycleCount70" => 65535,
      "Quick Poll" => "No",
      "Manufacturer" => "SMP",
      "Location" => 0,
      "CurrentCapacity" => 5761,
      "LegacyBatteryInfo" => {
          "Amperage"=>2486,
          "Flags"=>7,
          "Capacity"=>6806,
          "Current"=>5761,
          "Voltage"=>12500,
          "Cycle Count"=>46
      },
      "LatestErrorType" => "Capacity Read Zero",
      "FirmwareSerialNumber" => 37805,
      "BatteryInstalled" => "Yes",
      "CycleCount" => 46,
      "DesignCapacity" => 6900,
      "AvgTimeToFull" => 54,
      "ManufactureDate" => 15928,
      "BatterySerialNumber" => "AAAAAAAAAAAAA",
      "PostDischargeWaitSeconds" => 120,
      "Temperature" => 3094,
      "MaxErr" => 1,
      "ManufacturerData" => "<aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa>",
      "FullyCharged" => "No",
      "InstantAmperage" => 2465,
      "DeviceName" => "bq20z451",
      "IOGeneralInterest" => "IOCommand is not serializable",
      "Amperage" => 2486,
      "IsCharging" => "Yes",
      "DesignCycleCount9C" => 1000,
      "PostChargeWaitSeconds" => 120,
      "AvgTimeToEmpty" => 65535,
};


isa_ok Mac::IORegistry::Battery->get, 'HASH';
