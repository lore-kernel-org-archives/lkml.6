Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68D91C00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 11:52:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25ED82089F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 11:52:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25ED82089F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727209AbeJCSkr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 14:40:47 -0400
Received: from mga14.intel.com ([192.55.52.115]:27453 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726967AbeJCSkr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 14:40:47 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Oct 2018 04:52:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,335,1534834800"; 
   d="scan'208";a="94249788"
Received: from rajneesh-desk.iind.intel.com ([10.223.86.34])
  by fmsmga004.fm.intel.com with ESMTP; 03 Oct 2018 04:52:41 -0700
From:   Rajneesh Bhardwaj <rajneesh.bhardwaj@linux.intel.com>
To:     platform-driver-x86@vger.kernel.org
Cc:     dvhart@infradead.org, andy@infradead.org,
        linux-kernel@vger.kernel.org, joe@perches.com,
        Rajneesh Bhardwaj <rajneesh.bhardwaj@linux.intel.com>
Subject: [PATCH] MAINTAINERS: intel_pmc_core: Update MAINTAINERS
Date:   Wed,  3 Oct 2018 17:21:10 +0530
Message-Id: <20181003115110.25996-1-rajneesh.bhardwaj@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This removes the entry for pmc_core.h file in the MAINTAINERS as the
file is already removed by a previous commit.
"platform/x86: intel_pmc_core: Remove unused header file"

Reported-by: Joe Perches <joe@perches.com>
Signed-off-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@linux.intel.com>
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9ad052aeac39..60d029b65767 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7468,7 +7468,6 @@ M:	Rajneesh Bhardwaj <rajneesh.bhardwaj@intel.com>
 M:	Vishwanath Somayaji <vishwanath.somayaji@intel.com>
 L:	platform-driver-x86@vger.kernel.org
 S:	Maintained
-F:	arch/x86/include/asm/pmc_core.h
 F:	drivers/platform/x86/intel_pmc_core*
 
 INTEL PMC/P-Unit IPC DRIVER
-- 
2.17.1

