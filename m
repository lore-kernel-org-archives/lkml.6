Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1851310-1525116548-2-17713043008555638371
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525116547; b=ccLmE0+Sy9AHYrZRx/2NBp8d4ZJxjH0yC/c+944X9Gd4v5C/hJ
    21+z9khjIvGClXJ9JgdlGothlaJX1QzHvdOkRuXrFny/adq5K/Ru8y7K3Db+LS37
    yCcsRXjZVHbzOGm3jxQtTjqIES5Lc9aKzz2EuRkOXAaW3hp8hNqNPN4FvsgeibrD
    GyF10c1OwAuKdkVTAIwOSgqDEno/W0vE7q4ry1ZGPV7mMOIjz1dIya8LMd6iA3Cm
    JyRbFXr+QhLCv/z9CH6RqPOTMRTZytNS+omqtwa9mtNTKjjeyfNPeI3GigVee+Zp
    l+4BspUryW5GKccVOBxQdTPrnX/rqEvoS7CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1525116547; bh=7s/yZbhC/ewvCgwhHvoRGZfe/HQeNh
    WZPVHwC3SPJBY=; b=VHOLKZ2iHX8ivGa1N3/Ns8hdnaHqnFtmh+MM9Bi0KA0RGV
    b6kUW2QpEzqSndQmSaA5J61zOS+giYFYcmb9dtkvKiDxaa0yiikjtWQNNtBzCWf5
    8tMrSmG8aYPqba1u3F67yTxNprswF1ig7844YSLawW/I3DD40B2PnOZdmreHCIG1
    UITcdmH/5urX0xylJkX4c3ihLLILgDmcojEgoEwacVroMyjaNVVdsMHo/QVvCSbU
    Z7zhW7Wpqj4WC1HMG+/AMllSL9qRYFWgk7nKNog8Muw5UlCASUyvWiw0vZ21wDZ+
    qkljk9cQmr5jaeaGL8wJT4qqDBsHlVVKkm2yq5ag==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfN0zccVUZ89s8B33SI88rolESBiE8koahMYPK8D4xASqNtCiy4nt05Cr2604tsdJ8gqL3RvjIbx+rS1tEPVa/OkIrjFIbaI8vvfBuje3D8arnHAYzSCq
    jUrv8GRibNzEws9gewzLsFARvHKnpuvrjYzPbznD3/57BVhAOTi/Sbt/yCY41fiJcrerIumFaN7MDOF2Sd5iS2NU3cAmHYIX6OWHIRH7qO9iowljuBl1B423
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=7CQSdrXTAAAA:8 a=VwQbUJbxAAAA:8 a=ag1SF4gXAAAA:8 a=sUeo_GIET71GjhaZEAoA:9
    a=cugtcoHOa1l8TMpP:21 a=lcWPEO7lCqFtsAXG:21 a=QEXdDO2ut3YA:10
    a=a-qgeE7W1pNrGK8U0ZQC:22 a=AjGcO6oz07-iQ99wixmX:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932471AbeD3T3C (ORCPT <rfc822;greg@kroah.com>);
        Mon, 30 Apr 2018 15:29:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:37484 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932466AbeD3T3C (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 30 Apr 2018 15:29:02 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9929E22DCB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Christoffer Dall <cdall@kernel.org>,
        Marc Zyngier <marc.zyngier@arm.com>
Subject: [PATCH 4.16 113/113] arm/arm64: KVM: Add PSCI version selection API
Date: Mon, 30 Apr 2018 12:25:24 -0700
Message-Id: <20180430184019.966346572@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430184015.043892819@linuxfoundation.org>
References: <20180430184015.043892819@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Marc Zyngier <marc.zyngier@arm.com>

commit 85bd0ba1ff9875798fad94218b627ea9f768f3c3 upstream.

Although we've implemented PSCI 0.1, 0.2 and 1.0, we expose either 0.1
or 1.0 to a guest, defaulting to the latest version of the PSCI
implementation that is compatible with the requested version. This is
no different from doing a firmware upgrade on KVM.

But in order to give a chance to hypothetical badly implemented guests
that would have a fit by discovering something other than PSCI 0.2,
let's provide a new API that allows userspace to pick one particular
version of the API.

This is implemented as a new class of "firmware" registers, where
we expose the PSCI version. This allows the PSCI version to be
save/restored as part of a guest migration, and also set to
any supported version if the guest requires it.

Cc: stable@vger.kernel.org #4.16
Reviewed-by: Christoffer Dall <cdall@kernel.org>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 Documentation/virtual/kvm/api.txt      |    9 ++++
 Documentation/virtual/kvm/arm/psci.txt |   30 ++++++++++++++++
 arch/arm/include/asm/kvm_host.h        |    3 +
 arch/arm/include/uapi/asm/kvm.h        |    6 +++
 arch/arm/kvm/guest.c                   |   13 +++++++
 arch/arm64/include/asm/kvm_host.h      |    3 +
 arch/arm64/include/uapi/asm/kvm.h      |    6 +++
 arch/arm64/kvm/guest.c                 |   14 +++++++
 include/kvm/arm_psci.h                 |   16 +++++++-
 virt/kvm/arm/psci.c                    |   60 +++++++++++++++++++++++++++++++++
 10 files changed, 156 insertions(+), 4 deletions(-)

--- a/Documentation/virtual/kvm/api.txt
+++ b/Documentation/virtual/kvm/api.txt
@@ -1960,6 +1960,9 @@ ARM 32-bit VFP control registers have th
 ARM 64-bit FP registers have the following id bit patterns:
   0x4030 0000 0012 0 <regno:12>
 
+ARM firmware pseudo-registers have the following bit pattern:
+  0x4030 0000 0014 <regno:16>
+
 
 arm64 registers are mapped using the lower 32 bits. The upper 16 of
 that is the register group type, or coprocessor number:
@@ -1976,6 +1979,9 @@ arm64 CCSIDR registers are demultiplexed
 arm64 system registers have the following id bit patterns:
   0x6030 0000 0013 <op0:2> <op1:3> <crn:4> <crm:4> <op2:3>
 
+arm64 firmware pseudo-registers have the following bit pattern:
+  0x6030 0000 0014 <regno:16>
+
 
 MIPS registers are mapped using the lower 32 bits.  The upper 16 of that is
 the register group type:
@@ -2510,7 +2516,8 @@ Possible features:
 	  and execute guest code when KVM_RUN is called.
 	- KVM_ARM_VCPU_EL1_32BIT: Starts the CPU in a 32bit mode.
 	  Depends on KVM_CAP_ARM_EL1_32BIT (arm64 only).
-	- KVM_ARM_VCPU_PSCI_0_2: Emulate PSCI v0.2 for the CPU.
+	- KVM_ARM_VCPU_PSCI_0_2: Emulate PSCI v0.2 (or a future revision
+          backward compatible with v0.2) for the CPU.
 	  Depends on KVM_CAP_ARM_PSCI_0_2.
 	- KVM_ARM_VCPU_PMU_V3: Emulate PMUv3 for the CPU.
 	  Depends on KVM_CAP_ARM_PMU_V3.
--- /dev/null
+++ b/Documentation/virtual/kvm/arm/psci.txt
@@ -0,0 +1,30 @@
+KVM implements the PSCI (Power State Coordination Interface)
+specification in order to provide services such as CPU on/off, reset
+and power-off to the guest.
+
+The PSCI specification is regularly updated to provide new features,
+and KVM implements these updates if they make sense from a virtualization
+point of view.
+
+This means that a guest booted on two different versions of KVM can
+observe two different "firmware" revisions. This could cause issues if
+a given guest is tied to a particular PSCI revision (unlikely), or if
+a migration causes a different PSCI version to be exposed out of the
+blue to an unsuspecting guest.
+
+In order to remedy this situation, KVM exposes a set of "firmware
+pseudo-registers" that can be manipulated using the GET/SET_ONE_REG
+interface. These registers can be saved/restored by userspace, and set
+to a convenient value if required.
+
+The following register is defined:
+
+* KVM_REG_ARM_PSCI_VERSION:
+
+  - Only valid if the vcpu has the KVM_ARM_VCPU_PSCI_0_2 feature set
+    (and thus has already been initialized)
+  - Returns the current PSCI version on GET_ONE_REG (defaulting to the
+    highest PSCI version implemented by KVM and compatible with v0.2)
+  - Allows any PSCI version implemented by KVM and compatible with
+    v0.2 to be set with SET_ONE_REG
+  - Affects the whole VM (even if the register view is per-vcpu)
--- a/arch/arm/include/asm/kvm_host.h
+++ b/arch/arm/include/asm/kvm_host.h
@@ -77,6 +77,9 @@ struct kvm_arch {
 	/* Interrupt controller */
 	struct vgic_dist	vgic;
 	int max_vcpus;
+
+	/* Mandated version of PSCI */
+	u32 psci_version;
 };
 
 #define KVM_NR_MEM_OBJS     40
--- a/arch/arm/include/uapi/asm/kvm.h
+++ b/arch/arm/include/uapi/asm/kvm.h
@@ -186,6 +186,12 @@ struct kvm_arch_memory_slot {
 #define KVM_REG_ARM_VFP_FPINST		0x1009
 #define KVM_REG_ARM_VFP_FPINST2		0x100A
 
+/* KVM-as-firmware specific pseudo-registers */
+#define KVM_REG_ARM_FW			(0x0014 << KVM_REG_ARM_COPROC_SHIFT)
+#define KVM_REG_ARM_FW_REG(r)		(KVM_REG_ARM | KVM_REG_SIZE_U64 | \
+					 KVM_REG_ARM_FW | ((r) & 0xffff))
+#define KVM_REG_ARM_PSCI_VERSION	KVM_REG_ARM_FW_REG(0)
+
 /* Device Control API: ARM VGIC */
 #define KVM_DEV_ARM_VGIC_GRP_ADDR	0
 #define KVM_DEV_ARM_VGIC_GRP_DIST_REGS	1
--- a/arch/arm/kvm/guest.c
+++ b/arch/arm/kvm/guest.c
@@ -22,6 +22,7 @@
 #include <linux/module.h>
 #include <linux/vmalloc.h>
 #include <linux/fs.h>
+#include <kvm/arm_psci.h>
 #include <asm/cputype.h>
 #include <linux/uaccess.h>
 #include <asm/kvm.h>
@@ -176,6 +177,7 @@ static unsigned long num_core_regs(void)
 unsigned long kvm_arm_num_regs(struct kvm_vcpu *vcpu)
 {
 	return num_core_regs() + kvm_arm_num_coproc_regs(vcpu)
+		+ kvm_arm_get_fw_num_regs(vcpu)
 		+ NUM_TIMER_REGS;
 }
 
@@ -196,6 +198,11 @@ int kvm_arm_copy_reg_indices(struct kvm_
 		uindices++;
 	}
 
+	ret = kvm_arm_copy_fw_reg_indices(vcpu, uindices);
+	if (ret)
+		return ret;
+	uindices += kvm_arm_get_fw_num_regs(vcpu);
+
 	ret = copy_timer_indices(vcpu, uindices);
 	if (ret)
 		return ret;
@@ -214,6 +221,9 @@ int kvm_arm_get_reg(struct kvm_vcpu *vcp
 	if ((reg->id & KVM_REG_ARM_COPROC_MASK) == KVM_REG_ARM_CORE)
 		return get_core_reg(vcpu, reg);
 
+	if ((reg->id & KVM_REG_ARM_COPROC_MASK) == KVM_REG_ARM_FW)
+		return kvm_arm_get_fw_reg(vcpu, reg);
+
 	if (is_timer_reg(reg->id))
 		return get_timer_reg(vcpu, reg);
 
@@ -230,6 +240,9 @@ int kvm_arm_set_reg(struct kvm_vcpu *vcp
 	if ((reg->id & KVM_REG_ARM_COPROC_MASK) == KVM_REG_ARM_CORE)
 		return set_core_reg(vcpu, reg);
 
+	if ((reg->id & KVM_REG_ARM_COPROC_MASK) == KVM_REG_ARM_FW)
+		return kvm_arm_set_fw_reg(vcpu, reg);
+
 	if (is_timer_reg(reg->id))
 		return set_timer_reg(vcpu, reg);
 
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -75,6 +75,9 @@ struct kvm_arch {
 
 	/* Interrupt controller */
 	struct vgic_dist	vgic;
+
+	/* Mandated version of PSCI */
+	u32 psci_version;
 };
 
 #define KVM_NR_MEM_OBJS     40
--- a/arch/arm64/include/uapi/asm/kvm.h
+++ b/arch/arm64/include/uapi/asm/kvm.h
@@ -206,6 +206,12 @@ struct kvm_arch_memory_slot {
 #define KVM_REG_ARM_TIMER_CNT		ARM64_SYS_REG(3, 3, 14, 3, 2)
 #define KVM_REG_ARM_TIMER_CVAL		ARM64_SYS_REG(3, 3, 14, 0, 2)
 
+/* KVM-as-firmware specific pseudo-registers */
+#define KVM_REG_ARM_FW			(0x0014 << KVM_REG_ARM_COPROC_SHIFT)
+#define KVM_REG_ARM_FW_REG(r)		(KVM_REG_ARM64 | KVM_REG_SIZE_U64 | \
+					 KVM_REG_ARM_FW | ((r) & 0xffff))
+#define KVM_REG_ARM_PSCI_VERSION	KVM_REG_ARM_FW_REG(0)
+
 /* Device Control API: ARM VGIC */
 #define KVM_DEV_ARM_VGIC_GRP_ADDR	0
 #define KVM_DEV_ARM_VGIC_GRP_DIST_REGS	1
--- a/arch/arm64/kvm/guest.c
+++ b/arch/arm64/kvm/guest.c
@@ -25,6 +25,7 @@
 #include <linux/module.h>
 #include <linux/vmalloc.h>
 #include <linux/fs.h>
+#include <kvm/arm_psci.h>
 #include <asm/cputype.h>
 #include <linux/uaccess.h>
 #include <asm/kvm.h>
@@ -205,7 +206,7 @@ static int get_timer_reg(struct kvm_vcpu
 unsigned long kvm_arm_num_regs(struct kvm_vcpu *vcpu)
 {
 	return num_core_regs() + kvm_arm_num_sys_reg_descs(vcpu)
-                + NUM_TIMER_REGS;
+		+ kvm_arm_get_fw_num_regs(vcpu)	+ NUM_TIMER_REGS;
 }
 
 /**
@@ -225,6 +226,11 @@ int kvm_arm_copy_reg_indices(struct kvm_
 		uindices++;
 	}
 
+	ret = kvm_arm_copy_fw_reg_indices(vcpu, uindices);
+	if (ret)
+		return ret;
+	uindices += kvm_arm_get_fw_num_regs(vcpu);
+
 	ret = copy_timer_indices(vcpu, uindices);
 	if (ret)
 		return ret;
@@ -243,6 +249,9 @@ int kvm_arm_get_reg(struct kvm_vcpu *vcp
 	if ((reg->id & KVM_REG_ARM_COPROC_MASK) == KVM_REG_ARM_CORE)
 		return get_core_reg(vcpu, reg);
 
+	if ((reg->id & KVM_REG_ARM_COPROC_MASK) == KVM_REG_ARM_FW)
+		return kvm_arm_get_fw_reg(vcpu, reg);
+
 	if (is_timer_reg(reg->id))
 		return get_timer_reg(vcpu, reg);
 
@@ -259,6 +268,9 @@ int kvm_arm_set_reg(struct kvm_vcpu *vcp
 	if ((reg->id & KVM_REG_ARM_COPROC_MASK) == KVM_REG_ARM_CORE)
 		return set_core_reg(vcpu, reg);
 
+	if ((reg->id & KVM_REG_ARM_COPROC_MASK) == KVM_REG_ARM_FW)
+		return kvm_arm_set_fw_reg(vcpu, reg);
+
 	if (is_timer_reg(reg->id))
 		return set_timer_reg(vcpu, reg);
 
--- a/include/kvm/arm_psci.h
+++ b/include/kvm/arm_psci.h
@@ -37,10 +37,15 @@ static inline int kvm_psci_version(struc
 	 * Our PSCI implementation stays the same across versions from
 	 * v0.2 onward, only adding the few mandatory functions (such
 	 * as FEATURES with 1.0) that are required by newer
-	 * revisions. It is thus safe to return the latest.
+	 * revisions. It is thus safe to return the latest, unless
+	 * userspace has instructed us otherwise.
 	 */
-	if (test_bit(KVM_ARM_VCPU_PSCI_0_2, vcpu->arch.features))
+	if (test_bit(KVM_ARM_VCPU_PSCI_0_2, vcpu->arch.features)) {
+		if (vcpu->kvm->arch.psci_version)
+			return vcpu->kvm->arch.psci_version;
+
 		return KVM_ARM_PSCI_LATEST;
+	}
 
 	return KVM_ARM_PSCI_0_1;
 }
@@ -48,4 +53,11 @@ static inline int kvm_psci_version(struc
 
 int kvm_hvc_call_handler(struct kvm_vcpu *vcpu);
 
+struct kvm_one_reg;
+
+int kvm_arm_get_fw_num_regs(struct kvm_vcpu *vcpu);
+int kvm_arm_copy_fw_reg_indices(struct kvm_vcpu *vcpu, u64 __user *uindices);
+int kvm_arm_get_fw_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg);
+int kvm_arm_set_fw_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg);
+
 #endif /* __KVM_ARM_PSCI_H__ */
--- a/virt/kvm/arm/psci.c
+++ b/virt/kvm/arm/psci.c
@@ -18,6 +18,7 @@
 #include <linux/arm-smccc.h>
 #include <linux/preempt.h>
 #include <linux/kvm_host.h>
+#include <linux/uaccess.h>
 #include <linux/wait.h>
 
 #include <asm/cputype.h>
@@ -427,3 +428,62 @@ int kvm_hvc_call_handler(struct kvm_vcpu
 	smccc_set_retval(vcpu, val, 0, 0, 0);
 	return 1;
 }
+
+int kvm_arm_get_fw_num_regs(struct kvm_vcpu *vcpu)
+{
+	return 1;		/* PSCI version */
+}
+
+int kvm_arm_copy_fw_reg_indices(struct kvm_vcpu *vcpu, u64 __user *uindices)
+{
+	if (put_user(KVM_REG_ARM_PSCI_VERSION, uindices))
+		return -EFAULT;
+
+	return 0;
+}
+
+int kvm_arm_get_fw_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
+{
+	if (reg->id == KVM_REG_ARM_PSCI_VERSION) {
+		void __user *uaddr = (void __user *)(long)reg->addr;
+		u64 val;
+
+		val = kvm_psci_version(vcpu, vcpu->kvm);
+		if (copy_to_user(uaddr, &val, KVM_REG_SIZE(reg->id)))
+			return -EFAULT;
+
+		return 0;
+	}
+
+	return -EINVAL;
+}
+
+int kvm_arm_set_fw_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
+{
+	if (reg->id == KVM_REG_ARM_PSCI_VERSION) {
+		void __user *uaddr = (void __user *)(long)reg->addr;
+		bool wants_02;
+		u64 val;
+
+		if (copy_from_user(&val, uaddr, KVM_REG_SIZE(reg->id)))
+			return -EFAULT;
+
+		wants_02 = test_bit(KVM_ARM_VCPU_PSCI_0_2, vcpu->arch.features);
+
+		switch (val) {
+		case KVM_ARM_PSCI_0_1:
+			if (wants_02)
+				return -EINVAL;
+			vcpu->kvm->arch.psci_version = val;
+			return 0;
+		case KVM_ARM_PSCI_0_2:
+		case KVM_ARM_PSCI_1_0:
+			if (!wants_02)
+				return -EINVAL;
+			vcpu->kvm->arch.psci_version = val;
+			return 0;
+		}
+	}
+
+	return -EINVAL;
+}
