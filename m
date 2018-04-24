Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756685AbeDXIYk (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 04:24:40 -0400
Received: from srv-hp10-72.netsons.net ([94.141.22.72]:55810 "EHLO
        srv-hp10-72.netsons.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756629AbeDXIYe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 04:24:34 -0400
From: Luca Ceresoli <luca@lucaceresoli.net>
To: linux-media@vger.kernel.org
Cc: Luca Ceresoli <luca@lucaceresoli.net>,
        Leon Luo <leonl@leopardimaging.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 01/13] media: imx274: document reset delays more clearly
Date: Tue, 24 Apr 2018 10:24:06 +0200
Message-Id: <1524558258-530-2-git-send-email-luca@lucaceresoli.net>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1524558258-530-1-git-send-email-luca@lucaceresoli.net>
References: <1524558258-530-1-git-send-email-luca@lucaceresoli.net>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - srv-hp10.netsons.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lucaceresoli.net
X-Get-Message-Sender-Via: srv-hp10.netsons.net: authenticated_id: luca+lucaceresoli.net/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: srv-hp10.netsons.net: luca@lucaceresoli.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the unit to avoid having to look through the code to compute it.
Also clarify that these are min and max values.

Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>

---
Changed v1 -> v2:
 - add "media: " prefix to commit message
---
 drivers/media/i2c/imx274.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/i2c/imx274.c b/drivers/media/i2c/imx274.c
index daec33f4196a..5e425db9204d 100644
--- a/drivers/media/i2c/imx274.c
+++ b/drivers/media/i2c/imx274.c
@@ -87,7 +87,7 @@
 #define IMX274_SHR_LIMIT_CONST			(4)
 
 /*
- * Constants for sensor reset delay
+ * Min and max sensor reset delay (microseconds)
  */
 #define IMX274_RESET_DELAY1			(2000)
 #define IMX274_RESET_DELAY2			(2200)
-- 
2.7.4
