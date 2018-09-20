Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 827E4C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 19:40:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 277E5206B5
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 19:40:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 277E5206B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388103AbeIUBZp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 21:25:45 -0400
Received: from mga11.intel.com ([192.55.52.93]:13362 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727241AbeIUBZp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 21:25:45 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Sep 2018 12:40:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,281,1534834800"; 
   d="scan'208";a="265334589"
Received: from romley-ivt3.sc.intel.com ([172.25.110.60])
  by fmsmga006.fm.intel.com with ESMTP; 20 Sep 2018 12:40:04 -0700
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     "Thomas Gleixner" <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, "H Peter Anvin" <hpa@zytor.com>,
        "Tony Luck" <tony.luck@intel.com>,
        "Reinette Chatre" <reinette.chatre@intel.com>
Cc:     "linux-kernel" <linux-kernel@vger.kernel.org>,
        "x86" <x86@kernel.org>, Fenghua Yu <fenghua.yu@intel.com>
Subject: [PATCH] x86/intel_rdt: Add Reinette as co-maintainer for RDT
Date:   Thu, 20 Sep 2018 12:37:08 -0700
Message-Id: <1537472228-221799-1-git-send-email-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.5.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reinette Chatre is doing great job on enabling pseudo-locking and other
features in RDT. Add her as co-maintainer for RDT.

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Acked-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Reinette Chatre <reinette.chatre@intel.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 4ece30f15777..c884dc08a580 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12260,6 +12260,7 @@ F:	Documentation/networking/rds.txt
 
 RDT - RESOURCE ALLOCATION
 M:	Fenghua Yu <fenghua.yu@intel.com>
+M:	Reinette Chatre <reinette.chatre@intel.com>
 L:	linux-kernel@vger.kernel.org
 S:	Supported
 F:	arch/x86/kernel/cpu/intel_rdt*
-- 
2.5.0

