Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35A92C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 16:19:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAB4B2150F
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 16:19:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAB4B2150F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=winterdrache.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727535AbeHXTyl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 15:54:41 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:50031 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726608AbeHXTyl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 15:54:41 -0400
Received: from ninja ([83.135.210.22]) by mrelayeu.kundenserver.de (mreue101
 [212.227.15.183]) with ESMTPSA (Nemesis) id 0M09nw-1ff9tc0J24-00uM7b; Fri, 24
 Aug 2018 18:19:20 +0200
Date:   Fri, 24 Aug 2018 18:19:19 +0200
From:   "Matthias B." <matthias@winterdrache.de>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: How to report kernel panic in 4.4.x
Message-ID: <20180824181919.36e6b3c7@ninja>
In-Reply-To: <20180824155545.GA6066@kroah.com>
References: <20180824142408.6340d052@ninja>
        <20180824125950.GA29673@kroah.com>
        <20180824154344.1c53a68c@ninja>
        <20180824141254.GB31555@kroah.com>
        <20180824163338.4bd9db8f@ninja>
        <20180824155545.GA6066@kroah.com>
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="MP_/f+HxdD2du9b=6mjhmgK7KOy"
X-Provags-ID: V03:K1:2U64HwS84vz+HWe3QwzwCKKw0jnf5aPP/tAnZk68rbSYKaqief5
 VCCVc9ruTnQUxKumIak3Vr446hj+RqAsYf4ISHwjmm+gSa2lWBxFhHUdO1j1eiiVjWWkqqX
 14wvNqhMyCuD9M2X9ilUhxJO3XptM1NQc7FIVV//W/q1XyvA6gWxvGagCX4z5wYeGI7B4mp
 ZiXDcH8/Rd3LZPSdncf0Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:cj7a6/wPUj4=:T8H+bVhJgV3PRrAtn4lfJ7
 s99EgU+ZFnV1ErdnwipF6lC0GGTkuHQYAh412avBwgzLfxNad0kY/W3QdaFCEN2PkjvYOjOZe
 tgkG62DO1ogl7s9OiIWBVMO8mnv/jaj6NmkssWdu7l8hXhBuT85HFhVsvnz5s7Yj9ZDz/82sg
 yHE4lDcJZOIbuG4JhQe/urvEiAX1umRYr3GFehKlbYmypfzTa6KJtgnTpkaaQx2FuB7tvhjVx
 QD9E+vmXKN3CQDYGhy/h+nBIV0cc4D5Q3aFNKwJfBW44aFnU4rWFjdRbJzTQJPiKxfEXyx0Mo
 5rm9W1DtEvZFeM07K9l2Ob69MmFtQhF4CmnphtK7fS9Lm6lroFZL8nXzAc6gHcg7P7Yr1bTNy
 NkYPYkFenyI4la2naAFSLXe+EoSQk7dsH+KhlF7j70LPR3NSWy8lhPIibLNOv5WzsGdh5FdgU
 oATaN+renyTNNbPi4P5sGXjIEMmrJIkN1tS6rP2o5vscOog90RbBH8iJxmCECks8/NZIo7HtJ
 BuoBHJWs8/q7IfoDYqRcIbAcGfgqhMv4s0IRmpDGAFUT+rK2JfzLw+VGmeqeXwzjW5Eq7sJOP
 6uXgT8AC8kHTYHN/ZJHz7aLyfetz61odeG5Kog2YcgKB3inr1EADcH2lcDeKS5MJSDROdDyKG
 NQkBLltjyXYyOZX54BrKjReKAB1fTc6VVQKOd6rkHHHDY0BnScEAZ3TdYIQdFxrLWaSQ=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--MP_/f+HxdD2du9b=6mjhmgK7KOy
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Bisect identified the problem. It's the attached patch. I applied it to
4.4.152 with patch -Rp1 and I'm running the resulting kernel now.

MSB

-- 
For every idiot-proof system there exists at least one system-proof
idiot.


--MP_/f+HxdD2du9b=6mjhmgK7KOy
Content-Type: text/x-patch
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename=0001-x86-mm-pat-Make-set_memory_np-L1TF-safe.patch

From 02ff2769edbce2261e981effbc3c4b98fae4faf0 Mon Sep 17 00:00:00 2001
From: Andi Kleen <ak@linux.intel.com>
Date: Tue, 7 Aug 2018 15:09:39 -0700
Subject: [PATCH] x86/mm/pat: Make set_memory_np() L1TF safe

commit 958f79b9ee55dfaf00c8106ed1c22a2919e0028b upstream

set_memory_np() is used to mark kernel mappings not present, but it has
it's own open coded mechanism which does not have the L1TF protection of
inverting the address bits.

Replace the open coded PTE manipulation with the L1TF protecting low level
PTE routines.

Passes the CPA self test.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
[ dwmw2: Pull in pud_mkhuge() from commit a00cc7d9dd, and pfn_pud() ]
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
[groeck: port to 4.4]
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/include/asm/pgtable.h | 27 +++++++++++++++++++++++++++
 arch/x86/mm/pageattr.c         |  8 ++++----
 2 files changed, 31 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index b5e157c065ae..4de6c282c02a 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -378,12 +378,39 @@ static inline pmd_t pfn_pmd(unsigned long page_nr, pgprot_t pgprot)
 	return __pmd(pfn | massage_pgprot(pgprot));
 }
 
+static inline pud_t pfn_pud(unsigned long page_nr, pgprot_t pgprot)
+{
+	phys_addr_t pfn = page_nr << PAGE_SHIFT;
+	pfn ^= protnone_mask(pgprot_val(pgprot));
+	pfn &= PHYSICAL_PUD_PAGE_MASK;
+	return __pud(pfn | massage_pgprot(pgprot));
+}
+
 static inline pmd_t pmd_mknotpresent(pmd_t pmd)
 {
 	return pfn_pmd(pmd_pfn(pmd),
 		       __pgprot(pmd_flags(pmd) & ~(_PAGE_PRESENT|_PAGE_PROTNONE)));
 }
 
+static inline pud_t pud_set_flags(pud_t pud, pudval_t set)
+{
+	pudval_t v = native_pud_val(pud);
+
+	return __pud(v | set);
+}
+
+static inline pud_t pud_clear_flags(pud_t pud, pudval_t clear)
+{
+	pudval_t v = native_pud_val(pud);
+
+	return __pud(v & ~clear);
+}
+
+static inline pud_t pud_mkhuge(pud_t pud)
+{
+	return pud_set_flags(pud, _PAGE_PSE);
+}
+
 static inline u64 flip_protnone_guard(u64 oldval, u64 val, u64 mask);
 
 static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
diff --git a/arch/x86/mm/pageattr.c b/arch/x86/mm/pageattr.c
index 79377e2a7bcd..27610c2d1821 100644
--- a/arch/x86/mm/pageattr.c
+++ b/arch/x86/mm/pageattr.c
@@ -1006,8 +1006,8 @@ static int populate_pmd(struct cpa_data *cpa,
 
 		pmd = pmd_offset(pud, start);
 
-		set_pmd(pmd, __pmd(cpa->pfn | _PAGE_PSE |
-				   massage_pgprot(pmd_pgprot)));
+		set_pmd(pmd, pmd_mkhuge(pfn_pmd(cpa->pfn,
+					canon_pgprot(pmd_pgprot))));
 
 		start	  += PMD_SIZE;
 		cpa->pfn  += PMD_SIZE;
@@ -1079,8 +1079,8 @@ static int populate_pud(struct cpa_data *cpa, unsigned long start, pgd_t *pgd,
 	 * Map everything starting from the Gb boundary, possibly with 1G pages
 	 */
 	while (end - start >= PUD_SIZE) {
-		set_pud(pud, __pud(cpa->pfn | _PAGE_PSE |
-				   massage_pgprot(pud_pgprot)));
+		set_pud(pud, pud_mkhuge(pfn_pud(cpa->pfn,
+				   canon_pgprot(pud_pgprot))));
 
 		start	  += PUD_SIZE;
 		cpa->pfn  += PUD_SIZE;
-- 
2.14.1


--MP_/f+HxdD2du9b=6mjhmgK7KOy--
