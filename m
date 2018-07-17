Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43E47ECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 09:33:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F305120C0E
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 09:33:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F305120C0E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731259AbeGQKEk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 06:04:40 -0400
Received: from terminus.zytor.com ([198.137.202.136]:38457 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729672AbeGQKEk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 06:04:40 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w6H9WSpr1462956
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 17 Jul 2018 02:32:28 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w6H9WRRJ1462953;
        Tue, 17 Jul 2018 02:32:27 -0700
Date:   Tue, 17 Jul 2018 02:32:27 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Yauheni Kaliuta <tipbot@zytor.com>
Message-ID: <tip-0fcff1715bec7593a0ba86f3fef46cd89af37a8b@git.kernel.org>
Cc:     mingo@kernel.org, peterz@infradead.org, stern@rowland.harvard.edu,
        yauheni.kaliuta@redhat.com, hpa@zytor.com,
        paulmck@linux.vnet.ibm.com, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org
Reply-To: tglx@linutronix.de, torvalds@linux-foundation.org,
          linux-kernel@vger.kernel.org, peterz@infradead.org,
          mingo@kernel.org, paulmck@linux.vnet.ibm.com, hpa@zytor.com,
          yauheni.kaliuta@redhat.com, stern@rowland.harvard.edu
In-Reply-To: <20180716180605.16115-13-paulmck@linux.vnet.ibm.com>
References: <20180716180605.16115-13-paulmck@linux.vnet.ibm.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:locking/core] tools/memory-model/Documentation: Fix typo,
 smb->smp
Git-Commit-ID: 0fcff1715bec7593a0ba86f3fef46cd89af37a8b
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

Commit-ID:  0fcff1715bec7593a0ba86f3fef46cd89af37a8b
Gitweb:     https://git.kernel.org/tip/0fcff1715bec7593a0ba86f3fef46cd89af37a8b
Author:     Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
AuthorDate: Mon, 16 Jul 2018 11:06:04 -0700
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 17 Jul 2018 09:30:35 +0200

tools/memory-model/Documentation: Fix typo, smb->smp

The tools/memory-model/Documentation/explanation.txt file says
"For each other CPU C', smb_wmb() forces all po-earlier stores"
This commit therefore replaces the "smb_wmb()" with "smp_wmb()".

Signed-off-by: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Acked-by: Alan Stern <stern@rowland.harvard.edu>
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
Cc: will.deacon@arm.com
Link: http://lkml.kernel.org/r/20180716180605.16115-13-paulmck@linux.vnet.ibm.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 tools/memory-model/Documentation/explanation.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/memory-model/Documentation/explanation.txt b/tools/memory-model/Documentation/explanation.txt
index 1b09f3175a1f..0cbd1ef8f86d 100644
--- a/tools/memory-model/Documentation/explanation.txt
+++ b/tools/memory-model/Documentation/explanation.txt
@@ -804,7 +804,7 @@ type of fence:
 Second, some types of fence affect the way the memory subsystem
 propagates stores.  When a fence instruction is executed on CPU C:
 
-	For each other CPU C', smb_wmb() forces all po-earlier stores
+	For each other CPU C', smp_wmb() forces all po-earlier stores
 	on C to propagate to C' before any po-later stores do.
 
 	For each other CPU C', any store which propagates to C before
