require mrfioc2,2.2.0-rc4
require recsync,1.3.0
#require evr-timestamp-buffer,2.5.0
# require evrseq,master
#require evrseq,0.1.0
#require pva2pva,1.0.0

epicsEnvSet("TOP", "$(E3_CMD_TOP)")
#epicsEnvSet("RECSYNC_CMD_TOP", "$(TOP)/../../e3/e3-recsync/cmds")
#iocshLoad("$(RECSYNC_CMD_TOP)/recsync.cmd", "IOC=$(SYS)-$(DEVICE)")

#epicsEnvSet("EVRSEQ_CMD_TOP", "$(E3_MODULES)/e3-evrseq/ics-evr-seq-dev/iocBoot/iocevrseqcalc")
#epicsEnvSet("EVRSEQ_DB_TOP", "$(E3_MODULES)/e3-evrseq/ics-evr-seq-dev/evrseqcalcApp/Db")

mrmEvrSetupPCI("$(EVR)", $(PCI_SLOT))
#dbLoadRecords("evr-pcie-300dc-ess.db","EVR=$(EVR),SYS=$(SYS),D=$(DEVICE),FEVT=88.0525,PINITSEQ=0")

#iocshLoad("$(evr-timestamp-buffer_DIR)/evr-timestamp-buffer.iocsh", "CHIC_SYS=$(CHIC_SYS), CHOP_DRV=$(CHOP_DRV), SYS=$(SYS), DEVICE=$(CHIC_DEV):")

#dbLoadTemplate("/opt/epics/modules/esschic/nicklasholmberg2/db/esschicTimestampBuffer.substitutions", "CHIC_SYS=$(CHIC_SYS), CHOP_DRV=$(CHOP_DRV), SYS=$(SYS), DEVICE=$(CHIC_DEV):")

# Load the sequencer configuration script
#iocshLoad("$(evrseq_DIR)/evrseq.iocsh", "DEV1=$(CHOP_DRV)01:, DEV2=$(CHOP_DRV)02:, DEV3=$(CHOP_DRV)03:, DEV4=$(CHOP_DRV)04:, SYS_EVRSEQ=$(CHIC_SYS), EVR_EVRSEQ=$(CHIC_DEV):, NCG_SYS=$(NCG_SYS), NCG_DRV=$(NCG_DRV)")

# The amount of time which the EVR will wait for the 1PPS event before going into error state.
var(evrMrmTimeNSOverflowThreshold, 1000000)

