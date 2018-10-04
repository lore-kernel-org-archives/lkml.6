Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E693C64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 16:04:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA48320684
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 16:04:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA48320684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com.cn
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727759AbeJDW6s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 18:58:48 -0400
Received: from mail115-100.sinamail.sina.com.cn ([218.30.115.100]:35031 "HELO
        mail115-100.sinamail.sina.com.cn" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with SMTP id S1727484AbeJDW6s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 18:58:48 -0400
Received: from unknown (HELO localhost.localdomain)([139.204.57.91])
        by sina.com with ESMTP
        id 5BB63A14000009E6; Thu, 5 Oct 2018 00:04:44 +0800 (CST)
X-Sender: penghao122@sina.com.cn
X-Auth-ID: penghao122@sina.com.cn
X-SMAIL-MID: 599761132389
From:   Peng Hao <penghao122@sina.com.cn>
To:     zhenyuw@linux.intel.com, zhi.a.wang@intel.com,
        jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        airlied@linux.ie
Cc:     intel-gvt-dev@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Peng Hao <peng.hao2@zte.com.cn>
Subject: [PATCH]  drm/gvt : fix error message typo
Date:   Thu,  4 Oct 2018 12:04:34 -0400
Message-Id: <1538669074-26012-1-git-send-email-penghao122@sina.com.cn>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


From: Peng Hao <peng.hao2@zte.com.cn>

gvt_err message typo.

Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
---
 drivers/gpu/drm/i915/gvt/gvt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/gvt/gvt.c b/drivers/gpu/drm/i915/gvt/gvt.c
index 46c8b72..31d6809 100644
--- a/drivers/gpu/drm/i915/gvt/gvt.c
+++ b/drivers/gpu/drm/i915/gvt/gvt.c
@@ -438,7 +438,7 @@ int intel_gvt_init_device(struct drm_i915_private *dev_priv)
 
 	ret = intel_gvt_debugfs_init(gvt);
 	if (ret)
-		gvt_err("debugfs registeration failed, go on.\n");
+		gvt_err("debugfs registration failed, go on.\n");
 
 	gvt_dbg_core("gvt device initialization is done\n");
 	dev_priv->gvt = gvt;
-- 
1.8.3.1


