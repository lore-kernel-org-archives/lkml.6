Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752708AbeBDVH1 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 4 Feb 2018 16:07:27 -0500
Received: from mail-lf0-f67.google.com ([209.85.215.67]:44987 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752586AbeBDVGo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Feb 2018 16:06:44 -0500
X-Google-Smtp-Source: AH8x227sfpKOgKS/10vKXQe30EALPvhi3qqnD+3ptJI8X8DsjqqlAxlMxm1LmoCjBMsJrs8vb3HNpQ==
From: Maxim Zhukov <mussitantesmortem@gmail.com>
To: marcel@holtmann.org
Cc: johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Maxim Zhukov <mussitantesmortem@gmail.com>
Subject: [PATCH 5/5] drivers: bluetooth: ath3k: fix checkpatch warning
Date: Mon,  5 Feb 2018 00:06:23 +0300
Message-Id: <20180204210623.29734-5-mussitantesmortem@gmail.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180204210623.29734-1-mussitantesmortem@gmail.com>
References: <20180204205934.12117-4-mussitantesmortem@gmail.com>
 <20180204210623.29734-1-mussitantesmortem@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixed warning:
 WARNING: Prefer using '"%s...", __func__' to using 'ath3k_disconnect', this function's name, in a string
 #568: FILE: drivers/bluetooth/ath3k.c:568:
 +	BT_DBG("ath3k_disconnect intf %p", intf);

Signed-off-by: Maxim Zhukov <mussitantesmortem@gmail.com>
---
 drivers/bluetooth/ath3k.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bluetooth/ath3k.c b/drivers/bluetooth/ath3k.c
index 8fe5ec4bb342..3d7a5c149af3 100644
--- a/drivers/bluetooth/ath3k.c
+++ b/drivers/bluetooth/ath3k.c
@@ -569,7 +569,7 @@ static int ath3k_probe(struct usb_interface *intf,
 
 static void ath3k_disconnect(struct usb_interface *intf)
 {
-	BT_DBG("ath3k_disconnect intf %p", intf);
+	BT_DBG("%s intf %p", __func__, intf);
 }
 
 static struct usb_driver ath3k_driver = {
-- 
2.16.1
