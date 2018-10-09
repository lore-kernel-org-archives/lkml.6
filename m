Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43B89C64EAD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 05:55:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0C8920835
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 05:55:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0C8920835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726483AbeJINK3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 09:10:29 -0400
Received: from terminus.zytor.com ([198.137.202.136]:39435 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725828AbeJINK3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 09:10:29 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w995sod5916930
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 8 Oct 2018 22:54:50 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w995snNZ916926;
        Mon, 8 Oct 2018 22:54:49 -0700
Date:   Mon, 8 Oct 2018 22:54:49 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Geert Uytterhoeven <tipbot@zytor.com>
Message-ID: <tip-b8d62f33b7b225935649ab165d901fe8dd7f95e5@git.kernel.org>
Cc:     mingo@kernel.org, trivial@kernel.org,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        geert+renesas@glider.be, hpa@zytor.com, peterz@infradead.org,
        tglx@linutronix.de
Reply-To: trivial@kernel.org, mingo@kernel.org,
          torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
          geert+renesas@glider.be, hpa@zytor.com, peterz@infradead.org,
          tglx@linutronix.de
In-Reply-To: <20181008111726.26286-1-geert+renesas@glider.be>
References: <20181008111726.26286-1-geert+renesas@glider.be>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:irq/core] genirq: Fix grammar s/an /a /
Git-Commit-ID: b8d62f33b7b225935649ab165d901fe8dd7f95e5
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

Commit-ID:  b8d62f33b7b225935649ab165d901fe8dd7f95e5
Gitweb:     https://git.kernel.org/tip/b8d62f33b7b225935649ab165d901fe8dd7f95e5
Author:     Geert Uytterhoeven <geert+renesas@glider.be>
AuthorDate: Mon, 8 Oct 2018 13:17:26 +0200
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 9 Oct 2018 07:50:41 +0200

genirq: Fix grammar s/an /a /

Fix a grammar mistake in <linux/interrupt.h>.

[ mingo: While at it also fix another similar error in another comment as well. ]

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Jiri Kosina <trivial@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/20181008111726.26286-1-geert%2Brenesas@glider.be
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 include/linux/interrupt.h | 2 +-
 kernel/irq/irqdomain.c    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index eeceac3376fc..1d6711c28271 100644
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -45,7 +45,7 @@
  * IRQF_PERCPU - Interrupt is per cpu
  * IRQF_NOBALANCING - Flag to exclude this interrupt from irq balancing
  * IRQF_IRQPOLL - Interrupt is used for polling (only the interrupt that is
- *                registered first in an shared interrupt is considered for
+ *                registered first in a shared interrupt is considered for
  *                performance reasons)
  * IRQF_ONESHOT - Interrupt is not reenabled after the hardirq handler finished.
  *                Used by threaded interrupts which need to keep the
diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index 3b30a4aeb0db..3366d11c3e02 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -867,7 +867,7 @@ void irq_dispose_mapping(unsigned int virq)
 EXPORT_SYMBOL_GPL(irq_dispose_mapping);
 
 /**
- * irq_find_mapping() - Find a linux irq from an hw irq number.
+ * irq_find_mapping() - Find a linux irq from a hw irq number.
  * @domain: domain owning this hardware interrupt
  * @hwirq: hardware irq number in that domain space
  */
