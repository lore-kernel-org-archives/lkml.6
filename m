Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBD09C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 10:16:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D0B8206B2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 10:16:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D0B8206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727428AbeJBQ7Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 12:59:24 -0400
Received: from terminus.zytor.com ([198.137.202.136]:59821 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726611AbeJBQ7Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 12:59:24 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w92AGUs71917382
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 2 Oct 2018 03:16:30 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w92AGTp31917379;
        Tue, 2 Oct 2018 03:16:29 -0700
Date:   Tue, 2 Oct 2018 03:16:29 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Andrew Murray <tipbot@zytor.com>
Message-ID: <tip-bccb484b9a8d1695df1094991df2bdcf83a4b921@git.kernel.org>
Cc:     hpa@zytor.com, will.deacon@arm.com, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, corbet@lwn.net,
        peterz@infradead.org, tglx@linutronix.de, andrew.murray@arm.com,
        mingo@kernel.org, trivial@kernel.org
Reply-To: hpa@zytor.com, corbet@lwn.net, torvalds@linux-foundation.org,
          linux-kernel@vger.kernel.org, will.deacon@arm.com,
          tglx@linutronix.de, peterz@infradead.org, trivial@kernel.org,
          mingo@kernel.org, andrew.murray@arm.com
In-Reply-To: <1538391663-54524-1-git-send-email-andrew.murray@arm.com>
References: <1538391663-54524-1-git-send-email-andrew.murray@arm.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:locking/core] Documentation/lockstat: Fix trivial typo
Git-Commit-ID: bccb484b9a8d1695df1094991df2bdcf83a4b921
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

Commit-ID:  bccb484b9a8d1695df1094991df2bdcf83a4b921
Gitweb:     https://git.kernel.org/tip/bccb484b9a8d1695df1094991df2bdcf83a4b921
Author:     Andrew Murray <andrew.murray@arm.com>
AuthorDate: Mon, 1 Oct 2018 12:01:03 +0100
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 2 Oct 2018 10:59:25 +0200

Documentation/lockstat: Fix trivial typo

Fix incorrect line number in example output

Signed-off-by: Andrew Murray <andrew.murray@arm.com>
Cc: Jiri Kosina <trivial@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Will Deacon <will.deacon@arm.com>
Cc: linux-doc@vger.kernel.org
Link: http://lkml.kernel.org/r/1538391663-54524-1-git-send-email-andrew.murray@arm.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 Documentation/locking/lockstat.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/locking/lockstat.txt b/Documentation/locking/lockstat.txt
index 5786ad2cd5e6..fdbeb0c45ef3 100644
--- a/Documentation/locking/lockstat.txt
+++ b/Documentation/locking/lockstat.txt
@@ -91,7 +91,7 @@ Look at the current lock statistics:
 07                         &mm->mmap_sem-R:            37            100           1.31      299502.61      325629.52        3256.30         212344       34316685           0.10        7744.91    95016910.20           2.77
 08                         ---------------
 09                           &mm->mmap_sem              1          [<ffffffff811502a7>] khugepaged_scan_mm_slot+0x57/0x280
-19                           &mm->mmap_sem             96          [<ffffffff815351c4>] __do_page_fault+0x1d4/0x510
+10                           &mm->mmap_sem             96          [<ffffffff815351c4>] __do_page_fault+0x1d4/0x510
 11                           &mm->mmap_sem             34          [<ffffffff81113d77>] vm_mmap_pgoff+0x87/0xd0
 12                           &mm->mmap_sem             17          [<ffffffff81127e71>] vm_munmap+0x41/0x80
 13                         ---------------
