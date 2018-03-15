Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932313AbeCOSQh (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 14:16:37 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:54607 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752209AbeCOSQg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 14:16:36 -0400
From: Colin King <colin.king@canonical.com>
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] fbdev: aty: fix missing indentation in if statement
Date: Thu, 15 Mar 2018 18:16:24 +0000
Message-Id: <20180315181624.18684-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.15.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There is a missing indentation following an if statement, fix this.

Detected by Coccinelle:
drivers/video/fbdev/aty/mach64_ct.c:183:2-15: code aligned with
following code on line 184

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/video/fbdev/aty/mach64_ct.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/aty/mach64_ct.c b/drivers/video/fbdev/aty/mach64_ct.c
index 7d3bd723d3d5..74a62aa193c0 100644
--- a/drivers/video/fbdev/aty/mach64_ct.c
+++ b/drivers/video/fbdev/aty/mach64_ct.c
@@ -180,7 +180,7 @@ static int aty_dsp_gt(const struct fb_info *info, u32 bpp, struct pll_ct *pll)
 		dsp_on = ((multiplier << vshift) + divider) / divider;
 		tmp = ((ras_multiplier << xshift) + ras_divider) / ras_divider;
 		if (dsp_on < tmp)
-		dsp_on = tmp;
+			dsp_on = tmp;
 		dsp_on = dsp_on + (tmp * 2) + (pll->xclkpagefaultdelay << xshift);
 	}
 
-- 
2.15.1
