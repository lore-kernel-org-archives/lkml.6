Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932890AbeEHWgX (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 18:36:23 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:43517 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754148AbeEHWgW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 18:36:22 -0400
From: Colin King <colin.king@canonical.com>
To: Antonino Daplas <adaplas@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] video: fbdev: nvidia: fix spelling mistake: "scaleing" -> "scaling"
Date: Tue,  8 May 2018 23:36:19 +0100
Message-Id: <20180508223619.25557-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Trivial fix to spelling mistake in module parameter description text

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/video/fbdev/nvidia/nvidia.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/nvidia/nvidia.c b/drivers/video/fbdev/nvidia/nvidia.c
index 418a2d0d06a9..34521f52aa3b 100644
--- a/drivers/video/fbdev/nvidia/nvidia.c
+++ b/drivers/video/fbdev/nvidia/nvidia.c
@@ -1548,7 +1548,7 @@ MODULE_PARM_DESC(noaccel,
 		 "(default=0)");
 module_param(noscale, int, 0);
 MODULE_PARM_DESC(noscale,
-		 "Disables screen scaleing. (0 or 1=disable) "
+		 "Disables screen scaling. (0 or 1=disable) "
 		 "(default=0, do scaling)");
 module_param(paneltweak, int, 0);
 MODULE_PARM_DESC(paneltweak,
-- 
2.17.0
