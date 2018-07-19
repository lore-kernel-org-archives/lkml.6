Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 376D3ECDE5F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 14:55:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D073C20673
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 14:55:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D073C20673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731906AbeGSPie (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 11:38:34 -0400
Received: from terminus.zytor.com ([198.137.202.136]:57635 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731864AbeGSPie (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 11:38:34 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w6JEsuJ62319531
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 19 Jul 2018 07:54:56 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w6JEssUx2319528;
        Thu, 19 Jul 2018 07:54:54 -0700
Date:   Thu, 19 Jul 2018 07:54:54 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Yi Wang <tipbot@zytor.com>
Message-ID: <tip-30587589251a00974115e0815ac316980f48dbb5@git.kernel.org>
Cc:     jiang.biao2@zte.com.cn, mingo@kernel.org, anna-maria@linutronix.de,
        hpa@zytor.com, tglx@linutronix.de, wang.yi59@zte.com.cn,
        linux-kernel@vger.kernel.org
Reply-To: mingo@kernel.org, jiang.biao2@zte.com.cn,
          anna-maria@linutronix.de, wang.yi59@zte.com.cn,
          linux-kernel@vger.kernel.org, tglx@linutronix.de, hpa@zytor.com
In-Reply-To: <1531721337-30284-1-git-send-email-wang.yi59@zte.com.cn>
References: <1531721337-30284-1-git-send-email-wang.yi59@zte.com.cn>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:timers/core] timer: Fix coding style
Git-Commit-ID: 30587589251a00974115e0815ac316980f48dbb5
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

Commit-ID:  30587589251a00974115e0815ac316980f48dbb5
Gitweb:     https://git.kernel.org/tip/30587589251a00974115e0815ac316980f48dbb5
Author:     Yi Wang <wang.yi59@zte.com.cn>
AuthorDate: Mon, 16 Jul 2018 14:08:57 +0800
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 19 Jul 2018 16:52:40 +0200

timer: Fix coding style

The call to wake_up_nohz_cpu() is incorrectly indented. Remove the surplus TAB.

Signed-off-by: Yi Wang <wang.yi59@zte.com.cn>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Jiang Biao <jiang.biao2@zte.com.cn>
Cc: john.stultz@linaro.org
Cc: sboyd@kernel.org
Cc: zhong.weidong@zte.com.cn
CC: Anna-Maria Gleixner <anna-maria@linutronix.de>
Link: https://lkml.kernel.org/r/1531721337-30284-1-git-send-email-wang.yi59@zte.com.cn

---
 kernel/time/timer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index cc2d23e6ff61..baa528a24a73 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -581,7 +581,7 @@ trigger_dyntick_cpu(struct timer_base *base, struct timer_list *timer)
 	 * wheel:
 	 */
 	base->next_expiry = timer->expires;
-		wake_up_nohz_cpu(base->cpu);
+	wake_up_nohz_cpu(base->cpu);
 }
 
 static void
