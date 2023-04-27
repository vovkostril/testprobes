Ethernet Port Alarm Configuration
This section configures Ethernet port Link, SFP and DDMI alarms.

Ethernet port alarms are not raised if the port is shut down. In case of CEI or Ethernet tributary port alarms are also not raised if the card is not present, HW slot operational alarm is raised instead.

Link alarms
Alarm if the port does not have physical link up.
SFP alarms
Alarm if SFP is missing or has LOS (Loss Of Signal).
DDMI alarms
Alarm if SFP's Digital Diagnostics Monitoring (DDM) value is outside alarm threshold values. The possible monitored parameters are optical input and output powers, temperature, laser bias current and transceiver supply voltage.


#########################################################################################################################################################################################


Non-Ethernet Port Alarm Configuration
This section configures Non-Ethernet tributary port LoS, AIS, RDI and LoF alarms.

Non-Ethernet port alarms are not raised if the port is shut down. If the card is not present, HW slot operational alarm is raised instead.

LoS alarms
Alarm if the port has LoS (Loss of Signal).
AIS alarms
Alarm if the port has AIS (Alarm Indication Signal).
RDI alarms
Alarm if the port has RDI (Remote Defect Indicator).
LoF alarms
Alarm if the port has LoF (Loss of Frame). Only raised if LoS and AIS are not raised.
Buttons

#########################################################################################################################################################################################


MEP Alarm Configuration
This section configures MEP alarms.

MEP alarms
Alarm for all of the following conditions for a MEP instance:
MEP down
SSF fail
TSF fail
Loss of continuity
Remote Defect Indication received
Buttons