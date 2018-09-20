Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74ABDC433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 19:55:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23FA121525
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 19:55:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23FA121525
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388193AbeIUBkG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 21:40:06 -0400
Received: from terminus.zytor.com ([198.137.202.136]:52255 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726582AbeIUBkG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 21:40:06 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w8KJsqK11677461
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 20 Sep 2018 12:54:52 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w8KJspaU1677458;
        Thu, 20 Sep 2018 12:54:51 -0700
Date:   Thu, 20 Sep 2018 12:54:51 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Fenghua Yu <tipbot@zytor.com>
Message-ID: <tip-a8b3bb338e4ee4cc84a2b9a6fdf27049b84baa59@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, fenghua.yu@intel.com,
        tglx@linutronix.de, hpa@zytor.com, reinette.chatre@intel.com,
        tony.luck@intel.com, mingo@kernel.org
Reply-To: mingo@kernel.org, tony.luck@intel.com, reinette.chatre@intel.com,
          linux-kernel@vger.kernel.org, fenghua.yu@intel.com,
          tglx@linutronix.de, hpa@zytor.com
In-Reply-To: <1537472228-221799-1-git-send-email-fenghua.yu@intel.com>
References: <1537472228-221799-1-git-send-email-fenghua.yu@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/intel_rdt: Add Reinette as co-maintainer for
 RDT
Git-Commit-ID: a8b3bb338e4ee4cc84a2b9a6fdf27049b84baa59
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

Commit-ID:  a8b3bb338e4ee4cc84a2b9a6fdf27049b84baa59
Gitweb:     https://git.kernel.org/tip/a8b3bb338e4ee4cc84a2b9a6fdf27049b84baa59
Author:     Fenghua Yu <fenghua.yu@intel.com>
AuthorDate: Thu, 20 Sep 2018 12:37:08 -0700
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 20 Sep 2018 21:44:35 +0200

x86/intel_rdt: Add Reinette as co-maintainer for RDT

Reinette Chatre is doing great job on enabling pseudo-locking and other
features in RDT. Add her as co-maintainer for RDT.

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Reinette Chatre <reinette.chatre@intel.com>
Cc: "H Peter Anvin" <hpa@zytor.com>
Cc: "Tony Luck" <tony.luck@intel.com>
Link: https://lkml.kernel.org/r/1537472228-221799-1-git-send-email-fenghua.yu@intel.com

---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 091e66b60cd2..140ea6ee3ac8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12260,6 +12260,7 @@ F:	Documentation/networking/rds.txt
 
 RDT - RESOURCE ALLOCATION
 M:	Fenghua Yu <fenghua.yu@intel.com>
+M:	Reinette Chatre <reinette.chatre@intel.com>
 L:	linux-kernel@vger.kernel.org
 S:	Supported
 F:	arch/x86/kernel/cpu/intel_rdt*
