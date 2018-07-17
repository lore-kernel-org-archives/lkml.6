Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CD41ECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 09:27:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DBAA20C0B
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 09:27:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DBAA20C0B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729719AbeGQJ6t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 05:58:49 -0400
Received: from terminus.zytor.com ([198.137.202.136]:53299 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728883AbeGQJ6t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 05:58:49 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w6H9QgiR1461985
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 17 Jul 2018 02:26:42 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w6H9Qf121461982;
        Tue, 17 Jul 2018 02:26:41 -0700
Date:   Tue, 17 Jul 2018 02:26:41 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Palmer Dabbelt <tipbot@zytor.com>
Message-ID: <tip-2caf412dc46149b8714e0f52c8337e8eda035a83@git.kernel.org>
Cc:     hpa@zytor.com, linux-kernel@vger.kernel.org,
        andrea.parri@amarulasolutions.com, torvalds@linux-foundation.org,
        dlustig@nvidia.com, tglx@linutronix.de, paulmck@linux.vnet.ibm.com,
        mingo@kernel.org, peterz@infradead.org, palmer@sifive.com
Reply-To: linux-kernel@vger.kernel.org, hpa@zytor.com,
          andrea.parri@amarulasolutions.com, torvalds@linux-foundation.org,
          paulmck@linux.vnet.ibm.com, dlustig@nvidia.com,
          tglx@linutronix.de, peterz@infradead.org, palmer@sifive.com,
          mingo@kernel.org
In-Reply-To: <20180716180605.16115-3-paulmck@linux.vnet.ibm.com>
References: <20180716180605.16115-3-paulmck@linux.vnet.ibm.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:locking/core] MAINTAINERS: Add Daniel Lustig as an LKMM
 reviewer
Git-Commit-ID: 2caf412dc46149b8714e0f52c8337e8eda035a83
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

Commit-ID:  2caf412dc46149b8714e0f52c8337e8eda035a83
Gitweb:     https://git.kernel.org/tip/2caf412dc46149b8714e0f52c8337e8eda035a83
Author:     Palmer Dabbelt <palmer@sifive.com>
AuthorDate: Mon, 16 Jul 2018 11:05:54 -0700
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 17 Jul 2018 09:29:32 +0200

MAINTAINERS: Add Daniel Lustig as an LKMM reviewer

Dan runs the RISC-V memory model working group.  I've been forwarding
him LKMM emails that end up in my inbox, but I'm far from an expert in
this stuff.  He requested to be added as a reviewer, which seems sane to
me as it'll take a human out of the loop.

Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Acked-by: Daniel Lustig <dlustig@nvidia.com>
Acked-by: Andrea Parri <andrea.parri@amarulasolutions.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: akiyks@gmail.com
Cc: boqun.feng@gmail.com
Cc: dhowells@redhat.com
Cc: j.alglave@ucl.ac.uk
Cc: linux-arch@vger.kernel.org
Cc: luc.maranget@inria.fr
Cc: npiggin@gmail.com
Cc: parri.andrea@gmail.com
Cc: stern@rowland.harvard.edu
Cc: will.deacon@arm.com
Link: http://lkml.kernel.org/r/20180716180605.16115-3-paulmck@linux.vnet.ibm.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 192d7f73fd01..eb427596f3e0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8316,6 +8316,7 @@ M:	Jade Alglave <j.alglave@ucl.ac.uk>
 M:	Luc Maranget <luc.maranget@inria.fr>
 M:	"Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
 R:	Akira Yokosawa <akiyks@gmail.com>
+R:	Daniel Lustig <dlustig@nvidia.com>
 L:	linux-kernel@vger.kernel.org
 S:	Supported
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git
