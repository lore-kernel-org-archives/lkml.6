Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-601012-1522189266-2-11769916035048962136
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES enrosv,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1522189266; b=EgQRGIDAyJvLlPc5ochULdPkvyAiRAW7j2l092IW+Xvgcf7
    lbCr1orWWvFNITiDRdU+51WzocCaq7rl96xebtyAtcOIDEyZ9oEpaiPXDH6buf4g
    HCac1xsWTrDR9o94lWmrmi1bT5ZLtPWalPqDJy1rUFmmcQxpmXV5ijeC7sug1yiC
    rO8WY9jNzv8pu4Q4zY7d/w5VO/mug6xNYEAb03SHiw4k0cVZoUcibfCMf8GFbpZO
    ocOUsXMSFdjj62t1U6YBSDXgZMXG+/rjqR8fdjgsREJVAPsXVVaPXSfX7scOJRr7
    23IycD+9U92iZZnBz5XQlCCsm/0PUQto8S4Ks7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=arctest; t=1522189266; bh=9cixDC455ZQXfWcBBs6ZGHCSB1
    Zw2mnbUWcGo5fL3Xo=; b=iLPWjoi6xND1BU8K0ObkmIeUS1YI9QqE4Iv0LiAp7x
    nXSM4WGrdy75HZQFG9W3aq+Vnmn/cQFaRorYsRzOJ1h0XtrVn7YQpMMiCzsjJB8H
    0LzswXLTVkA7sFaVVS6Hq5eq0BpbH2Ndd1EYGIH3WxaOBqHKI4PjUyksmFVJNnRG
    LiUVvFhITr70V3t0JZUKCqN1Q3ZADHhVuj7jDy/Fdw/pHh5s13Vv30rpKAWPHRaZ
    T79AdES+awbgAjhqhPT/MFV2tX0ZjDDBL7tMBGb6VCRSUV65SD9NrGwfVCf64X6p
    rWq2n9YmUbD0aPzdfEDlHhRzMN8YtwCyaIMGJQgU/QwQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=hpe.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=hpe.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=hpe.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=hpe.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfCD8BP5/lxcyZnFVZK3gXJurGd8Jhx0mA3tPmLM5EUwZf5wQj/K0Mx9PlK+0QZ+a2Eg/zmrI18Z3f242oC7Ins0276K5tTjLODOMYqihAX046i3gnMwd
    tQJsevMZ7kjcD3r1vc6+c7VkYTqgbpVpAGkFH5d1WddQtDzWxnpo0g4kLG7BWOSuqJt8eVZIR0W3Tm9IfXuSCqLgV9S+3B0HWruMFs7Whr8sW99n7qjUKhN8
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=v2DPQv5-lfwA:10 a=MvuuwTCpAAAA:8
    a=UM4gtxyWFI929_V_TOQA:9 a=dVHiktpip_riXrfdqayU:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752060AbeC0WVD (ORCPT <rfc822;greg@kroah.com>);
        Tue, 27 Mar 2018 18:21:03 -0400
Received: from relay2.sgi.com ([192.48.180.65]:43137 "EHLO relay.sgi.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751913AbeC0WVC (ORCPT <rfc822;stable@vger.kernel.org>);
        Tue, 27 Mar 2018 18:21:02 -0400
From: Andrew Banman <abanman@hpe.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
        x86@kernel.org, Mike Travis <mike.travis@hpe.com>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Russ Anderson <rja@hpe.com>,
        Dimitri Sivanich <sivanich@hpe.com>,
        Andrew Banman <abanman@hpe.com>
Subject: [PATCH] x86/platform/uv/BAU: add APIC idt entry
Date: Tue, 27 Mar 2018 17:09:06 -0500
Message-Id: <1522188546-196177-1-git-send-email-abanman@hpe.com>
X-Mailer: git-send-email 1.8.2.1
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

BAU uses the old alloc_initr_gate method to setup its interrupt. This
fails silently as the BAU vector is in the range of APIC vectors that
are registerted to the spurious interrupt handler. Then BAU broadcasts
are not handled, and the broadcast source CPU hangs.

Fixed by updating BAU to use new idt structure.

Signed-off-by: Andrew Banman <abanman@hpe.com>
Acked-by: Mike Travis <mike.travis@hpe.com>
---
 arch/x86/include/asm/hw_irq.h | 1 +
 arch/x86/kernel/idt.c         | 3 +++
 arch/x86/platform/uv/tlb_uv.c | 2 --
 3 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/hw_irq.h b/arch/x86/include/asm/hw_irq.h
index 6dfe366..a56cd0b 100644
--- a/arch/x86/include/asm/hw_irq.h
+++ b/arch/x86/include/asm/hw_irq.h
@@ -33,6 +33,7 @@
 extern asmlinkage void kvm_posted_intr_nested_ipi(void);
 extern asmlinkage void error_interrupt(void);
 extern asmlinkage void irq_work_interrupt(void);
+extern asmlinkage void uv_bau_message_intr1(void);
 
 extern asmlinkage void spurious_interrupt(void);
 extern asmlinkage void thermal_interrupt(void);
diff --git a/arch/x86/kernel/idt.c b/arch/x86/kernel/idt.c
index 99f93a6..c5da34e 100644
--- a/arch/x86/kernel/idt.c
+++ b/arch/x86/kernel/idt.c
@@ -138,6 +138,9 @@ struct idt_data {
 # ifdef CONFIG_IRQ_WORK
 	INTG(IRQ_WORK_VECTOR,		irq_work_interrupt),
 # endif
+#ifdef CONFIG_X86_UV
+	INTG(UV_BAU_MESSAGE,		uv_bau_message_intr1),
+#endif
 	INTG(SPURIOUS_APIC_VECTOR,	spurious_interrupt),
 	INTG(ERROR_APIC_VECTOR,		error_interrupt),
 #endif
diff --git a/arch/x86/platform/uv/tlb_uv.c b/arch/x86/platform/uv/tlb_uv.c
index f44c0bc..5e22845 100644
--- a/arch/x86/platform/uv/tlb_uv.c
+++ b/arch/x86/platform/uv/tlb_uv.c
@@ -2254,8 +2254,6 @@ static int __init uv_bau_init(void)
 			init_uvhub(uvhub, vector, uv_base_pnode);
 	}
 
-	alloc_intr_gate(vector, uv_bau_message_intr1);
-
 	for_each_possible_blade(uvhub) {
 		if (uv_blade_nr_possible_cpus(uvhub)) {
 			unsigned long val;
-- 
1.8.2.1
