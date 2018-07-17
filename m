Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7907CECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 09:31:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C83B20852
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 09:31:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C83B20852
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729689AbeGQKCu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 06:02:50 -0400
Received: from terminus.zytor.com ([198.137.202.136]:44559 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728720AbeGQKCt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 06:02:49 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w6H9UHp61462729
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 17 Jul 2018 02:30:17 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w6H9UGjA1462726;
        Tue, 17 Jul 2018 02:30:16 -0700
Date:   Tue, 17 Jul 2018 02:30:16 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   "tip-bot for Paul E. McKenney" <tipbot@zytor.com>
Message-ID: <tip-70b83069f70d185356beba3202b9d167ee39f051@git.kernel.org>
Cc:     tglx@linutronix.de, stern@rowland.harvard.edu,
        linux-kernel@vger.kernel.org, davem@davemloft.net,
        akiyks@gmail.com, andrea.parri@amarulasolutions.com,
        luc.maranget@inria.fr, boqun.feng@gmail.com, npiggin@gmail.com,
        hpa@zytor.com, paulmck@linux.vnet.ibm.com, dhowells@redhat.com,
        dlustig@nvidia.com, j.alglave@ucl.ac.uk, mingo@kernel.org,
        will.deacon@arm.com, torvalds@linux-foundation.org,
        peterz@infradead.org
Reply-To: andrea.parri@amarulasolutions.com, stern@rowland.harvard.edu,
          linux-kernel@vger.kernel.org, tglx@linutronix.de,
          akiyks@gmail.com, davem@davemloft.net, boqun.feng@gmail.com,
          luc.maranget@inria.fr, npiggin@gmail.com, dhowells@redhat.com,
          dlustig@nvidia.com, paulmck@linux.vnet.ibm.com, hpa@zytor.com,
          torvalds@linux-foundation.org, peterz@infradead.org,
          j.alglave@ucl.ac.uk, mingo@kernel.org, will.deacon@arm.com
In-Reply-To: <20180716180605.16115-9-paulmck@linux.vnet.ibm.com>
References: <20180716180605.16115-9-paulmck@linux.vnet.ibm.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:locking/core] tools/memory-model: Add informal LKMM
 documentation to MAINTAINERS
Git-Commit-ID: 70b83069f70d185356beba3202b9d167ee39f051
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

Commit-ID:  70b83069f70d185356beba3202b9d167ee39f051
Gitweb:     https://git.kernel.org/tip/70b83069f70d185356beba3202b9d167ee39f051
Author:     Paul E. McKenney <paulmck@linux.vnet.ibm.com>
AuthorDate: Mon, 16 Jul 2018 11:06:00 -0700
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 17 Jul 2018 09:30:32 +0200

tools/memory-model: Add informal LKMM documentation to MAINTAINERS

The Linux-kernel memory model has been informal, with a number of
text files documenting it.  It would be good to make sure that these
informal descriptions are kept up to date and/or pruned appropriately.
This commit therefore brings more of those text files into the LKMM
MAINTAINERS file entry.

Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Acked-by: Andrea Parri <andrea.parri@amarulasolutions.com>
Cc: Akira Yokosawa <akiyks@gmail.com>
Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Daniel Lustig <dlustig@nvidia.com>
Cc: David Howells <dhowells@redhat.com>
Cc: David S. Miller <davem@davemloft.net>
Cc: Jade Alglave <j.alglave@ucl.ac.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Luc Maranget <luc.maranget@inria.fr>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Will Deacon <will.deacon@arm.com>
Cc: linux-arch@vger.kernel.org
Cc: parri.andrea@gmail.com
Link: http://lkml.kernel.org/r/20180716180605.16115-9-paulmck@linux.vnet.ibm.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 MAINTAINERS | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index eb427596f3e0..900889a47627 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8318,9 +8318,14 @@ M:	"Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
 R:	Akira Yokosawa <akiyks@gmail.com>
 R:	Daniel Lustig <dlustig@nvidia.com>
 L:	linux-kernel@vger.kernel.org
+L:	linux-arch@vger.kernel.org
 S:	Supported
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git
 F:	tools/memory-model/
+F:	Documentation/atomic_bitops.txt
+F:	Documentation/atomic_t.txt
+F:	Documentation/core-api/atomic_ops.rst
+F:	Documentation/core-api/refcount-vs-atomic.rst
 F:	Documentation/memory-barriers.txt
 
 LINUX SECURITY MODULE (LSM) FRAMEWORK
