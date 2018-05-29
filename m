Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1524644-1527568676-2-3724710313770145966
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-security-module-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527568676; b=G+Wr3Rcp0SEQm7jXv4BbbLnUprSzL0OrEddpbvdh8PSKWOqUNs
    u6fm5fBUi8+Iouq9jmTQQCU9kjnmef72vqodMaa2cz6/Z0U6lsxyLsoEgUgjhm+t
    peN97eQLgXcHsoFBugewbYM8y9Q2HwSPA4tb1JrCqpyr6ZT0ww0yzsc3WYR8Srpi
    xBlFA21MyjzEn4mNaLkSprstge+AlC9Tp27ge7Hzc1rvVn1wm2yI1F+TBLhjwPhq
    1o0SSFyF8KkhYVQwpRSioxvPc3FZ+wsfhLY7OTp6i3Ilj8hAIDqe+1qRhHdvBQGS
    WAQAD57iQ/KpXpYmBnbDGc4F0cv5q7Jxj8wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=fm2; t=1527568676; bh=HXp5KjcmDRuorXVzKFMPJb+v6wNlDv
    dWdIY7hLGH0IE=; b=J7EaAqB879fGPZlWccg9QoLrG2fV4gJ6FxIjuQa4B9Dtpz
    Yjv/iFaVSs+0wHytpRs4EpmRwXh5u/ARrpGmoAo02auVQRKLsiW4Clkz+1E5RnFT
    50p5OYYdA1j3vrs/uwerAwPdp72QFwabm4XB2gN9zhgtgsBjTxBxv9/HaVePFVHM
    /uFG9QUrDoYvvPXwo0Zie1ZI6IUTnxf+DU1sR1Wqmom28vUZbqd4Y3EnIBQufwhy
    h8W5pSFvVk7tHWFYTXM3IvgugQrPT7MV5Y5gTRSuM/O621gBMW9HEbjANUnrh24j
    wDwHXh64zww/bzddf/9EwmNVZdwpG0d+3K+VCGXA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
    header.d=gmail.com header.i=@gmail.com header.b=Pu3dd5/U
    header.a=rsa-sha256 header.s=20161025 x-bits=2048;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=G42u5/Ii;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
      header.d=gmail.com header.i=@gmail.com header.b=Pu3dd5/U
      header.a=rsa-sha256 header.s=20161025 x-bits=2048;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=G42u5/Ii;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfGA8ZoQb9EJHeArTrCpyBCXbp2aTTe8f5w6jvGOp4dlVRX5hq9nYhFLYgc3Ee+sxLaHryqbAQaqq2tpqpcAEaydLPoSu7W960OxKAi4fzhnT2eABeURk
    UmEKZAYOn/vakdUI4tOltzph0UyZoggQoRNoHSK1tijHmmHjUYQp/Jd3L11F06um6LHIhUquuA6dRok75plbKffk8GO+zj5nUoRvQqOR7I2CDP1ZmScrlkBb
    h5UcbyFUrA0R3mykoCqZwA==
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=x7bEGLp0ZPQA:10 a=agizdKYkGd8A:10
    a=VUJBJC2UJ8kA:10 a=VwQbUJbxAAAA:8 a=KIqTInuBrGqwvTLD3ZgA:9
    a=uY3EQQOWOrl2yV5L:21 a=GDRaVY5cxo1hRWR6:21 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752669AbeE2Ehx (ORCPT <rfc822;linux@kroah.com>);
        Tue, 29 May 2018 00:37:53 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:33523 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754541AbeE2Eht (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 29 May 2018 00:37:49 -0400
X-Google-Smtp-Source: AB8JxZoy0suLaDEqoLWpwKH6gGO2lFu3TJ+5+q3zz3aPaUYpBHS2I+Xu7RxwAp0VHPUT8VUal1uw+w==
From: YaoJun <yaojun8558363@gmail.com>
To: kernel-hardening@lists.openwall.com
Cc: linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, jmorris@namei.org
Subject: [PATCH 1/4] migrate swapper_pg_dir
Date: Tue, 29 May 2018 12:37:41 +0800
Message-Id: <20180529043741.27790-1-yaojun8558363@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: owner-linux-security-module@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Currently, __enable_mmu() uses swapper_pg_dir directly.
To migrate swapper_pg_dir, we need to pass it as an
argument to __enable_mmu(). At the same time,
__pa_swapper_pg_dir is introduced to save physical
address of swapper_pg_dir. By changing its value, we
can migrate swapper_pg_dir.

---
 arch/arm64/include/asm/mmu_context.h |  4 +---
 arch/arm64/include/asm/pgtable.h     |  1 +
 arch/arm64/kernel/cpufeature.c       |  2 +-
 arch/arm64/kernel/head.S             | 10 ++++++----
 arch/arm64/kernel/hibernate.c        |  2 +-
 arch/arm64/kernel/sleep.S            |  2 ++
 arch/arm64/mm/kasan_init.c           |  4 ++--
 arch/arm64/mm/mmu.c                  |  8 ++++++--
 8 files changed, 20 insertions(+), 13 deletions(-)

diff --git a/arch/arm64/include/asm/mmu_context.h b/arch/arm64/include/asm/mmu_context.h
index 39ec0b8a689e..3eddb871f251 100644
--- a/arch/arm64/include/asm/mmu_context.h
+++ b/arch/arm64/include/asm/mmu_context.h
@@ -141,14 +141,12 @@ static inline void cpu_install_idmap(void)
  * Atomically replaces the active TTBR1_EL1 PGD with a new VA-compatible PGD,
  * avoiding the possibility of conflicting TLB entries being allocated.
  */
-static inline void cpu_replace_ttbr1(pgd_t *pgdp)
+static inline void cpu_replace_ttbr1(phys_addr_t pgd_phys)
 {
 	typedef void (ttbr_replace_func)(phys_addr_t);
 	extern ttbr_replace_func idmap_cpu_replace_ttbr1;
 	ttbr_replace_func *replace_phys;
 
-	phys_addr_t pgd_phys = virt_to_phys(pgdp);
-
 	replace_phys = (void *)__pa_symbol(idmap_cpu_replace_ttbr1);
 
 	cpu_install_idmap();
diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index 7c4c8f318ba9..14ba344b1af7 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -722,6 +722,7 @@ extern pgd_t swapper_pg_dir[PTRS_PER_PGD];
 extern pgd_t swapper_pg_end[];
 extern pgd_t idmap_pg_dir[PTRS_PER_PGD];
 extern pgd_t tramp_pg_dir[PTRS_PER_PGD];
+extern phys_addr_t __pa_swapper_pg_dir;
 
 /*
  * Encode and decode a swap entry:
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 9d1b06d67c53..5b9448688d80 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -917,7 +917,7 @@ kpti_install_ng_mappings(const struct arm64_cpu_capabilities *__unused)
 	remap_fn = (void *)__pa_symbol(idmap_kpti_install_ng_mappings);
 
 	cpu_install_idmap();
-	remap_fn(cpu, num_online_cpus(), __pa_symbol(swapper_pg_dir));
+	remap_fn(cpu, num_online_cpus(), __pa_swapper_pg_dir);
 	cpu_uninstall_idmap();
 
 	if (!cpu)
diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index b0853069702f..e3bb44b4b6c6 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -706,6 +706,8 @@ secondary_startup:
 	 * Common entry point for secondary CPUs.
 	 */
 	bl	__cpu_setup			// initialise processor
+	adrp    x25, idmap_pg_dir
+	ldr_l   x26, __pa_swapper_pg_dir
 	bl	__enable_mmu
 	ldr	x8, =__secondary_switched
 	br	x8
@@ -761,10 +763,8 @@ ENTRY(__enable_mmu)
 	cmp	x2, #ID_AA64MMFR0_TGRAN_SUPPORTED
 	b.ne	__no_granule_support
 	update_early_cpu_boot_status 0, x1, x2
-	adrp	x1, idmap_pg_dir
-	adrp	x2, swapper_pg_dir
-	phys_to_ttbr x3, x1
-	phys_to_ttbr x4, x2
+	phys_to_ttbr x3, x25
+	phys_to_ttbr x4, x26
 	msr	ttbr0_el1, x3			// load TTBR0
 	msr	ttbr1_el1, x4			// load TTBR1
 	isb
@@ -823,6 +823,8 @@ __primary_switch:
 	mrs	x20, sctlr_el1			// preserve old SCTLR_EL1 value
 #endif
 
+	adrp    x25, idmap_pg_dir
+	adrp    x26, swapper_pg_dir
 	bl	__enable_mmu
 #ifdef CONFIG_RELOCATABLE
 	bl	__relocate_kernel
diff --git a/arch/arm64/kernel/hibernate.c b/arch/arm64/kernel/hibernate.c
index 1ec5f28c39fc..12948949202c 100644
--- a/arch/arm64/kernel/hibernate.c
+++ b/arch/arm64/kernel/hibernate.c
@@ -125,7 +125,7 @@ int arch_hibernation_header_save(void *addr, unsigned int max_size)
 		return -EOVERFLOW;
 
 	arch_hdr_invariants(&hdr->invariants);
-	hdr->ttbr1_el1		= __pa_symbol(swapper_pg_dir);
+	hdr->ttbr1_el1          = __pa_swapper_pg_dir;
 	hdr->reenter_kernel	= _cpu_resume;
 
 	/* We can't use __hyp_get_vectors() because kvm may still be loaded */
diff --git a/arch/arm64/kernel/sleep.S b/arch/arm64/kernel/sleep.S
index bebec8ef9372..860d46395be1 100644
--- a/arch/arm64/kernel/sleep.S
+++ b/arch/arm64/kernel/sleep.S
@@ -101,6 +101,8 @@ ENTRY(cpu_resume)
 	bl	el2_setup		// if in EL2 drop to EL1 cleanly
 	bl	__cpu_setup
 	/* enable the MMU early - so we can access sleep_save_stash by va */
+	adrp    x25, idmap_pg_dir
+	ldr_l   x26, __pa_swapper_pg_dir
 	bl	__enable_mmu
 	ldr	x8, =_cpu_resume
 	br	x8
diff --git a/arch/arm64/mm/kasan_init.c b/arch/arm64/mm/kasan_init.c
index 12145874c02b..dd4f28c19165 100644
--- a/arch/arm64/mm/kasan_init.c
+++ b/arch/arm64/mm/kasan_init.c
@@ -199,7 +199,7 @@ void __init kasan_init(void)
 	 */
 	memcpy(tmp_pg_dir, swapper_pg_dir, sizeof(tmp_pg_dir));
 	dsb(ishst);
-	cpu_replace_ttbr1(lm_alias(tmp_pg_dir));
+	cpu_replace_ttbr1(__pa_symbol(tmp_pg_dir));
 
 	clear_pgds(KASAN_SHADOW_START, KASAN_SHADOW_END);
 
@@ -236,7 +236,7 @@ void __init kasan_init(void)
 			pfn_pte(sym_to_pfn(kasan_zero_page), PAGE_KERNEL_RO));
 
 	memset(kasan_zero_page, 0, PAGE_SIZE);
-	cpu_replace_ttbr1(lm_alias(swapper_pg_dir));
+	cpu_replace_ttbr1(__pa_swapper_pg_dir);
 
 	/* At this point kasan is fully initialized. Enable error messages */
 	init_task.kasan_depth = 0;
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 2dbb2c9f1ec1..41eee333f91a 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -55,6 +55,8 @@ u64 idmap_ptrs_per_pgd = PTRS_PER_PGD;
 u64 kimage_voffset __ro_after_init;
 EXPORT_SYMBOL(kimage_voffset);
 
+phys_addr_t __pa_swapper_pg_dir;
+
 /*
  * Empty_zero_page is a special page that is used for zero-initialized data
  * and COW.
@@ -631,6 +633,8 @@ void __init paging_init(void)
 	phys_addr_t pgd_phys = early_pgtable_alloc();
 	pgd_t *pgdp = pgd_set_fixmap(pgd_phys);
 
+	__pa_swapper_pg_dir = __pa_symbol(swapper_pg_dir);
+
 	map_kernel(pgdp);
 	map_mem(pgdp);
 
@@ -642,9 +646,9 @@ void __init paging_init(void)
 	 *
 	 * To do this we need to go via a temporary pgd.
 	 */
-	cpu_replace_ttbr1(__va(pgd_phys));
+	cpu_replace_ttbr1(pgd_phys);
 	memcpy(swapper_pg_dir, pgdp, PGD_SIZE);
-	cpu_replace_ttbr1(lm_alias(swapper_pg_dir));
+	cpu_replace_ttbr1(__pa_swapper_pg_dir);
 
 	pgd_clear_fixmap();
 	memblock_free(pgd_phys, PAGE_SIZE);
-- 
2.17.0

