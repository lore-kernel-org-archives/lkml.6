Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E620C6783C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 16:29:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E7AA2098A
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 16:29:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E7AA2098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729060AbeJMACc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 20:02:32 -0400
Received: from mga03.intel.com ([134.134.136.65]:37664 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728741AbeJMACc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 20:02:32 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Oct 2018 09:29:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,373,1534834800"; 
   d="scan'208";a="87886698"
Received: from linux.intel.com ([10.54.29.200])
  by FMSMGA003.fm.intel.com with ESMTP; 12 Oct 2018 09:29:14 -0700
Received: from debox1-dev.jf.intel.com (debox1-dev.jf.intel.com [10.54.75.165])
        by linux.intel.com (Postfix) with ESMTP id B607858015C;
        Fri, 12 Oct 2018 09:29:14 -0700 (PDT)
From:   "David E. Box" <david.e.box@intel.com>
To:     platform-driver-x86@vger.kernel.org
Cc:     dvhart@infradead.org, andy@infradead.org,
        linux-kernel@vger.kernel.org, rajneesh.bhardwaj@linux.intel.com,
        "David E. Box" <david.e.box@intel.com>
Subject: [PATCH V3] MAINTAINERS: intel_telemetry: Update maintainers info
Date:   Fri, 12 Oct 2018 09:28:16 -0700
Message-Id: <20181012162816.14396-1-david.e.box@intel.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <262d8a05cedc76bc90fa5be7d3b92d5faa2b4ce9.camel@perches.com>
References: <262d8a05cedc76bc90fa5be7d3b92d5faa2b4ce9.camel@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove Souvik who has left this role. Add Rajneesh and David who work
jointly on telemetry updates for new platforms.

Signed-off-by: David E. Box <david.e.box@intel.com>
Signed-off-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@linux.intel.com>
---

	V3: Change signoff format

 MAINTAINERS | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 544cac829cf4..cbe1595db4a5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7355,7 +7355,8 @@ F:	arch/x86/crypto/sha*-mb
 F:	crypto/mcryptd.c
 
 INTEL TELEMETRY DRIVER
-M:	Souvik Kumar Chakravarty <souvik.k.chakravarty@intel.com>
+M:	Rajneesh Bhardwaj <rajneesh.bhardwaj@linux.intel.com>
+M:	"David E. Box" <david.e.box@linux.intel.com>
 L:	platform-driver-x86@vger.kernel.org
 S:	Maintained
 F:	arch/x86/include/asm/intel_telemetry.h
-- 
2.14.4

