Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 104A6C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 13:34:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA6B92184A
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 13:34:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729825AbfBLNes (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 08:34:48 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:38609 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726748AbfBLNer (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 08:34:47 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1gtYCy-0007dE-O6; Tue, 12 Feb 2019 13:34:44 +0000
From:   Colin King <colin.king@canonical.com>
To:     Antonino Daplas <adaplas@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] video: fbdev: savage: fix indentation issue
Date:   Tue, 12 Feb 2019 13:34:44 +0000
Message-Id: <20190212133444.7669-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The indentation in the if statement is not indented correctly, fix
this with extra level of indentation.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/video/fbdev/savage/savagefb_driver.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/video/fbdev/savage/savagefb_driver.c b/drivers/video/fbdev/savage/savagefb_driver.c
index c09d7426cd92..47b78f0138c3 100644
--- a/drivers/video/fbdev/savage/savagefb_driver.c
+++ b/drivers/video/fbdev/savage/savagefb_driver.c
@@ -2155,9 +2155,9 @@ static int savage_init_fb_info(struct fb_info *info, struct pci_dev *dev,
 
 		err = fb_alloc_cmap(&info->cmap, NR_PALETTE, 0);
 		if (!err)
-		info->flags |= FBINFO_HWACCEL_COPYAREA |
-	                       FBINFO_HWACCEL_FILLRECT |
-		               FBINFO_HWACCEL_IMAGEBLIT;
+			info->flags |= FBINFO_HWACCEL_COPYAREA |
+				       FBINFO_HWACCEL_FILLRECT |
+				       FBINFO_HWACCEL_IMAGEBLIT;
 	}
 #endif
 	return err;
-- 
2.20.1

