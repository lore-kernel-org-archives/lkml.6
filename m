Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E9A6C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 16:41:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A32E21777
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 16:41:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A32E21777
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729367AbeHCSi7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 14:38:59 -0400
Received: from mga01.intel.com ([192.55.52.88]:24500 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727819AbeHCSi6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 14:38:58 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Aug 2018 09:41:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,439,1526367600"; 
   d="scan'208";a="62178455"
Received: from espoo.fi.intel.com ([10.237.66.147])
  by orsmga008.jf.intel.com with ESMTP; 03 Aug 2018 09:41:51 -0700
From:   Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: [PATCH] drm/i915: Fix typo in i915_drm_resume()
Date:   Fri,  3 Aug 2018 19:41:50 +0300
Message-Id: <20180803164150.8185-1-gwan-gyeong.mun@intel.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>
---
 drivers/gpu/drm/i915/i915_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/i915_drv.c b/drivers/gpu/drm/i915/i915_drv.c
index 18a45e7a3d7c..64e0ea4bef67 100644
--- a/drivers/gpu/drm/i915/i915_drv.c
+++ b/drivers/gpu/drm/i915/i915_drv.c
@@ -1758,7 +1758,7 @@ static int i915_drm_resume(struct drm_device *dev)
 	/*
 	 * ... but also need to make sure that hotplug processing
 	 * doesn't cause havoc. Like in the driver load code we don't
-	 * bother with the tiny race here where we might loose hotplug
+	 * bother with the tiny race here where we might lose hotplug
 	 * notifications.
 	 * */
 	intel_hpd_init(dev_priv);
-- 
2.18.0

