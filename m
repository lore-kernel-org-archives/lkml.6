Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49B4BC0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 06:10:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A1D0204FD
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 06:10:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A1D0204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729346AbeKEP2q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 10:28:46 -0500
Received: from terminus.zytor.com ([198.137.202.136]:53691 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728625AbeKEP2q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 10:28:46 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wA56ARXR218180
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sun, 4 Nov 2018 22:10:27 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wA56ARND218177;
        Sun, 4 Nov 2018 22:10:27 -0800
Date:   Sun, 4 Nov 2018 22:10:27 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Randy Dunlap <tipbot@zytor.com>
Message-ID: <tip-b068621a53f92f42400581d69ad0e84c56620b0a@git.kernel.org>
Cc:     peterz@infradead.org, torvalds@linux-foundation.org,
        mingo@kernel.org, hpa@zytor.com, corbet@lwn.net,
        linux-kernel@vger.kernel.org, rdunlap@infradead.org,
        tglx@linutronix.de
Reply-To: mingo@kernel.org, torvalds@linux-foundation.org,
          peterz@infradead.org, tglx@linutronix.de, rdunlap@infradead.org,
          corbet@lwn.net, linux-kernel@vger.kernel.org, hpa@zytor.com
In-Reply-To: <f259b21b-1f2b-f215-00d2-23388bed2530@infradead.org>
References: <f259b21b-1f2b-f215-00d2-23388bed2530@infradead.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] Documentation/x86: Fix typo in zero-page.txt
Git-Commit-ID: b068621a53f92f42400581d69ad0e84c56620b0a
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

Commit-ID:  b068621a53f92f42400581d69ad0e84c56620b0a
Gitweb:     https://git.kernel.org/tip/b068621a53f92f42400581d69ad0e84c56620b0a
Author:     Randy Dunlap <rdunlap@infradead.org>
AuthorDate: Sun, 4 Nov 2018 14:03:56 -0800
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 5 Nov 2018 07:05:45 +0100

Documentation/x86: Fix typo in zero-page.txt

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-doc@vger.kernel.org
Link: http://lkml.kernel.org/r/f259b21b-1f2b-f215-00d2-23388bed2530@infradead.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 Documentation/x86/zero-page.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/x86/zero-page.txt b/Documentation/x86/zero-page.txt
index 97b7adbceda4..68aed077f7b6 100644
--- a/Documentation/x86/zero-page.txt
+++ b/Documentation/x86/zero-page.txt
@@ -25,7 +25,7 @@ Offset	Proto	Name		Meaning
 0C8/004	ALL	ext_cmd_line_ptr  cmd_line_ptr high 32bits
 140/080	ALL	edid_info	Video mode setup (struct edid_info)
 1C0/020	ALL	efi_info	EFI 32 information (struct efi_info)
-1E0/004	ALL	alk_mem_k	Alternative mem check, in KB
+1E0/004	ALL	alt_mem_k	Alternative mem check, in KB
 1E4/004	ALL	scratch		Scratch field for the kernel setup code
 1E8/001	ALL	e820_entries	Number of entries in e820_table (below)
 1E9/001	ALL	eddbuf_entries	Number of entries in eddbuf (below)
