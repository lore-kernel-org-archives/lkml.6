Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 267B6C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 15:40:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E603B20685
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 15:40:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E603B20685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388725AbeKGBGL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 20:06:11 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:39732 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387714AbeKGBGL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 20:06:11 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1gK3So-00056S-HC; Tue, 06 Nov 2018 15:40:22 +0000
From:   Colin King <colin.king@canonical.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][drm-next] drm/panel: s6d16d0: fix spelling mistake "enble" -> "enable"
Date:   Tue,  6 Nov 2018 15:40:22 +0000
Message-Id: <20181106154022.9209-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Trivial fix to spelling mistake in DRM_DEV_ERROR error message

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/gpu/drm/panel/panel-samsung-s6d16d0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panel/panel-samsung-s6d16d0.c b/drivers/gpu/drm/panel/panel-samsung-s6d16d0.c
index fa8bfa7c492d..33c22ee036f8 100644
--- a/drivers/gpu/drm/panel/panel-samsung-s6d16d0.c
+++ b/drivers/gpu/drm/panel/panel-samsung-s6d16d0.c
@@ -96,7 +96,7 @@ static int s6d16d0_prepare(struct drm_panel *panel)
 	ret = mipi_dsi_dcs_set_tear_on(dsi,
 				       MIPI_DSI_DCS_TEAR_MODE_VBLANK);
 	if (ret) {
-		DRM_DEV_ERROR(s6->dev, "failed to enble vblank TE (%d)\n",
+		DRM_DEV_ERROR(s6->dev, "failed to enable vblank TE (%d)\n",
 			      ret);
 		return ret;
 	}
-- 
2.19.1

