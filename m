Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA277C6783C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 16:48:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F5212077C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 16:48:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F5212077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727323AbeJMAVt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 20:21:49 -0400
Received: from mga06.intel.com ([134.134.136.31]:38760 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725902AbeJMAVt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 20:21:49 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Oct 2018 09:48:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,373,1534834800"; 
   d="scan'208";a="98686473"
Received: from tthayer-hp-z620.an.intel.com ([10.122.105.132])
  by fmsmga001.fm.intel.com with ESMTP; 12 Oct 2018 09:48:27 -0700
From:   thor.thayer@linux.intel.com
To:     gregkh@linuxfoundation.org, geert+renesas@glider.be,
        jhogan@kernel.org, atull@kernel.org, bhelgaas@google.com,
        james.hartley@sondrel.com, linux-kernel@vger.kernel.org
Cc:     Thor Thayer <thor.thayer@linux.intel.com>
Subject: [PATCH] MAINTAINERS: Replace Vince Bridgers as Altera TSE maintainer
Date:   Fri, 12 Oct 2018 11:50:52 -0500
Message-Id: <1539363052-6143-1-git-send-email-thor.thayer@linux.intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thor Thayer <thor.thayer@linux.intel.com>

Vince has moved to a different role. Replace him as Altera
TSE maintainer.

Signed-off-by: Thor Thayer <thor.thayer@linux.intel.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 72429b928626..f02cf78f5394 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -683,7 +683,7 @@ F:	include/linux/mfd/altera-a10sr.h
 F:	include/dt-bindings/reset/altr,rst-mgr-a10sr.h
 
 ALTERA TRIPLE SPEED ETHERNET DRIVER
-M:	Vince Bridgers <vbridger@opensource.altera.com>
+M:	Thor Thayer <thor.thayer@linux.intel.com>
 L:	netdev@vger.kernel.org
 L:	nios2-dev@lists.rocketboards.org (moderated for non-subscribers)
 S:	Maintained
-- 
2.7.4

