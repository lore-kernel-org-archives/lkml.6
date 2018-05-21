Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1344077-1526937719-2-13884766136945567078
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES unknown, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526937718; b=KZ+M87lIbtEcC2HK3lcuMVFD2pBQykMygqCdAgOr3XdJ8jCBcl
    Qn58oUrUBu3CmRqHRZ1YKDj3LeDWeVtjcrNvLixGVj+iKU6jQFz4hC/Vj8FmyWP9
    bJXc0fru7v6VzEHU/SMWcxqwCxyPgyTfgnBHIqOEUB1NpDi6E84W6DJ5a1ihcpJ+
    9kJMz47BYlNCUDQeDfNjn0H/b9pKqK5ZsppnfZABd1B+keHvKZvOfp2qJNxAZo2z
    E47+sUpyVYnsBJebDXiCk7HZzwlrruJZLx7F7BCN/2ScDC8i7C01/Lm1t+uBszXG
    QGtj1rtfBuug93w5hAI07HLYHptMRF24bUEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1526937718; bh=OaMMoKZ47izfvbHc/7tbUVfhtOMjyn
    Zvm7Fy/YjAb0s=; b=Pbgnp/ath87EMXqY5xyE2xpS3Bn9hVLuUePTF8Rjp2GncP
    0rJY6VH0MS7HpnnrgMnOiqgAcN8Enbv2ggJvO9Lx0rQlzkjNJHd3RNAPA4n7qGgM
    NZCHSEJiuV4OZ1/tGPQ7LJU+ToQYAybK8hNRC7r5QKTu071gaFXG0FNWC6vVfbzE
    X2KyjqK3gLyzBS8g9hhNXw6yGH4RLS02i1V3hxb14VWSN3ywWzO10MoeHAB0lAFh
    r2835cEXDZFPloRAYDsiBMxckuSHvXmlxKUxPm07Wj8qPQifcNakMW2WX74H06iC
    vrmvgwCP6d9rkhS/XuqbouzJcxO7Yg/khKq8XMhw==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=zZLkj9d8 x-bits=1024 x-keytype=rsa
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
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=zZLkj9d8 x-bits=1024 x-keytype=rsa
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
X-CM-Envelope: MS4wfCMH8nFnJEeGmMFZhvZp/ZTdJOthO/uec3DNwRvqcjTE5DuuVkowPVYPV7G0145vcEA4sH+E2E0kz3jF5f5n6IKdXN+rU0SCSP92Y/Js4b/fmG5JABhn
    V5zWT1nrTGssy2xR727I8wXX0Mm2Wwnh6rKEDjQgb1CPi3yNbwMqUyCUFE+K0gGDZzF3F1VHXQnjg5qh26aVk0WBdWFxQOZ8mxwdOrm6C/u24DgECM8t215l
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=zd2uoN0lAAAA:8 a=ag1SF4gXAAAA:8 a=t04PoXa8hJHlejHJIY4A:9
    a=RDnl8STWzRyePB1t:21 a=ekcrdkrbgBxVkTtc:21 a=QEXdDO2ut3YA:10
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754139AbeEUVV4 (ORCPT <rfc822;greg@kroah.com>);
        Mon, 21 May 2018 17:21:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:36864 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754107AbeEUVVy (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 21 May 2018 17:21:54 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tom Lendacky <thomas.lendacky@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 4.14 94/95] KVM: SVM: Implement VIRT_SPEC_CTRL support for SSBD
Date: Mon, 21 May 2018 23:12:24 +0200
Message-Id: <20180521210503.476603046@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180521210447.219380974@linuxfoundation.org>
References: <20180521210447.219380974@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tom Lendacky <thomas.lendacky@amd.com>

commit bc226f07dcd3c9ef0b7f6236fe356ea4a9cb4769 upstream

Expose the new virtualized architectural mechanism, VIRT_SSBD, for using
speculative store bypass disable (SSBD) under SVM.  This will allow guests
to use SSBD on hardware that uses non-architectural mechanisms for enabling
SSBD.

[ tglx: Folded the migration fixup from Paolo Bonzini ]

Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/include/asm/kvm_host.h |    2 +-
 arch/x86/kernel/cpu/common.c    |    3 ++-
 arch/x86/kvm/cpuid.c            |   11 +++++++++--
 arch/x86/kvm/svm.c              |   21 +++++++++++++++++++--
 arch/x86/kvm/vmx.c              |   18 +++++++++++++++---
 arch/x86/kvm/x86.c              |   13 ++++---------
 6 files changed, 50 insertions(+), 18 deletions(-)

--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -908,7 +908,7 @@ struct kvm_x86_ops {
 	int (*hardware_setup)(void);               /* __init */
 	void (*hardware_unsetup)(void);            /* __exit */
 	bool (*cpu_has_accelerated_tpr)(void);
-	bool (*cpu_has_high_real_mode_segbase)(void);
+	bool (*has_emulated_msr)(int index);
 	void (*cpuid_update)(struct kvm_vcpu *vcpu);
 
 	int (*vm_init)(struct kvm *kvm);
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -743,7 +743,8 @@ static void init_speculation_control(str
 	if (cpu_has(c, X86_FEATURE_INTEL_STIBP))
 		set_cpu_cap(c, X86_FEATURE_STIBP);
 
-	if (cpu_has(c, X86_FEATURE_SPEC_CTRL_SSBD))
+	if (cpu_has(c, X86_FEATURE_SPEC_CTRL_SSBD) ||
+	    cpu_has(c, X86_FEATURE_VIRT_SSBD))
 		set_cpu_cap(c, X86_FEATURE_SSBD);
 
 	if (cpu_has(c, X86_FEATURE_AMD_IBRS)) {
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -367,7 +367,7 @@ static inline int __do_cpuid_ent(struct
 
 	/* cpuid 0x80000008.ebx */
 	const u32 kvm_cpuid_8000_0008_ebx_x86_features =
-		F(AMD_IBPB) | F(AMD_IBRS);
+		F(AMD_IBPB) | F(AMD_IBRS) | F(VIRT_SSBD);
 
 	/* cpuid 0xC0000001.edx */
 	const u32 kvm_cpuid_C000_0001_edx_x86_features =
@@ -632,13 +632,20 @@ static inline int __do_cpuid_ent(struct
 			g_phys_as = phys_as;
 		entry->eax = g_phys_as | (virt_as << 8);
 		entry->edx = 0;
-		/* IBRS and IBPB aren't necessarily present in hardware cpuid */
+		/*
+		 * IBRS, IBPB and VIRT_SSBD aren't necessarily present in
+		 * hardware cpuid
+		 */
 		if (boot_cpu_has(X86_FEATURE_AMD_IBPB))
 			entry->ebx |= F(AMD_IBPB);
 		if (boot_cpu_has(X86_FEATURE_AMD_IBRS))
 			entry->ebx |= F(AMD_IBRS);
+		if (boot_cpu_has(X86_FEATURE_VIRT_SSBD))
+			entry->ebx |= F(VIRT_SSBD);
 		entry->ebx &= kvm_cpuid_8000_0008_ebx_x86_features;
 		cpuid_mask(&entry->ebx, CPUID_8000_0008_EBX);
+		if (boot_cpu_has(X86_FEATURE_LS_CFG_SSBD))
+			entry->ebx |= F(VIRT_SSBD);
 		break;
 	}
 	case 0x80000019:
--- a/arch/x86/kvm/svm.c
+++ b/arch/x86/kvm/svm.c
@@ -3630,6 +3630,13 @@ static int svm_get_msr(struct kvm_vcpu *
 
 		msr_info->data = svm->spec_ctrl;
 		break;
+	case MSR_AMD64_VIRT_SPEC_CTRL:
+		if (!msr_info->host_initiated &&
+		    !guest_cpuid_has(vcpu, X86_FEATURE_VIRT_SSBD))
+			return 1;
+
+		msr_info->data = svm->virt_spec_ctrl;
+		break;
 	case MSR_IA32_UCODE_REV:
 		msr_info->data = 0x01000065;
 		break;
@@ -3764,6 +3771,16 @@ static int svm_set_msr(struct kvm_vcpu *
 			break;
 		set_msr_interception(svm->msrpm, MSR_IA32_PRED_CMD, 0, 1);
 		break;
+	case MSR_AMD64_VIRT_SPEC_CTRL:
+		if (!msr->host_initiated &&
+		    !guest_cpuid_has(vcpu, X86_FEATURE_VIRT_SSBD))
+			return 1;
+
+		if (data & ~SPEC_CTRL_SSBD)
+			return 1;
+
+		svm->virt_spec_ctrl = data;
+		break;
 	case MSR_STAR:
 		svm->vmcb->save.star = data;
 		break;
@@ -5249,7 +5266,7 @@ static bool svm_cpu_has_accelerated_tpr(
 	return false;
 }
 
-static bool svm_has_high_real_mode_segbase(void)
+static bool svm_has_emulated_msr(int index)
 {
 	return true;
 }
@@ -5556,7 +5573,7 @@ static struct kvm_x86_ops svm_x86_ops __
 	.hardware_enable = svm_hardware_enable,
 	.hardware_disable = svm_hardware_disable,
 	.cpu_has_accelerated_tpr = svm_cpu_has_accelerated_tpr,
-	.cpu_has_high_real_mode_segbase = svm_has_high_real_mode_segbase,
+	.has_emulated_msr = svm_has_emulated_msr,
 
 	.vcpu_create = svm_create_vcpu,
 	.vcpu_free = svm_free_vcpu,
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -9214,9 +9214,21 @@ static void vmx_handle_external_intr(str
 }
 STACK_FRAME_NON_STANDARD(vmx_handle_external_intr);
 
-static bool vmx_has_high_real_mode_segbase(void)
+static bool vmx_has_emulated_msr(int index)
 {
-	return enable_unrestricted_guest || emulate_invalid_guest_state;
+	switch (index) {
+	case MSR_IA32_SMBASE:
+		/*
+		 * We cannot do SMM unless we can run the guest in big
+		 * real mode.
+		 */
+		return enable_unrestricted_guest || emulate_invalid_guest_state;
+	case MSR_AMD64_VIRT_SPEC_CTRL:
+		/* This is AMD only.  */
+		return false;
+	default:
+		return true;
+	}
 }
 
 static bool vmx_mpx_supported(void)
@@ -12178,7 +12190,7 @@ static struct kvm_x86_ops vmx_x86_ops __
 	.hardware_enable = hardware_enable,
 	.hardware_disable = hardware_disable,
 	.cpu_has_accelerated_tpr = report_flexpriority,
-	.cpu_has_high_real_mode_segbase = vmx_has_high_real_mode_segbase,
+	.has_emulated_msr = vmx_has_emulated_msr,
 
 	.vcpu_create = vmx_create_vcpu,
 	.vcpu_free = vmx_free_vcpu,
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -1036,6 +1036,7 @@ static u32 emulated_msrs[] = {
 	MSR_IA32_SMBASE,
 	MSR_PLATFORM_INFO,
 	MSR_MISC_FEATURES_ENABLES,
+	MSR_AMD64_VIRT_SPEC_CTRL,
 };
 
 static unsigned num_emulated_msrs;
@@ -2721,7 +2722,7 @@ int kvm_vm_ioctl_check_extension(struct
 		 * fringe case that is not enabled except via specific settings
 		 * of the module parameters.
 		 */
-		r = kvm_x86_ops->cpu_has_high_real_mode_segbase();
+		r = kvm_x86_ops->has_emulated_msr(MSR_IA32_SMBASE);
 		break;
 	case KVM_CAP_VAPIC:
 		r = !kvm_x86_ops->cpu_has_accelerated_tpr();
@@ -4324,14 +4325,8 @@ static void kvm_init_msr_list(void)
 	num_msrs_to_save = j;
 
 	for (i = j = 0; i < ARRAY_SIZE(emulated_msrs); i++) {
-		switch (emulated_msrs[i]) {
-		case MSR_IA32_SMBASE:
-			if (!kvm_x86_ops->cpu_has_high_real_mode_segbase())
-				continue;
-			break;
-		default:
-			break;
-		}
+		if (!kvm_x86_ops->has_emulated_msr(emulated_msrs[i]))
+			continue;
 
 		if (j < i)
 			emulated_msrs[j] = emulated_msrs[i];
