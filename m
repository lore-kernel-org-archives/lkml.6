Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6332C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 10:16:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 853BF21471
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 10:16:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 853BF21471
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727421AbeJBQ6y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 12:58:54 -0400
Received: from terminus.zytor.com ([198.137.202.136]:51207 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726611AbeJBQ6y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 12:58:54 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w92AFvWa1917296
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 2 Oct 2018 03:15:57 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w92AFupV1917293;
        Tue, 2 Oct 2018 03:15:56 -0700
Date:   Tue, 2 Oct 2018 03:15:56 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Will Deacon <tipbot@zytor.com>
Message-ID: <tip-6d348925b306ab0cc9757a09a8cea6bf288018e4@git.kernel.org>
Cc:     hpa@zytor.com, will.deacon@arm.com, mingo@kernel.org,
        jason.low2@hpe.com, joe@perches.com, peterz@infradead.org,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de
Reply-To: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
          tglx@linutronix.de, hpa@zytor.com, mingo@kernel.org,
          will.deacon@arm.com, joe@perches.com, jason.low2@hpe.com,
          peterz@infradead.org
In-Reply-To: <20181001142856.GC9716@arm.com>
References: <20181001142856.GC9716@arm.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:locking/urgent] MAINTAINERS: Remove dead path from LOCKING
 PRIMITIVES entry
Git-Commit-ID: 6d348925b306ab0cc9757a09a8cea6bf288018e4
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

Commit-ID:  6d348925b306ab0cc9757a09a8cea6bf288018e4
Gitweb:     https://git.kernel.org/tip/6d348925b306ab0cc9757a09a8cea6bf288018e4
Author:     Will Deacon <will.deacon@arm.com>
AuthorDate: Mon, 1 Oct 2018 15:28:56 +0100
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 2 Oct 2018 10:45:57 +0200

MAINTAINERS: Remove dead path from LOCKING PRIMITIVES entry

Since 890658b7ab48 ("locking/mutex: Kill arch specific code"), there
are no mutex header files under arch/, so we can remove the redundant
entry from MAINTAINERS.

Reported-by: Joe Perches <joe@perches.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Cc: Jason Low <jason.low2@hpe.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/20181001142856.GC9716@arm.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index a255240d1452..3bd8913b2d78 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8598,7 +8598,6 @@ F:	include/linux/spinlock*.h
 F:	arch/*/include/asm/spinlock*.h
 F:	include/linux/rwlock*.h
 F:	include/linux/mutex*.h
-F:	arch/*/include/asm/mutex*.h
 F:	include/linux/rwsem*.h
 F:	arch/*/include/asm/rwsem.h
 F:	include/linux/seqlock.h
