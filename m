Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DDBAC282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 09:05:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 769FA222C0
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 09:05:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391044AbfBMJFn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 04:05:43 -0500
Received: from terminus.zytor.com ([198.137.202.136]:57675 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729595AbfBMJFm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 04:05:42 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x1D959ws198310
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 13 Feb 2019 01:05:09 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x1D957tZ198305;
        Wed, 13 Feb 2019 01:05:07 -0800
Date:   Wed, 13 Feb 2019 01:05:07 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Waiman Long <tipbot@zytor.com>
Message-ID: <tip-030fc443aef663df71cd834331fd8f1ec10c30c0@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, longman@redhat.com,
        keescook@chromium.org, peterz@infradead.org, adobriyan@gmail.com,
        dave@stgolabs.net, tglx@linutronix.de, hpa@zytor.com,
        miklos@szeredi.hu, marc.zyngier@arm.com, david@fromorbit.com,
        akpm@linux-foundation.org, willy@infradead.org,
        rdunlap@infradead.org, mingo@kernel.org, dancol@google.com,
        torvalds@linux-foundation.org
Reply-To: marc.zyngier@arm.com, david@fromorbit.com,
          akpm@linux-foundation.org, willy@infradead.org,
          rdunlap@infradead.org, mingo@kernel.org, dancol@google.com,
          torvalds@linux-foundation.org, dave@stgolabs.net,
          tglx@linutronix.de, hpa@zytor.com, miklos@szeredi.hu,
          keescook@chromium.org, peterz@infradead.org, adobriyan@gmail.com,
          linux-kernel@vger.kernel.org, longman@redhat.com
In-Reply-To: <1549983253-19107-1-git-send-email-longman@redhat.com>
References: <1549983253-19107-1-git-send-email-longman@redhat.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:irq/core] genirq: Add missing documentation for tot_count
Git-Commit-ID: 030fc443aef663df71cd834331fd8f1ec10c30c0
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

Commit-ID:  030fc443aef663df71cd834331fd8f1ec10c30c0
Gitweb:     https://git.kernel.org/tip/030fc443aef663df71cd834331fd8f1ec10c30c0
Author:     Waiman Long <longman@redhat.com>
AuthorDate: Tue, 12 Feb 2019 09:54:13 -0500
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Wed, 13 Feb 2019 08:33:03 +0100

genirq: Add missing documentation for tot_count

Commit:

  1136b0728969 ("genirq: Avoid summation loops for /proc/stat")

adds a new irq_desc::tot_count field, without documenting it.
Add the missing piece of documentation.

Signed-off-by: Waiman Long <longman@redhat.com>
Cc: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Daniel Colascione <dancol@google.com>
Cc: Dave Chinner <david@fromorbit.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Cc: Kees Cook <keescook@chromium.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Randy Dunlap <rdunlap@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/1549983253-19107-1-git-send-email-longman@redhat.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 include/linux/irqdesc.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/irqdesc.h b/include/linux/irqdesc.h
index 875c41b23f20..1d679feff3f6 100644
--- a/include/linux/irqdesc.h
+++ b/include/linux/irqdesc.h
@@ -28,6 +28,7 @@ struct pt_regs;
  * @core_internal_state__do_not_mess_with_it: core internal status information
  * @depth:		disable-depth, for nested irq_disable() calls
  * @wake_depth:		enable depth, for multiple irq_set_irq_wake() callers
+ * @tot_count:		stats field for non-percpu irqs
  * @irq_count:		stats field to detect stalled irqs
  * @last_unhandled:	aging timer for unhandled count
  * @irqs_unhandled:	stats field for spurious unhandled interrupts
