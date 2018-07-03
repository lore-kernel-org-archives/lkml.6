Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A27CC6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 11:15:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E179821A6E
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 11:15:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E179821A6E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753175AbeGCLPB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 07:15:01 -0400
Received: from terminus.zytor.com ([198.137.202.136]:38733 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753146AbeGCLO6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 07:14:58 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w63BEpDL258116
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 3 Jul 2018 04:14:51 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w63BEpud258113;
        Tue, 3 Jul 2018 04:14:51 -0700
Date:   Tue, 3 Jul 2018 04:14:51 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Andy Shevchenko <tipbot@zytor.com>
Message-ID: <tip-5067b087cf5b2fa4de00443cdc6a66acb28a4953@git.kernel.org>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org, mingo@kernel.org,
        pasha.tatashin@oracle.com, hpa@zytor.com,
        andriy.shevchenko@linux.intel.com
Reply-To: pasha.tatashin@oracle.com, hpa@zytor.com, tglx@linutronix.de,
          linux-kernel@vger.kernel.org, mingo@kernel.org,
          andriy.shevchenko@linux.intel.com
In-Reply-To: <20180629193113.84425-5-andriy.shevchenko@linux.intel.com>
References: <20180629193113.84425-5-andriy.shevchenko@linux.intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/timers] x86/tsc: Use SPDX identifier and update Intel
 copyright
Git-Commit-ID: 5067b087cf5b2fa4de00443cdc6a66acb28a4953
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

Commit-ID:  5067b087cf5b2fa4de00443cdc6a66acb28a4953
Gitweb:     https://git.kernel.org/tip/5067b087cf5b2fa4de00443cdc6a66acb28a4953
Author:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
AuthorDate: Fri, 29 Jun 2018 22:31:11 +0300
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Tue, 3 Jul 2018 13:08:20 +0200

x86/tsc: Use SPDX identifier and update Intel copyright

Use SPDX identifier and update year in Intel copyright line.

While here, remove file name from the file itself.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Pavel Tatashin <pasha.tatashin@oracle.com>
Link: https://lkml.kernel.org/r/20180629193113.84425-5-andriy.shevchenko@linux.intel.com

---
 arch/x86/kernel/tsc_msr.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/tsc_msr.c b/arch/x86/kernel/tsc_msr.c
index 1465aaee543a..f0951c2e9f28 100644
--- a/arch/x86/kernel/tsc_msr.c
+++ b/arch/x86/kernel/tsc_msr.c
@@ -1,10 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
- * tsc_msr.c - TSC frequency enumeration via MSR
+ * TSC frequency enumeration via MSR
  *
- * Copyright (C) 2013 Intel Corporation
+ * Copyright (C) 2013, 2018 Intel Corporation
  * Author: Bin Gao <bin.gao@intel.com>
- *
- * This file is released under the GPLv2.
  */
 
 #include <linux/kernel.h>
