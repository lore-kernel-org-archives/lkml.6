Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966598AbeE2U0b (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 16:26:31 -0400
Received: from lelnx193.ext.ti.com ([198.47.27.77]:40799 "EHLO
        lelnx193.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966179AbeE2U03 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 16:26:29 -0400
From: Dan Murphy <dmurphy@ti.com>
To: <socketcan@hartkopp.net>, <mkl@pengutronix.de>,
        <linux-can@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, Dan Murphy <dmurphy@ti.com>
Subject: [PATCH] can.h: Fix can error class mask dir path
Date: Tue, 29 May 2018 15:26:12 -0500
Message-ID: <20180529202612.4873-1-dmurphy@ti.com>
X-Mailer: git-send-email 2.12.2
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The CAN error masks header file is in the
include/uapi directory.

Fix the path in the header to the correct location.

Signed-off-by: Dan Murphy <dmurphy@ti.com>
---
 include/uapi/linux/can.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/uapi/linux/can.h b/include/uapi/linux/can.h
index d7f97ac197a9..0afb7d8e867f 100644
--- a/include/uapi/linux/can.h
+++ b/include/uapi/linux/can.h
@@ -77,7 +77,7 @@ typedef __u32 canid_t;
 /*
  * Controller Area Network Error Message Frame Mask structure
  *
- * bit 0-28	: error class mask (see include/linux/can/error.h)
+ * bit 0-28	: error class mask (see include/uapi/linux/can/error.h)
  * bit 29-31	: set to zero
  */
 typedef __u32 can_err_mask_t;
-- 
2.17.0.582.gccdcbd54c
