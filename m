Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAA92FC6120
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 18:01:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75B62205F4
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 18:01:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75B62205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731728AbeG3ThP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 15:37:15 -0400
Received: from terminus.zytor.com ([198.137.202.136]:38359 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728919AbeG3ThP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 15:37:15 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w6UI0xTu2394930
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 30 Jul 2018 11:00:59 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w6UI0t212394927;
        Mon, 30 Jul 2018 11:00:55 -0700
Date:   Mon, 30 Jul 2018 11:00:55 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Yi Wang <tipbot@zytor.com>
Message-ID: <tip-843c408905010fbc44a564d2de6a3cd68d986abf@git.kernel.org>
Cc:     jiang.biao2@zte.com.cn, tglx@linutronix.de, rostedt@goodmis.org,
        mingo@kernel.org, hpa@zytor.com, wang.yi59@zte.com.cn,
        linux-kernel@vger.kernel.org
Reply-To: linux-kernel@vger.kernel.org, mingo@kernel.org, hpa@zytor.com,
          wang.yi59@zte.com.cn, tglx@linutronix.de, rostedt@goodmis.org,
          jiang.biao2@zte.com.cn
In-Reply-To: <1532672103-32250-1-git-send-email-wang.yi59@zte.com.cn>
References: <1532672103-32250-1-git-send-email-wang.yi59@zte.com.cn>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/apic] x86/apic: Trivial coding style fixes
Git-Commit-ID: 843c408905010fbc44a564d2de6a3cd68d986abf
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

Commit-ID:  843c408905010fbc44a564d2de6a3cd68d986abf
Gitweb:     https://git.kernel.org/tip/843c408905010fbc44a564d2de6a3cd68d986abf
Author:     Yi Wang <wang.yi59@zte.com.cn>
AuthorDate: Fri, 27 Jul 2018 14:15:03 +0800
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Mon, 30 Jul 2018 19:56:30 +0200

x86/apic: Trivial coding style fixes

There is inconsistent indenting in calibrate_APIC_clock() and
activate_managed(). Remove the surplus TAB.

Signed-off-by: Yi Wang <wang.yi59@zte.com.cn>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Jiang Biao <jiang.biao2@zte.com.cn>
Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Cc: hpa@zytor.com
Cc: douly.fnst@cn.fujitsu.com
Cc: jgross@suse.com
Cc: ville.syrjala@linux.intel.com
Cc: len.brown@intel.com
Cc: gregkh@linuxfoundation.org
Cc: zhong.weidong@zte.com.cn
Link: https://lkml.kernel.org/r/1532672103-32250-1-git-send-email-wang.yi59@zte.com.cn

---
 arch/x86/kernel/apic/apic.c   | 2 +-
 arch/x86/kernel/apic/vector.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index 2aabd4cb0e3f..00011bc33263 100644
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -937,7 +937,7 @@ static int __init calibrate_APIC_clock(void)
 
 	if (levt->features & CLOCK_EVT_FEAT_DUMMY) {
 		pr_warning("APIC timer disabled due to verification failure\n");
-			return -1;
+		return -1;
 	}
 
 	return 0;
diff --git a/arch/x86/kernel/apic/vector.c b/arch/x86/kernel/apic/vector.c
index a75de0792942..c943499375c3 100644
--- a/arch/x86/kernel/apic/vector.c
+++ b/arch/x86/kernel/apic/vector.c
@@ -415,7 +415,7 @@ static int activate_managed(struct irq_data *irqd)
 		pr_err("Managed startup irq %u, no vector available\n",
 		       irqd->irq);
 	}
-       return ret;
+	return ret;
 }
 
 static int x86_vector_activate(struct irq_domain *dom, struct irq_data *irqd,
