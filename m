Return-Path: <linux-arch-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3043489-1526217358-2-13737357890031809149
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-arch-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526217358; b=IjCC66z/h8lTpiWO2x39VPaGHAkK4F9iR6xz6r20vBp/+3qW6i
    jitPH1SMSnxf78jNw4cQFp7V6O0Lfa7TVHEe6K8Mkr25ZAeaV7BmG7egNb1xjQQt
    TpDXXF3AJVCWSnrYKrcPeN42YMQGN2ZNcLxAZzfdfW9OiuuxCSw2r7SgEQlxffrj
    kEXMDEg3M+cXcMIzHdFieaABhLqGu3xh+Az1aPp7IJpyBNFcpTl8/9A8FhNsfWxz
    80sgyGknUXdlNGhY9z7vsbHR6/cNZd9pB29kD/MFSaVktBcbnTujQWn9Sz6az93B
    dxs0PtNq5MaHD8fsgbTI63dnMORlg4wOQxlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:message-id:cc:reply-to
    :in-reply-to:references:to:subject:mime-version
    :content-transfer-encoding:content-type:sender:list-id; s=fm2;
    t=1526217358; bh=ErE1q3bEiKfKjPq9euArFPBdbMc6FYyLBn7VkNDUTZk=; b=
    NVPVZ7NkRMQoDFKAXMkfkH9mCi07MCF7pYn5bBxtU1Tg1tPW2JmawxAxeATiISkg
    u2ny1EtYTWxqSF7fVcmun+LRWkum4Nbs0AkvbVLtoPoHkm340hE1gkj0IFMJqwNY
    2HkwoUJXgmmzk7nYPn28foBJfCIUEKmaz9wNaNTJ2IXfsvV2ALEvJ0BjfjQ6Z74v
    cVd5DgV3oc3eYQjPsy3vjFeZ302t51x47qndyg3hH+7CbzBk7NulhTYyincIAgsm
    AfAQqxZ/MN9AIh6E1G8u0YV5h+lZbKnEv1uYTJW/z64czsyd5YpKUEs3XmOq7xor
    pkWU55STAyoiu0iLYBmxjg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=zytor.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-arch-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=zytor.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=zytor.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-arch-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=zytor.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfKD0G9Xtqs6wk2jfFB40Tpzp+cA0Q2z0DIHydUBU5FmXbU6t3xK8d7jYJBD5evkzAFDfkuUee4je4THmUrIr0bP/5tmTWJz1CwrNPDff7hHyyN40suA7
    4Lkkn3xf1J0booRx1YYWcmM5u0M/EhhkDAdkZlMLcq51jZVzNlYPHDzV1Dh1E4oB03N9NjaRuBONDYm1s5ayJhavQ/qv1/5YdkMzQuvkVO8zYBtkcW4AHY8f
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=VwQbUJbxAAAA:8 a=c-n4J4-pAAAA:8 a=oGMlB6cnAAAA:8 a=sxcEz342xCOZEY3UF0IA:9
    a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22 a=L0NDqeB7ZLmQzAogN4cw:22
    a=NdAtdrkLVvyUPsUoGJp4:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751847AbeEMNPz (ORCPT <rfc822;linux@kroah.com>);
        Sun, 13 May 2018 09:15:55 -0400
Received: from terminus.zytor.com ([198.137.202.136]:37631 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751338AbeEMNPy (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 13 May 2018 09:15:54 -0400
Date: Sun, 13 May 2018 06:15:47 -0700
From: tip-bot for Masahiro Yamada <tipbot@zytor.com>
Message-ID: <tip-2a7ffe465769bc15cb4a77f6a71e6f071d644068@git.kernel.org>
Cc: hpa@zytor.com, linux-arch@vger.kernel.org,
        yamada.masahiro@socionext.com, tglx@linutronix.de,
        mingo@kernel.org, linux-kernel@vger.kernel.org
Reply-To: linux-arch@vger.kernel.org, yamada.masahiro@socionext.com,
          hpa@zytor.com, mingo@kernel.org, linux-kernel@vger.kernel.org,
          tglx@linutronix.de
In-Reply-To: <1525852174-29022-1-git-send-email-yamada.masahiro@socionext.com>
References: <1525852174-29022-1-git-send-email-yamada.masahiro@socionext.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/build] x86/build: Remove no-op macro VMLINUX_SYMBOL()
Git-Commit-ID: 2a7ffe465769bc15cb4a77f6a71e6f071d644068
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
X-Mailing-List: linux-arch@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Commit-ID:  2a7ffe465769bc15cb4a77f6a71e6f071d644068
Gitweb:     https://git.kernel.org/tip/2a7ffe465769bc15cb4a77f6a71e6f071d644068
Author:     Masahiro Yamada <yamada.masahiro@socionext.com>
AuthorDate: Wed, 9 May 2018 16:49:34 +0900
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Sun, 13 May 2018 15:11:34 +0200

x86/build: Remove no-op macro VMLINUX_SYMBOL()

VMLINUX_SYMBOL() is no-op unless CONFIG_HAVE_UNDERSCORE_SYMBOL_PREFIX
is defined.  It has ever been selected only by BLACKFIN and METAG.
VMLINUX_SYMBOL() is unneeded for x86-specific code.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-arch <linux-arch@vger.kernel.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Link: https://lkml.kernel.org/r/1525852174-29022-1-git-send-email-yamada.masahiro@socionext.com

---
 arch/x86/kernel/vmlinux.lds.S | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index 795f3a80e576..5e1458f609a1 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -117,11 +117,11 @@ SECTIONS
 
 #ifdef CONFIG_X86_64
 		. = ALIGN(PAGE_SIZE);
-		VMLINUX_SYMBOL(__entry_trampoline_start) = .;
+		__entry_trampoline_start = .;
 		_entry_trampoline = .;
 		*(.entry_trampoline)
 		. = ALIGN(PAGE_SIZE);
-		VMLINUX_SYMBOL(__entry_trampoline_end) = .;
+		__entry_trampoline_end = .;
 		ASSERT(. - _entry_trampoline == PAGE_SIZE, "entry trampoline is too big");
 #endif
 
