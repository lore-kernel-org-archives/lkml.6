Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753301AbeCPNnX (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 09:43:23 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:43974 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751405AbeCPNnV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 09:43:21 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org DCF89600C1
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=riteshh@codeaurora.org
From: Ritesh Harjani <riteshh@codeaurora.org>
To: jack@suse.com, linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, stummala@codeaurora.org,
        Ritesh Harjani <riteshh@codeaurora.org>
Subject: [PATCH] quota: Kill an unused extern entry form quota.h
Date: Fri, 16 Mar 2018 19:13:02 +0530
Message-Id: <1521207782-14372-1-git-send-email-riteshh@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kill an unused extern entry from quota.h
which is leftover of below patch.

[f32764bd2: quota: Convert quota statistics to generic percpu_counter]

Signed-off-by: Ritesh Harjani <riteshh@codeaurora.org>
---
 include/linux/quota.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/quota.h b/include/linux/quota.h
index 5ac9de4..ca9772c 100644
--- a/include/linux/quota.h
+++ b/include/linux/quota.h
@@ -267,7 +267,6 @@ struct dqstats {
 	struct percpu_counter counter[_DQST_DQSTAT_LAST];
 };
 
-extern struct dqstats *dqstats_pcpu;
 extern struct dqstats dqstats;
 
 static inline void dqstats_inc(unsigned int type)
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.
