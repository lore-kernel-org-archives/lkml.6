Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2ECAC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 19:25:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76B73216E3
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 19:25:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76B73216E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728804AbeI1Bp3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 21:45:29 -0400
Received: from terminus.zytor.com ([198.137.202.136]:47775 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728101AbeI1Bp3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 21:45:29 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w8RJPTk3139494
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 27 Sep 2018 12:25:29 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w8RJPT2w139490;
        Thu, 27 Sep 2018 12:25:29 -0700
Date:   Thu, 27 Sep 2018 12:25:29 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for YueHaibing <tipbot@zytor.com>
Message-ID: <tip-5140a6f471137205687428b0b8f12f7187bffd18@git.kernel.org>
Cc:     yuehaibing@huawei.com, sthemmin@microsoft.com,
        linux-kernel@vger.kernel.org, devel@linuxdriverproject.org,
        kernel-janitors@vger.kernel.org, mikelley@microsoft.com,
        haiyangz@microsoft.com, kys@microsoft.com, mingo@kernel.org,
        tglx@linutronix.de, hpa@zytor.com
Reply-To: devel@linuxdriverproject.org, kernel-janitors@vger.kernel.org,
          linux-kernel@vger.kernel.org, sthemmin@microsoft.com,
          yuehaibing@huawei.com, tglx@linutronix.de, hpa@zytor.com,
          mingo@kernel.org, kys@microsoft.com, haiyangz@microsoft.com,
          mikelley@microsoft.com
In-Reply-To: <1537690822-97455-1-git-send-email-yuehaibing@huawei.com>
References: <1537690822-97455-1-git-send-email-yuehaibing@huawei.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/hyperv] x86/hyperv: Remove unused include
Git-Commit-ID: 5140a6f471137205687428b0b8f12f7187bffd18
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

Commit-ID:  5140a6f471137205687428b0b8f12f7187bffd18
Gitweb:     https://git.kernel.org/tip/5140a6f471137205687428b0b8f12f7187bffd18
Author:     YueHaibing <yuehaibing@huawei.com>
AuthorDate: Sun, 23 Sep 2018 08:20:22 +0000
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 27 Sep 2018 21:21:00 +0200

x86/hyperv: Remove unused include

Remove including <linux/version.h>. It's not needed.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Michael Kelley <mikelley@microsoft.com>
Cc: "K. Y. Srinivasan" <kys@microsoft.com>
Cc: Haiyang Zhang <haiyangz@microsoft.com>
Cc: Stephen Hemminger <sthemmin@microsoft.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: <devel@linuxdriverproject.org>
Cc: <kernel-janitors@vger.kernel.org>
Link: https://lkml.kernel.org/r/1537690822-97455-1-git-send-email-yuehaibing@huawei.com

---
 arch/x86/hyperv/hv_apic.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/x86/hyperv/hv_apic.c b/arch/x86/hyperv/hv_apic.c
index 2c43e3055948..8eb6fbee8e13 100644
--- a/arch/x86/hyperv/hv_apic.c
+++ b/arch/x86/hyperv/hv_apic.c
@@ -20,7 +20,6 @@
  */
 
 #include <linux/types.h>
-#include <linux/version.h>
 #include <linux/vmalloc.h>
 #include <linux/mm.h>
 #include <linux/clockchips.h>
