# node js will destroy the python version comp
# install docker. 
# by bash deploy the container from dockerfile with ubuntu node python npm via conda?
# push volume with test caces and deply container once
# it's your ho,ework for tii keskki and till tors
# https://docs.docker.com/engine/reference/builder/#:~:text=A%20Dockerfile%20is%20a%20text,can%20use%20in%20a%20Dockerfile%20.
# https://hub.docker.com/_/node/
# https://robotframework-browser.org/#examples 
# and CONDA

https://ww1.microchip.com/downloads/en/Appnotes/ENT-AN1078-4.3_VPPD-04445.pdf
https://www.cisco.com/c/en/us/td/docs/switches/metro/me1200/ucs_controller/guide/b_ucs_controller_book/b_nid_controller_book_chapter_01111.pdf
https://support.huawei.com/enterprise/en/doc/EDOC1000178168/846ee4fb/optional-configuring-association-between-erps-and-ethernet-cfm
https://www.juniper.net/documentation/us/en/software/junos/high-availability/topics/concept/interfaces-understanding-ethernet-ring-protection-switching-functionality.html


Ports in hybrid mode allow for changing the port type, that is, whether a frame's VLAN tag is used to classify the frame on ingress to a particular VLAN, and if so, which TPID it reacts on. Likewise, on egress, the Port Type determines the TPID of the tag, if a tag is required.

Unaware:
On ingress, all frames, whether carrying a VLAN tag or not, get classified to the Port VLAN, and possible tags are not removed on egress.

C-Port:
On ingress, frames with a VLAN tag with TPID = 0x8100 get classified to the VLAN ID embedded in the tag.
If a frame is untagged or priority tagged, the frame gets classified to the Port VLAN.
If frames must be tagged on egress, they will be tagged with a C-tag.

S-Port:
On egress, if frames must be tagged, they will be tagged with an S-tag.
On ingress, frames with a VLAN tag with TPID = 0x88A8 get classified to the VLAN ID embedded in the tag.
Priority-tagged frames are classified to the Port VLAN.
If the port is configured to accept Tagged Only frames (see Ingress Acceptance below), frames without this TPID are dropped.
S-Custom-Port:
On egress, if frames must be tagged, they will be tagged with the custom S-tag.
On ingress, frames with a VLAN tag with a TPID equal to the Ethertype configured for Custom-S ports get classified to the VLAN ID embedded in the tag.
Priority-tagged frames are classified to the Port VLAN.
If the port is configured to accept Tagged Only frames (see Ingress Acceptance below), frames without this TPID are dropped.