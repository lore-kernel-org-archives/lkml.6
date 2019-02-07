Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4E0CC282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 20:10:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACBCC2080F
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 20:10:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727458AbfBGUKJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 15:10:09 -0500
Received: from anholt.net ([50.246.234.109]:57746 "EHLO anholt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727413AbfBGUKH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 15:10:07 -0500
Received: from localhost (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id CD54D10A2C1C;
        Thu,  7 Feb 2019 12:10:06 -0800 (PST)
X-Virus-Scanned: Debian amavisd-new at anholt.net
Received: from anholt.net ([127.0.0.1])
        by localhost (kingsolver.anholt.net [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id hCk3v6E7ytGA; Thu,  7 Feb 2019 12:10:05 -0800 (PST)
Received: from eliezer.anholt.net (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id A6C0210A2C21;
        Thu,  7 Feb 2019 12:10:02 -0800 (PST)
Received: by eliezer.anholt.net (Postfix, from userid 1000)
        id 9BB142FE464C; Thu,  7 Feb 2019 12:10:01 -0800 (PST)
From:   Eric Anholt <eric@anholt.net>
To:     dri-devel@lists.freedesktop.org
Cc:     linux-kernel@vger.kernel.org, david.emett@broadcom.com,
        thomas.spurden@broadcom.com, Eric Anholt <eric@anholt.net>
Subject: [PATCH 1/4] drm/v3d: Update top-level kerneldoc for the addition of TFU.
Date:   Thu,  7 Feb 2019 12:09:58 -0800
Message-Id: <20190207201001.5730-1-eric@anholt.net>
X-Mailer: git-send-email 2.20.0.rc1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Eric Anholt <eric@anholt.net>
---
 drivers/gpu/drm/v3d/v3d_drv.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/v3d/v3d_drv.c b/drivers/gpu/drm/v3d/v3d_drv.c
index 22fff0d3aecd..1f22ce542a04 100644
--- a/drivers/gpu/drm/v3d/v3d_drv.c
+++ b/drivers/gpu/drm/v3d/v3d_drv.c
@@ -7,9 +7,9 @@
  * This driver supports the Broadcom V3D 3.3 and 4.1 OpenGL ES GPUs.
  * For V3D 2.x support, see the VC4 driver.
  *
- * Currently only single-core rendering using the binner and renderer
- * is supported.  The TFU (texture formatting unit) and V3D 4.x's CSD
- * (compute shader dispatch) are not yet supported.
+ * Currently only single-core rendering using the binner and renderer,
+ * along with TFU (texture formatting unit) rendering is supported.
+ * V3D 4.x's CSD (compute shader dispatch) is not yet supported.
  */
 
 #include <linux/clk.h>
-- 
2.20.0.rc1

