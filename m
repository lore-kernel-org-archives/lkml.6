Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDFADC1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 12:21:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FAF320874
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 12:21:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FAF320874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=telegraphics.com.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754351AbeFTMVy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 08:21:54 -0400
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:36346 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754332AbeFTMVx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 08:21:53 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by kvm5.telegraphics.com.au (Postfix) with ESMTP id 38E8028CDF;
        Wed, 20 Jun 2018 08:21:40 -0400 (EDT)
Date:   Wed, 20 Jun 2018 22:22:28 +1000
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Message-Id: <88af06b9de34d870cb0afc46cfd24e0458be2575.1529471371.git.fthain@telegraphics.com.au>
From:   Finn Thain <fthain@telegraphics.com.au>
Subject: [PATCH RESEND] treewide: Correct "differenciate" and "instanciate" typos
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Also add these typos to spelling.txt so checkpatch.pl will look for them.

Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
---
 Documentation/devicetree/bindings/reserved-memory/reserved-memory.txt | 2 +-
 arch/powerpc/kvm/book3s_pr.c                                          | 2 +-
 arch/powerpc/kvm/book3s_xive.c                                        | 2 +-
 arch/powerpc/platforms/powermac/low_i2c.c                             | 2 +-
 arch/powerpc/sysdev/xive/common.c                                     | 2 +-
 drivers/thermal/intel_powerclamp.c                                    | 2 +-
 scripts/spelling.txt                                                  | 2 ++
 sound/soc/intel/common/sst-dsp-priv.h                                 | 4 ++--
 8 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/reserved-memory/reserved-memory.txt b/Documentation/devicetree/bindings/reserved-memory/reserved-memory.txt
index 16291f2a4688..bac4afa3b197 100644
--- a/Documentation/devicetree/bindings/reserved-memory/reserved-memory.txt
+++ b/Documentation/devicetree/bindings/reserved-memory/reserved-memory.txt
@@ -49,7 +49,7 @@ compatible (optional) - standard definition
     - may contain the following strings:
         - shared-dma-pool: This indicates a region of memory meant to be
           used as a shared pool of DMA buffers for a set of devices. It can
-          be used by an operating system to instanciate the necessary pool
+          be used by an operating system to instantiate the necessary pool
           management subsystem if necessary.
         - vendor specific string in the form <vendor>,[<device>-]<usage>
 no-map (optional) - empty property
diff --git a/arch/powerpc/kvm/book3s_pr.c b/arch/powerpc/kvm/book3s_pr.c
index c3b8006f0eac..e79f10c3e846 100644
--- a/arch/powerpc/kvm/book3s_pr.c
+++ b/arch/powerpc/kvm/book3s_pr.c
@@ -515,7 +515,7 @@ static void kvmppc_set_msr_pr(struct kvm_vcpu *vcpu, u64 msr)
 	/*
 	 * When switching from 32 to 64-bit, we may have a stale 32-bit
 	 * magic page around, we need to flush it. Typically 32-bit magic
-	 * page will be instanciated when calling into RTAS. Note: We
+	 * page will be instantiated when calling into RTAS. Note: We
 	 * assume that such transition only happens while in kernel mode,
 	 * ie, we never transition from user 32-bit to kernel 64-bit with
 	 * a 32-bit magic page around.
diff --git a/arch/powerpc/kvm/book3s_xive.c b/arch/powerpc/kvm/book3s_xive.c
index f9818d7d3381..a7156b8b2fb6 100644
--- a/arch/powerpc/kvm/book3s_xive.c
+++ b/arch/powerpc/kvm/book3s_xive.c
@@ -38,7 +38,7 @@
  * Virtual mode variants of the hcalls for use on radix/radix
  * with AIL. They require the VCPU's VP to be "pushed"
  *
- * We still instanciate them here because we use some of the
+ * We still instantiate them here because we use some of the
  * generated utility functions as well in this file.
  */
 #define XIVE_RUNTIME_CHECKS
diff --git a/arch/powerpc/platforms/powermac/low_i2c.c b/arch/powerpc/platforms/powermac/low_i2c.c
index fa89f30e7f27..d4d411820597 100644
--- a/arch/powerpc/platforms/powermac/low_i2c.c
+++ b/arch/powerpc/platforms/powermac/low_i2c.c
@@ -1192,7 +1192,7 @@ static void pmac_i2c_devscan(void (*callback)(struct device_node *dev,
 		{ NULL, NULL, 0 },
 	};
 
-	/* Only some devices need to have platform functions instanciated
+	/* Only some devices need to have platform functions instantiated
 	 * here. For now, we have a table. Others, like 9554 i2c GPIOs used
 	 * on Xserve, if we ever do a driver for them, will use their own
 	 * platform function instance
diff --git a/arch/powerpc/sysdev/xive/common.c b/arch/powerpc/sysdev/xive/common.c
index 3459015092fa..3ad2167caecc 100644
--- a/arch/powerpc/sysdev/xive/common.c
+++ b/arch/powerpc/sysdev/xive/common.c
@@ -266,7 +266,7 @@ static unsigned int xive_get_irq(void)
 	 * of pending priorities. This will also have the effect of
 	 * updating the CPPR to the most favored pending interrupts.
 	 *
-	 * In the future, if we have a way to differenciate a first
+	 * In the future, if we have a way to differentiate a first
 	 * entry (on HW interrupt) from a replay triggered by EOI,
 	 * we could skip this on replays unless we soft-mask tells us
 	 * that a new HW interrupt occurred.
diff --git a/drivers/thermal/intel_powerclamp.c b/drivers/thermal/intel_powerclamp.c
index 4540e892b61d..cde891c54cde 100644
--- a/drivers/thermal/intel_powerclamp.c
+++ b/drivers/thermal/intel_powerclamp.c
@@ -28,7 +28,7 @@
  *              case of external interrupts without need for ack, clamping down
  *              cpu in non-irq context does not reduce irq. for majority of the
  *              cases, clamping down cpu does help reduce irq as well, we should
- *              be able to differenciate the two cases and give a quantitative
+ *              be able to differentiate the two cases and give a quantitative
  *              solution for the irqs that we can control. perhaps based on
  *              get_cpu_iowait_time_us()
  *
diff --git a/scripts/spelling.txt b/scripts/spelling.txt
index 9a058cff49d4..94e68b71a247 100644
--- a/scripts/spelling.txt
+++ b/scripts/spelling.txt
@@ -400,6 +400,7 @@ didnt||didn't
 diferent||different
 differrence||difference
 diffrent||different
+differenciate||differentiate
 diffrentiate||differentiate
 difinition||definition
 dimesions||dimensions
@@ -624,6 +625,7 @@ initilize||initialize
 inofficial||unofficial
 insititute||institute
 instal||install
+instanciate||instantiate
 instanciated||instantiated
 inteface||interface
 integreated||integrated
diff --git a/sound/soc/intel/common/sst-dsp-priv.h b/sound/soc/intel/common/sst-dsp-priv.h
index 8734040d64d3..363145716a6d 100644
--- a/sound/soc/intel/common/sst-dsp-priv.h
+++ b/sound/soc/intel/common/sst-dsp-priv.h
@@ -153,7 +153,7 @@ struct sst_block_allocator {
 };
 
 /*
- * Runtime Module Instance - A module object can be instanciated multiple
+ * Runtime Module Instance - A module object can be instantiated multiple
  * times within the DSP FW.
  */
 struct sst_module_runtime {
@@ -193,7 +193,7 @@ enum sst_module_state {
  *
  * Each Firmware file can consist of 1..N modules. A module can span multiple
  * ADSP memory blocks. The simplest FW will be a file with 1 module. A module
- * can be instanciated multiple times in the DSP.
+ * can be instantiated multiple times in the DSP.
  */
 struct sst_module {
 	struct sst_dsp *dsp;
-- 
2.16.4

