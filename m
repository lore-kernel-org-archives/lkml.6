Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFF75ECE566
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 14:37:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85CCD20833
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 14:37:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85CCD20833
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ddn.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733046AbeITUVQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 16:21:16 -0400
Received: from legacy.ddn.com ([64.47.133.206]:15926 "EHLO legacy.ddn.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726990AbeITUVQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 16:21:16 -0400
X-Greylist: delayed 324 seconds by postgrey-1.27 at vger.kernel.org; Thu, 20 Sep 2018 16:21:16 EDT
Received: from LAX-EX-CAHT1.datadirect.datadirectnet.com (10.8.103.81) by
 LAX-EX-CAHT2.datadirect.datadirectnet.com (10.8.103.82) with Microsoft SMTP
 Server (TLS) id 14.3.389.1; Thu, 20 Sep 2018 07:32:06 -0700
Received: from localhost.localdomain.com (10.48.114.60) by
 LAX-EX-CAHT1.datadirect.datadirectnet.com (10.8.103.81) with Microsoft SMTP
 Server (TLS) id 14.3.389.1; Thu, 20 Sep 2018 07:32:05 -0700
From:   Matt Lupfer <mlupfer@ddn.com>
To:     Len Brown <len.brown@intel.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        Matt Lupfer <mlupfer@ddn.com>
Subject: [PATCH] tools/power: Fix typo in man page
Date:   Thu, 20 Sep 2018 10:31:44 -0400
Message-ID: <20180920143144.12210-1-mlupfer@ddn.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.48.114.60]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From context, we mean EPB (Enegry Performance Bias).

Signed-off-by: Matt Lupfer <mlupfer@ddn.com>
---
 tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.8 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.8 b/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.8
index 17db1c3af4d0..78c6361898b1 100644
--- a/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.8
+++ b/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.8
@@ -40,7 +40,7 @@ in the same processor package.
 Hardware P-States (HWP) are effectively an expansion of hardware
 P-state control from the opportunistic turbo-mode P-state range
 to include the entire range of available P-states.
-On Broadwell Xeon, the initial HWP implementation, EBP influenced HWP.
+On Broadwell Xeon, the initial HWP implementation, EPB influenced HWP.
 That influence was removed in subsequent generations,
 where it was moved to the
 Energy_Performance_Preference (EPP) field in
-- 
2.17.1

