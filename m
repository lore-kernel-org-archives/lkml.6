Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1340521-1526937443-2-1414694374180100820
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES ensvro, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526937442; b=dhXfr8A4Mu7aEi94eyFcpIyAMe8FGPTqxSV4dKRc3wsTCWlYua
    EJQkgbnRV7R8EipG13pp+vCxbE1HVdABEqXauv7sIVY4k/HUsLd8chHxmfAm01sY
    lfDoq+W/LxjW4InBjDTSGZNjRpcrL/c5jG/xbA/Vh+ASHi8Z7hYFakGC1HKxi5Ui
    l8JHYyk7hjhh5I6VaeocB3YjSIeYCRQAND5ZvGot94M9SXgq6TAhHVxd+t0+clhV
    f6PZ67GeFjJMx4Kd0dFuxR1oXCkSzMb9NaPegmRxLpAvGJcZpfsNaP83iccY3LQK
    thdFMTBvfItKLtuP9Ag68331DUSe1WqQHETw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1526937442; bh=sc34PKf5zlZ2xfARpNiLHxWbR9EZtt
    pDKyBBKib3PLs=; b=DpZ5SgXnpGi342UblpJfoaReQPVqI+Li7rXEvnUAlcx/OJ
    veI+O8RJp1Gl5cvU/6XPg4u+UORruFyyRBY6Cg1gbh69hcPwrY3IvUPjFRDihVlj
    hxBdcRDALk0N/3Y3eB6h4TvJ9sJlKrGO/nFkQKU/H/ZUSfxg0yXmk0t3QuhFUA1R
    RjZw+qhxKQjjsRn34QC3inrdJg/jMYOVie1RP+ZUfXVW0bj+R0hqhktwPfAc1MYv
    guaCOGn8/MbBiOYV2tVMSsMUNh9uUdrBud4QGiTz/K3dD6yYg0uWe5XMZoCynYP3
    AITZGAtRlKwqQCJ13weG2E/iqS7RqRNI6OKQ7QOw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=1/zWeej3 x-bits=1024 x-keytype=rsa
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
      header.i=@kernel.org header.b=1/zWeej3 x-bits=1024 x-keytype=rsa
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
X-CM-Envelope: MS4wfGq5GVN3f5sqOf/vFb77Dk6iwl3qLuTHmWTlTWJi08UMsT79H/b/Rvs5wqTuNgBPx+QLbwEFAh7tb3Fxc79pBxQkySHUqyCiMBp7UozjrTk0RfzwP+/+
    ZJf5oHAv5KhYdmwq9fywwTih4ylMSmxzrz+NBUGylc8uZKa8g1EJ4i2Aph9s2NMj+DA88apgTR7Dx5aaMm8uUFl2qTtFUTIo86OcmwJk30OG7osclUSLMFRG
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=yPCof4ZbAAAA:8 a=pBOR-ozoAAAA:8 a=ag1SF4gXAAAA:8 a=eUy5aBkwU2Vtkc7FqPQA:9
    a=QEXdDO2ut3YA:10 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753190AbeEUVRS (ORCPT <rfc822;greg@kroah.com>);
        Mon, 21 May 2018 17:17:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:60648 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753166AbeEUVRO (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 21 May 2018 17:17:14 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@suse.de>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        David Woodhouse <dwmw@amazon.co.uk>
Subject: [PATCH 4.9 80/87] x86/speculation: Rework speculative_store_bypass_update()
Date: Mon, 21 May 2018 23:11:56 +0200
Message-Id: <20180521210426.902565725@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180521210420.222671977@linuxfoundation.org>
References: <20180521210420.222671977@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas Gleixner <tglx@linutronix.de>

commit 0270be3e34efb05a88bc4c422572ece038ef3608 upstream

The upcoming support for the virtual SPEC_CTRL MSR on AMD needs to reuse
speculative_store_bypass_update() to avoid code duplication. Add an
argument for supplying a thread info (TIF) value and create a wrapper
speculative_store_bypass_update_current() which is used at the existing
call site.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/include/asm/spec-ctrl.h |    7 ++++++-
 arch/x86/kernel/cpu/bugs.c       |    2 +-
 arch/x86/kernel/process.c        |    4 ++--
 3 files changed, 9 insertions(+), 4 deletions(-)

--- a/arch/x86/include/asm/spec-ctrl.h
+++ b/arch/x86/include/asm/spec-ctrl.h
@@ -42,6 +42,11 @@ extern void speculative_store_bypass_ht_
 static inline void speculative_store_bypass_ht_init(void) { }
 #endif
 
-extern void speculative_store_bypass_update(void);
+extern void speculative_store_bypass_update(unsigned long tif);
+
+static inline void speculative_store_bypass_update_current(void)
+{
+	speculative_store_bypass_update(current_thread_info()->flags);
+}
 
 #endif
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -597,7 +597,7 @@ static int ssb_prctl_set(struct task_str
 	 * mitigation until it is next scheduled.
 	 */
 	if (task == current && update)
-		speculative_store_bypass_update();
+		speculative_store_bypass_update_current();
 
 	return 0;
 }
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -338,10 +338,10 @@ static __always_inline void __speculativ
 		intel_set_ssb_state(tifn);
 }
 
-void speculative_store_bypass_update(void)
+void speculative_store_bypass_update(unsigned long tif)
 {
 	preempt_disable();
-	__speculative_store_bypass_update(current_thread_info()->flags);
+	__speculative_store_bypass_update(tif);
 	preempt_enable();
 }
 
