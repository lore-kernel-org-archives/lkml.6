Return-Path: <SRS0=Aihr=QY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E934C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 22:56:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FE0A21773
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 22:56:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727144AbfBQW4E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Feb 2019 17:56:04 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:41983 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726283AbfBQW4E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Feb 2019 17:56:04 -0500
Received: from cpc129250-craw9-2-0-cust139.know.cable.virginm.net ([82.43.126.140] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1gvVLn-0000pJ-3q; Sun, 17 Feb 2019 22:55:55 +0000
From:   Colin King <colin.king@canonical.com>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm: fix spelling mistake "intead" -> "instead"
Date:   Sun, 17 Feb 2019 22:55:54 +0000
Message-Id: <20190217225554.17742-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There is a spelling mistake in a DRM_NOTE message. Fix this.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/gpu/drm/drm_kms_helper_common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_kms_helper_common.c b/drivers/gpu/drm/drm_kms_helper_common.c
index 93e2b30fe1a5..9c5ae825c507 100644
--- a/drivers/gpu/drm/drm_kms_helper_common.c
+++ b/drivers/gpu/drm/drm_kms_helper_common.c
@@ -39,7 +39,7 @@ MODULE_LICENSE("GPL and additional rights");
 /* Backward compatibility for drm_kms_helper.edid_firmware */
 static int edid_firmware_set(const char *val, const struct kernel_param *kp)
 {
-	DRM_NOTE("drm_kms_firmware.edid_firmware is deprecated, please use drm.edid_firmware intead.\n");
+	DRM_NOTE("drm_kms_firmware.edid_firmware is deprecated, please use drm.edid_firmware instead.\n");
 
 	return __drm_set_edid_firmware_path(val);
 }
-- 
2.20.1

