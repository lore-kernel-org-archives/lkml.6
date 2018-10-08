Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92542C65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 14:44:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C580204EC
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 14:44:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C580204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726722AbeJHV4f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 17:56:35 -0400
Received: from mga03.intel.com ([134.134.136.65]:53274 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726697AbeJHV4e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 17:56:34 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Oct 2018 07:44:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,357,1534834800"; 
   d="scan'208";a="77126123"
Received: from rajneesh-desk.iind.intel.com ([10.223.86.34])
  by fmsmga008.fm.intel.com with ESMTP; 08 Oct 2018 07:44:28 -0700
From:   Rajneesh Bhardwaj <rajneesh.bhardwaj@linux.intel.com>
To:     platform-driver-x86@vger.kernel.org
Cc:     dvhart@infradead.org, andy@infradead.org,
        linux-kernel@vger.kernel.org, rajneesh.bhardwaj@intel.com,
        david.e.box@linux.intel.com,
        Rajneesh Bhardwaj <rajneesh.bhardwaj@linux.intel.com>
Subject: [PATCH] MAINTAINERS: intel_telemetry: Update maintainers info
Date:   Mon,  8 Oct 2018 20:13:03 +0530
Message-Id: <20181008144303.23878-1-rajneesh.bhardwaj@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add myself and David as the new maintainers for Intel Telemetry driver.

Signed-off-by: Box, David E <david.e.box@linux.intel.com>
Signed-off-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@linux.intel.com>
---
 MAINTAINERS | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 22065048d89d..f33ebd1b8034 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7530,7 +7530,8 @@ F:	arch/x86/crypto/sha*-mb/
 F:	crypto/mcryptd.c
 
 INTEL TELEMETRY DRIVER
-M:	Souvik Kumar Chakravarty <souvik.k.chakravarty@intel.com>
+M:	Rajneesh Bhardwaj <rajneesh.bhardwaj@linux.intel.com>
+M:	Box, David E <david.e.box@linux.intel.com>
 L:	platform-driver-x86@vger.kernel.org
 S:	Maintained
 F:	arch/x86/include/asm/intel_telemetry.h
-- 
2.17.1

