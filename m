Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1340521-1526938487-2-10961549737623953996
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES enca, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526938486; b=CC5L1QWyEf2yHCq12ZzSWJ+zcEN1oRLpSlftV2p15T3+NyI+x0
    +qPVWXK9O11vJgeD4oF+8elHXD3xNQGUQQ5LcIXUuhrb7ZiukZ/+v7u0QAm0DRMA
    uOx+sXEmE2RWWKT+jYHYCSLAU+KaICdy6djRYdPwS5JNgu62wnEHJ6jZhxOlrxK1
    +ntwXS16oUMeeTDKr6irLWA60G2WPWl+u0ZNUSUZwrsYtcngFwQ2r2ZDuFrUPbjN
    p2H5EXmJIM8Ed8kPEDwgsuaN7ZHdUOQ62SdK1frTDuUFqVXnr8zTO9UaHoUrHyyf
    bwSYNfOBs7to5p45OlhkxJIYt6kfgxW2iNqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1526938486; bh=aKEDdmY6wJ5jRgizRyNznSwLx0ApwX
    D3hdEhThh993g=; b=G24akcf481mgAgVTIh845bmIaK0f6G6w6Pavt/cTTC3vl4
    TVyaRwnCnz63QENylE+/ujibcVxJHxD04QXzI4r1Wme3V7KrPW50aa7ts7NRAGFL
    fIjtOqHamB1wnp+rS8d/r8u7bYvSvl16sd/byalNfZPMvbO0M6ic0w5dBJFxPGXK
    fmvDfjTEan+1m0w4fizNb05mk2t+APOwtwz27sU66gO+75ugCQPPEP749gx3ug0Z
    PyJBuB2u4hekjxYPukOVfZ25T1riqrleoKg28svWQ2qXGsX1JKCXTZpaVx/9wsq3
    kS9Rxsw+kkEEJFCg4RgBof/unoGQOxsc/PV3ZD8w==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=BiTvmA+w x-bits=1024 x-keytype=rsa
    x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
    header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linuxfoundation.org header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=BiTvmA+w x-bits=1024 x-keytype=rsa
      x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
      header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linuxfoundation.org header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfLcpvmFfFHOxVQPqKIJ8sSVVb15emRe6XThUqZIjnalU8H4YLLMYm4AjufS2LQ6iFo1FciPCxViMDN/NAgqXeqaZGhj+lVTJeEDCcDysnpCB9D9FLs0p
    3GgIItLS/XWuUaVqWBpwItYahgTdC1LoMvUbhKcQf+g1Lgu/yjnfV3jCYl7+V4ArNGeWViOgfA3865P6R51L+TcHZbzwnPaupoDwo3+b3SasXLEhrimUqeo8
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=yPCof4ZbAAAA:8 a=ag1SF4gXAAAA:8 a=ycGjzKPvSfXpTGXK1o0A:9 a=QEXdDO2ut3YA:10
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754564AbeEUVed (ORCPT <rfc822;greg@kroah.com>);
        Mon, 21 May 2018 17:34:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:40770 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754331AbeEUVZ4 (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 21 May 2018 17:25:56 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 4.16 087/110] x86/bugs: Rename _RDS to _SSBD
Date: Mon, 21 May 2018 23:12:24 +0200
Message-Id: <20180521210513.813247802@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180521210503.823249477@linuxfoundation.org>
References: <20180521210503.823249477@linuxfoundation.org>
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

From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>

commit 9f65fb29374ee37856dbad847b4e121aab72b510 upstream

Intel collateral will reference the SSB mitigation bit in IA32_SPEC_CTL[2]
as SSBD (Speculative Store Bypass Disable).

Hence changing it.

It is unclear yet what the MSR_IA32_ARCH_CAPABILITIES (0x10a) Bit(4) name
is going to be. Following the rename it would be SSBD_NO but that rolls out
to Speculative Store Bypass Disable No.

Also fixed the missing space in X86_FEATURE_AMD_SSBD.

[ tglx: Fixup x86_amd_rds_enable() and rds_tif_to_amd_ls_cfg() as well ]

Signed-off-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/include/asm/cpufeatures.h |    4 ++--
 arch/x86/include/asm/msr-index.h   |   10 +++++-----
 arch/x86/include/asm/spec-ctrl.h   |   12 ++++++------
 arch/x86/include/asm/thread_info.h |    6 +++---
 arch/x86/kernel/cpu/amd.c          |   14 +++++++-------
 arch/x86/kernel/cpu/bugs.c         |   36 ++++++++++++++++++------------------
 arch/x86/kernel/cpu/common.c       |    2 +-
 arch/x86/kernel/cpu/intel.c        |    2 +-
 arch/x86/kernel/process.c          |    8 ++++----
 arch/x86/kvm/cpuid.c               |    2 +-
 arch/x86/kvm/vmx.c                 |    6 +++---
 11 files changed, 51 insertions(+), 51 deletions(-)

--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -215,7 +215,7 @@
 #define X86_FEATURE_USE_IBPB		( 7*32+21) /* "" Indirect Branch Prediction Barrier enabled */
 #define X86_FEATURE_USE_IBRS_FW		( 7*32+22) /* "" Use IBRS during runtime firmware calls */
 #define X86_FEATURE_SPEC_STORE_BYPASS_DISABLE	( 7*32+23) /* "" Disable Speculative Store Bypass. */
-#define X86_FEATURE_AMD_RDS		(7*32+24)  /* "" AMD RDS implementation */
+#define X86_FEATURE_AMD_SSBD		( 7*32+24)  /* "" AMD SSBD implementation */
 
 /* Virtualization flags: Linux defined, word 8 */
 #define X86_FEATURE_TPR_SHADOW		( 8*32+ 0) /* Intel TPR Shadow */
@@ -335,7 +335,7 @@
 #define X86_FEATURE_SPEC_CTRL		(18*32+26) /* "" Speculation Control (IBRS + IBPB) */
 #define X86_FEATURE_INTEL_STIBP		(18*32+27) /* "" Single Thread Indirect Branch Predictors */
 #define X86_FEATURE_ARCH_CAPABILITIES	(18*32+29) /* IA32_ARCH_CAPABILITIES MSR (Intel) */
-#define X86_FEATURE_RDS			(18*32+31) /* Reduced Data Speculation */
+#define X86_FEATURE_SSBD		(18*32+31) /* Speculative Store Bypass Disable */
 
 /*
  * BUG word(s)
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -42,8 +42,8 @@
 #define MSR_IA32_SPEC_CTRL		0x00000048 /* Speculation Control */
 #define SPEC_CTRL_IBRS			(1 << 0)   /* Indirect Branch Restricted Speculation */
 #define SPEC_CTRL_STIBP			(1 << 1)   /* Single Thread Indirect Branch Predictors */
-#define SPEC_CTRL_RDS_SHIFT		2	   /* Reduced Data Speculation bit */
-#define SPEC_CTRL_RDS			(1 << SPEC_CTRL_RDS_SHIFT)   /* Reduced Data Speculation */
+#define SPEC_CTRL_SSBD_SHIFT		2	   /* Speculative Store Bypass Disable bit */
+#define SPEC_CTRL_SSBD			(1 << SPEC_CTRL_SSBD_SHIFT)   /* Speculative Store Bypass Disable */
 
 #define MSR_IA32_PRED_CMD		0x00000049 /* Prediction Command */
 #define PRED_CMD_IBPB			(1 << 0)   /* Indirect Branch Prediction Barrier */
@@ -70,10 +70,10 @@
 #define MSR_IA32_ARCH_CAPABILITIES	0x0000010a
 #define ARCH_CAP_RDCL_NO		(1 << 0)   /* Not susceptible to Meltdown */
 #define ARCH_CAP_IBRS_ALL		(1 << 1)   /* Enhanced IBRS support */
-#define ARCH_CAP_RDS_NO			(1 << 4)   /*
+#define ARCH_CAP_SSBD_NO		(1 << 4)   /*
 						    * Not susceptible to Speculative Store Bypass
-						    * attack, so no Reduced Data Speculation control
-						    * required.
+						    * attack, so no Speculative Store Bypass
+						    * control required.
 						    */
 
 #define MSR_IA32_BBL_CR_CTL		0x00000119
--- a/arch/x86/include/asm/spec-ctrl.h
+++ b/arch/x86/include/asm/spec-ctrl.h
@@ -17,20 +17,20 @@ extern void x86_spec_ctrl_restore_host(u
 
 /* AMD specific Speculative Store Bypass MSR data */
 extern u64 x86_amd_ls_cfg_base;
-extern u64 x86_amd_ls_cfg_rds_mask;
+extern u64 x86_amd_ls_cfg_ssbd_mask;
 
 /* The Intel SPEC CTRL MSR base value cache */
 extern u64 x86_spec_ctrl_base;
 
-static inline u64 rds_tif_to_spec_ctrl(u64 tifn)
+static inline u64 ssbd_tif_to_spec_ctrl(u64 tifn)
 {
-	BUILD_BUG_ON(TIF_RDS < SPEC_CTRL_RDS_SHIFT);
-	return (tifn & _TIF_RDS) >> (TIF_RDS - SPEC_CTRL_RDS_SHIFT);
+	BUILD_BUG_ON(TIF_SSBD < SPEC_CTRL_SSBD_SHIFT);
+	return (tifn & _TIF_SSBD) >> (TIF_SSBD - SPEC_CTRL_SSBD_SHIFT);
 }
 
-static inline u64 rds_tif_to_amd_ls_cfg(u64 tifn)
+static inline u64 ssbd_tif_to_amd_ls_cfg(u64 tifn)
 {
-	return (tifn & _TIF_RDS) ? x86_amd_ls_cfg_rds_mask : 0ULL;
+	return (tifn & _TIF_SSBD) ? x86_amd_ls_cfg_ssbd_mask : 0ULL;
 }
 
 extern void speculative_store_bypass_update(void);
--- a/arch/x86/include/asm/thread_info.h
+++ b/arch/x86/include/asm/thread_info.h
@@ -79,7 +79,7 @@ struct thread_info {
 #define TIF_SIGPENDING		2	/* signal pending */
 #define TIF_NEED_RESCHED	3	/* rescheduling necessary */
 #define TIF_SINGLESTEP		4	/* reenable singlestep on user return*/
-#define TIF_RDS			5	/* Reduced data speculation */
+#define TIF_SSBD			5	/* Reduced data speculation */
 #define TIF_SYSCALL_EMU		6	/* syscall emulation active */
 #define TIF_SYSCALL_AUDIT	7	/* syscall auditing active */
 #define TIF_SECCOMP		8	/* secure computing */
@@ -106,7 +106,7 @@ struct thread_info {
 #define _TIF_SIGPENDING		(1 << TIF_SIGPENDING)
 #define _TIF_NEED_RESCHED	(1 << TIF_NEED_RESCHED)
 #define _TIF_SINGLESTEP		(1 << TIF_SINGLESTEP)
-#define _TIF_RDS		(1 << TIF_RDS)
+#define _TIF_SSBD		(1 << TIF_SSBD)
 #define _TIF_SYSCALL_EMU	(1 << TIF_SYSCALL_EMU)
 #define _TIF_SYSCALL_AUDIT	(1 << TIF_SYSCALL_AUDIT)
 #define _TIF_SECCOMP		(1 << TIF_SECCOMP)
@@ -146,7 +146,7 @@ struct thread_info {
 
 /* flags to check in __switch_to() */
 #define _TIF_WORK_CTXSW							\
-	(_TIF_IO_BITMAP|_TIF_NOCPUID|_TIF_NOTSC|_TIF_BLOCKSTEP|_TIF_RDS)
+	(_TIF_IO_BITMAP|_TIF_NOCPUID|_TIF_NOTSC|_TIF_BLOCKSTEP|_TIF_SSBD)
 
 #define _TIF_WORK_CTXSW_PREV (_TIF_WORK_CTXSW|_TIF_USER_RETURN_NOTIFY)
 #define _TIF_WORK_CTXSW_NEXT (_TIF_WORK_CTXSW)
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -567,12 +567,12 @@ static void bsp_init_amd(struct cpuinfo_
 		}
 		/*
 		 * Try to cache the base value so further operations can
-		 * avoid RMW. If that faults, do not enable RDS.
+		 * avoid RMW. If that faults, do not enable SSBD.
 		 */
 		if (!rdmsrl_safe(MSR_AMD64_LS_CFG, &x86_amd_ls_cfg_base)) {
-			setup_force_cpu_cap(X86_FEATURE_RDS);
-			setup_force_cpu_cap(X86_FEATURE_AMD_RDS);
-			x86_amd_ls_cfg_rds_mask = 1ULL << bit;
+			setup_force_cpu_cap(X86_FEATURE_SSBD);
+			setup_force_cpu_cap(X86_FEATURE_AMD_SSBD);
+			x86_amd_ls_cfg_ssbd_mask = 1ULL << bit;
 		}
 	}
 }
@@ -920,9 +920,9 @@ static void init_amd(struct cpuinfo_x86
 	if (!cpu_has(c, X86_FEATURE_XENPV))
 		set_cpu_bug(c, X86_BUG_SYSRET_SS_ATTRS);
 
-	if (boot_cpu_has(X86_FEATURE_AMD_RDS)) {
-		set_cpu_cap(c, X86_FEATURE_RDS);
-		set_cpu_cap(c, X86_FEATURE_AMD_RDS);
+	if (boot_cpu_has(X86_FEATURE_AMD_SSBD)) {
+		set_cpu_cap(c, X86_FEATURE_SSBD);
+		set_cpu_cap(c, X86_FEATURE_AMD_SSBD);
 	}
 }
 
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -45,10 +45,10 @@ static u64 __ro_after_init x86_spec_ctrl
 
 /*
  * AMD specific MSR info for Speculative Store Bypass control.
- * x86_amd_ls_cfg_rds_mask is initialized in identify_boot_cpu().
+ * x86_amd_ls_cfg_ssbd_mask is initialized in identify_boot_cpu().
  */
 u64 __ro_after_init x86_amd_ls_cfg_base;
-u64 __ro_after_init x86_amd_ls_cfg_rds_mask;
+u64 __ro_after_init x86_amd_ls_cfg_ssbd_mask;
 
 void __init check_bugs(void)
 {
@@ -146,7 +146,7 @@ u64 x86_spec_ctrl_get_default(void)
 	u64 msrval = x86_spec_ctrl_base;
 
 	if (boot_cpu_data.x86_vendor == X86_VENDOR_INTEL)
-		msrval |= rds_tif_to_spec_ctrl(current_thread_info()->flags);
+		msrval |= ssbd_tif_to_spec_ctrl(current_thread_info()->flags);
 	return msrval;
 }
 EXPORT_SYMBOL_GPL(x86_spec_ctrl_get_default);
@@ -159,7 +159,7 @@ void x86_spec_ctrl_set_guest(u64 guest_s
 		return;
 
 	if (boot_cpu_data.x86_vendor == X86_VENDOR_INTEL)
-		host |= rds_tif_to_spec_ctrl(current_thread_info()->flags);
+		host |= ssbd_tif_to_spec_ctrl(current_thread_info()->flags);
 
 	if (host != guest_spec_ctrl)
 		wrmsrl(MSR_IA32_SPEC_CTRL, guest_spec_ctrl);
@@ -174,18 +174,18 @@ void x86_spec_ctrl_restore_host(u64 gues
 		return;
 
 	if (boot_cpu_data.x86_vendor == X86_VENDOR_INTEL)
-		host |= rds_tif_to_spec_ctrl(current_thread_info()->flags);
+		host |= ssbd_tif_to_spec_ctrl(current_thread_info()->flags);
 
 	if (host != guest_spec_ctrl)
 		wrmsrl(MSR_IA32_SPEC_CTRL, host);
 }
 EXPORT_SYMBOL_GPL(x86_spec_ctrl_restore_host);
 
-static void x86_amd_rds_enable(void)
+static void x86_amd_ssb_disable(void)
 {
-	u64 msrval = x86_amd_ls_cfg_base | x86_amd_ls_cfg_rds_mask;
+	u64 msrval = x86_amd_ls_cfg_base | x86_amd_ls_cfg_ssbd_mask;
 
-	if (boot_cpu_has(X86_FEATURE_AMD_RDS))
+	if (boot_cpu_has(X86_FEATURE_AMD_SSBD))
 		wrmsrl(MSR_AMD64_LS_CFG, msrval);
 }
 
@@ -473,7 +473,7 @@ static enum ssb_mitigation_cmd __init __
 	enum ssb_mitigation mode = SPEC_STORE_BYPASS_NONE;
 	enum ssb_mitigation_cmd cmd;
 
-	if (!boot_cpu_has(X86_FEATURE_RDS))
+	if (!boot_cpu_has(X86_FEATURE_SSBD))
 		return mode;
 
 	cmd = ssb_parse_cmdline();
@@ -507,7 +507,7 @@ static enum ssb_mitigation_cmd __init __
 	/*
 	 * We have three CPU feature flags that are in play here:
 	 *  - X86_BUG_SPEC_STORE_BYPASS - CPU is susceptible.
-	 *  - X86_FEATURE_RDS - CPU is able to turn off speculative store bypass
+	 *  - X86_FEATURE_SSBD - CPU is able to turn off speculative store bypass
 	 *  - X86_FEATURE_SPEC_STORE_BYPASS_DISABLE - engage the mitigation
 	 */
 	if (mode == SPEC_STORE_BYPASS_DISABLE) {
@@ -518,12 +518,12 @@ static enum ssb_mitigation_cmd __init __
 		 */
 		switch (boot_cpu_data.x86_vendor) {
 		case X86_VENDOR_INTEL:
-			x86_spec_ctrl_base |= SPEC_CTRL_RDS;
-			x86_spec_ctrl_mask &= ~SPEC_CTRL_RDS;
-			x86_spec_ctrl_set(SPEC_CTRL_RDS);
+			x86_spec_ctrl_base |= SPEC_CTRL_SSBD;
+			x86_spec_ctrl_mask &= ~SPEC_CTRL_SSBD;
+			x86_spec_ctrl_set(SPEC_CTRL_SSBD);
 			break;
 		case X86_VENDOR_AMD:
-			x86_amd_rds_enable();
+			x86_amd_ssb_disable();
 			break;
 		}
 	}
@@ -556,16 +556,16 @@ static int ssb_prctl_set(struct task_str
 		if (task_spec_ssb_force_disable(task))
 			return -EPERM;
 		task_clear_spec_ssb_disable(task);
-		update = test_and_clear_tsk_thread_flag(task, TIF_RDS);
+		update = test_and_clear_tsk_thread_flag(task, TIF_SSBD);
 		break;
 	case PR_SPEC_DISABLE:
 		task_set_spec_ssb_disable(task);
-		update = !test_and_set_tsk_thread_flag(task, TIF_RDS);
+		update = !test_and_set_tsk_thread_flag(task, TIF_SSBD);
 		break;
 	case PR_SPEC_FORCE_DISABLE:
 		task_set_spec_ssb_disable(task);
 		task_set_spec_ssb_force_disable(task);
-		update = !test_and_set_tsk_thread_flag(task, TIF_RDS);
+		update = !test_and_set_tsk_thread_flag(task, TIF_SSBD);
 		break;
 	default:
 		return -ERANGE;
@@ -635,7 +635,7 @@ void x86_spec_ctrl_setup_ap(void)
 		x86_spec_ctrl_set(x86_spec_ctrl_base & ~x86_spec_ctrl_mask);
 
 	if (ssb_mode == SPEC_STORE_BYPASS_DISABLE)
-		x86_amd_rds_enable();
+		x86_amd_ssb_disable();
 }
 
 #ifdef CONFIG_SYSFS
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -950,7 +950,7 @@ static void __init cpu_set_bug_bits(stru
 		rdmsrl(MSR_IA32_ARCH_CAPABILITIES, ia32_cap);
 
 	if (!x86_match_cpu(cpu_no_spec_store_bypass) &&
-	   !(ia32_cap & ARCH_CAP_RDS_NO))
+	   !(ia32_cap & ARCH_CAP_SSBD_NO))
 		setup_force_cpu_bug(X86_BUG_SPEC_STORE_BYPASS);
 
 	if (x86_match_cpu(cpu_no_speculation))
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -189,7 +189,7 @@ static void early_init_intel(struct cpui
 		setup_clear_cpu_cap(X86_FEATURE_STIBP);
 		setup_clear_cpu_cap(X86_FEATURE_SPEC_CTRL);
 		setup_clear_cpu_cap(X86_FEATURE_INTEL_STIBP);
-		setup_clear_cpu_cap(X86_FEATURE_RDS);
+		setup_clear_cpu_cap(X86_FEATURE_SSBD);
 	}
 
 	/*
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -283,11 +283,11 @@ static __always_inline void __speculativ
 {
 	u64 msr;
 
-	if (static_cpu_has(X86_FEATURE_AMD_RDS)) {
-		msr = x86_amd_ls_cfg_base | rds_tif_to_amd_ls_cfg(tifn);
+	if (static_cpu_has(X86_FEATURE_AMD_SSBD)) {
+		msr = x86_amd_ls_cfg_base | ssbd_tif_to_amd_ls_cfg(tifn);
 		wrmsrl(MSR_AMD64_LS_CFG, msr);
 	} else {
-		msr = x86_spec_ctrl_base | rds_tif_to_spec_ctrl(tifn);
+		msr = x86_spec_ctrl_base | ssbd_tif_to_spec_ctrl(tifn);
 		wrmsrl(MSR_IA32_SPEC_CTRL, msr);
 	}
 }
@@ -329,7 +329,7 @@ void __switch_to_xtra(struct task_struct
 	if ((tifp ^ tifn) & _TIF_NOCPUID)
 		set_cpuid_faulting(!!(tifn & _TIF_NOCPUID));
 
-	if ((tifp ^ tifn) & _TIF_RDS)
+	if ((tifp ^ tifn) & _TIF_SSBD)
 		__speculative_store_bypass_update(tifn);
 }
 
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -402,7 +402,7 @@ static inline int __do_cpuid_ent(struct
 
 	/* cpuid 7.0.edx*/
 	const u32 kvm_cpuid_7_0_edx_x86_features =
-		F(AVX512_4VNNIW) | F(AVX512_4FMAPS) | F(SPEC_CTRL) | F(RDS) |
+		F(AVX512_4VNNIW) | F(AVX512_4FMAPS) | F(SPEC_CTRL) | F(SSBD) |
 		F(ARCH_CAPABILITIES);
 
 	/* all calls to cpuid_count() should be made on the same cpu */
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -3277,7 +3277,7 @@ static int vmx_get_msr(struct kvm_vcpu *
 		if (!msr_info->host_initiated &&
 		    !guest_cpuid_has(vcpu, X86_FEATURE_IBRS) &&
 		    !guest_cpuid_has(vcpu, X86_FEATURE_SPEC_CTRL) &&
-		    !guest_cpuid_has(vcpu, X86_FEATURE_RDS))
+		    !guest_cpuid_has(vcpu, X86_FEATURE_SSBD))
 			return 1;
 
 		msr_info->data = to_vmx(vcpu)->spec_ctrl;
@@ -3399,11 +3399,11 @@ static int vmx_set_msr(struct kvm_vcpu *
 		if (!msr_info->host_initiated &&
 		    !guest_cpuid_has(vcpu, X86_FEATURE_IBRS) &&
 		    !guest_cpuid_has(vcpu, X86_FEATURE_SPEC_CTRL) &&
-		    !guest_cpuid_has(vcpu, X86_FEATURE_RDS))
+		    !guest_cpuid_has(vcpu, X86_FEATURE_SSBD))
 			return 1;
 
 		/* The STIBP bit doesn't fault even if it's not advertised */
-		if (data & ~(SPEC_CTRL_IBRS | SPEC_CTRL_STIBP | SPEC_CTRL_RDS))
+		if (data & ~(SPEC_CTRL_IBRS | SPEC_CTRL_STIBP | SPEC_CTRL_SSBD))
 			return 1;
 
 		vmx->spec_ctrl = data;
