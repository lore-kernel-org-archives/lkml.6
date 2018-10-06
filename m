Return-Path: <SRS0=izC1=MS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F2F3C65C31
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 13:07:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E21C321486
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 13:07:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E21C321486
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727993AbeJFUK5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Oct 2018 16:10:57 -0400
Received: from terminus.zytor.com ([198.137.202.136]:57027 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727147AbeJFUK5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Oct 2018 16:10:57 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w96D6seG3551613
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 6 Oct 2018 06:06:54 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w96D6rNN3551609;
        Sat, 6 Oct 2018 06:06:53 -0700
Date:   Sat, 6 Oct 2018 06:06:53 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Baoquan He <tipbot@zytor.com>
Message-ID: <tip-06d4a462e954756f3d3d54e6f3f1bdc2e6f592a9@git.kernel.org>
Cc:     peterz@infradead.org, luto@kernel.org, dvlasenk@redhat.com,
        tglx@linutronix.de, bhe@redhat.com, luto@amacapital.net,
        torvalds@linux-foundation.org, bp@alien8.de, hpa@zytor.com,
        linux-kernel@vger.kernel.org, mingo@kernel.org,
        dave.hansen@linux.intel.com, brgerst@gmail.com, riel@surriel.com
Reply-To: tglx@linutronix.de, bhe@redhat.com, dvlasenk@redhat.com,
          luto@kernel.org, peterz@infradead.org,
          torvalds@linux-foundation.org, luto@amacapital.net, bp@alien8.de,
          hpa@zytor.com, riel@surriel.com, brgerst@gmail.com,
          dave.hansen@linux.intel.com, mingo@kernel.org,
          linux-kernel@vger.kernel.org
In-Reply-To: <20181006084327.27467-2-bhe@redhat.com>
References: <20181006084327.27467-2-bhe@redhat.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/mm] x86/KASLR: Update KERNEL_IMAGE_SIZE description
Git-Commit-ID: 06d4a462e954756f3d3d54e6f3f1bdc2e6f592a9
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  06d4a462e954756f3d3d54e6f3f1bdc2e6f592a9
Gitweb:     https://git.kernel.org/tip/06d4a462e954756f3d3d54e6f3f1bdc2e6f592a9
Author:     Baoquan He <bhe@redhat.com>
AuthorDate: Sat, 6 Oct 2018 16:43:25 +0800
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Sat, 6 Oct 2018 14:46:46 +0200

x86/KASLR: Update KERNEL_IMAGE_SIZE description

Currently CONFIG_RANDOMIZE_BASE=y is set by default, which makes some of the
old comments above the KERNEL_IMAGE_SIZE definition out of date. Update them
to the current state of affairs.

Signed-off-by: Baoquan He <bhe@redhat.com>
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Denys Vlasenko <dvlasenk@redhat.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Rik van Riel <riel@surriel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: corbet@lwn.net
Cc: linux-doc@vger.kernel.org
Cc: thgarnie@google.com
Link: http://lkml.kernel.org/r/20181006084327.27467-2-bhe@redhat.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/include/asm/page_64_types.h | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/page_64_types.h b/arch/x86/include/asm/page_64_types.h
index 6afac386a434..cd0cf1c568b4 100644
--- a/arch/x86/include/asm/page_64_types.h
+++ b/arch/x86/include/asm/page_64_types.h
@@ -59,13 +59,16 @@
 #endif
 
 /*
- * Kernel image size is limited to 1GiB due to the fixmap living in the
- * next 1GiB (see level2_kernel_pgt in arch/x86/kernel/head_64.S). Use
- * 512MiB by default, leaving 1.5GiB for modules once the page tables
- * are fully set up. If kernel ASLR is configured, it can extend the
- * kernel page table mapping, reducing the size of the modules area.
+ * Maximum kernel image size is limited to 1 GiB, due to the fixmap living
+ * in the next 1 GiB (see level2_kernel_pgt in arch/x86/kernel/head_64.S).
+ *
+ * On KASLR use 1 GiB by default, leaving 1 GiB for modules once the
+ * page tables are fully set up.
+ *
+ * If KASLR is disabled we can shrink it to 0.5 GiB and increase the size
+ * of the modules area to 1.5 GiB.
  */
-#if defined(CONFIG_RANDOMIZE_BASE)
+#ifdef CONFIG_RANDOMIZE_BASE
 #define KERNEL_IMAGE_SIZE	(1024 * 1024 * 1024)
 #else
 #define KERNEL_IMAGE_SIZE	(512 * 1024 * 1024)
