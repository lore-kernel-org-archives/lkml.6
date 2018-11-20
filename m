Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC182C28CF8
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 15:14:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6011D206BA
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 15:14:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6011D206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728857AbeKUBn4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 20:43:56 -0500
Received: from mail.bootlin.com ([62.4.15.54]:58328 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726554AbeKUBn4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 20:43:56 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 472F020D31; Tue, 20 Nov 2018 16:14:18 +0100 (CET)
Received: from localhost (242.171.71.37.rev.sfr.net [37.71.171.242])
        by mail.bootlin.com (Postfix) with ESMTPSA id 002FA207B0;
        Tue, 20 Nov 2018 16:14:17 +0100 (CET)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Jani Nikula <jani.nikula@linux.intel.com>
Cc:     Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH] drm/i915: fix spelling mistake "reserverd" -> "reserved"
Date:   Tue, 20 Nov 2018 16:14:15 +0100
Message-Id: <20181120151415.32419-1-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix a spelling mistake in a comment.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/gpu/drm/i915/i915_debugfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/i915_debugfs.c b/drivers/gpu/drm/i915/i915_debugfs.c
index f9ce35da4123..742f8ff101e4 100644
--- a/drivers/gpu/drm/i915/i915_debugfs.c
+++ b/drivers/gpu/drm/i915/i915_debugfs.c
@@ -4280,7 +4280,7 @@ static void gen10_sseu_device_status(struct drm_i915_private *dev_priv,
 	for (s = 0; s < info->sseu.max_slices; s++) {
 		/*
 		 * FIXME: Valid SS Mask respects the spec and read
-		 * only valid bits for those registers, excluding reserverd
+		 * only valid bits for those registers, excluding reserved
 		 * although this seems wrong because it would leave many
 		 * subslices without ACK.
 		 */
-- 
2.19.1

