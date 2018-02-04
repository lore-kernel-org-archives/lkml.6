Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752657AbeBDVAS (ORCPT <rfc822;w@1wt.eu>);
        Sun, 4 Feb 2018 16:00:18 -0500
Received: from mail-lf0-f68.google.com ([209.85.215.68]:37369 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752602AbeBDU74 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Feb 2018 15:59:56 -0500
X-Google-Smtp-Source: AH8x226rdlNSwuNz1GcgM/TV/dlr5nDfgsbZGmDeGA6QlSQOLWGs/eRr64mUk/WTjejX13gAv6+Kvg==
From: Maxim Zhukov <mussitantesmortem@gmail.com>
To: marcel@holtmann.org
Cc: johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Maxim Zhukov <mussitantesmortem@gmail.com>
Subject: [PATCH 3/5] drivers: bluetooth: ath3k: remove blank line after if
Date: Sun,  4 Feb 2018 23:59:32 +0300
Message-Id: <20180204205934.12117-3-mussitantesmortem@gmail.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180204205934.12117-1-mussitantesmortem@gmail.com>
References: <20180204205934.12117-1-mussitantesmortem@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Removed blank line after if.

Signed-off-by: Maxim Zhukov <mussitantesmortem@gmail.com>
---
 drivers/bluetooth/ath3k.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/bluetooth/ath3k.c b/drivers/bluetooth/ath3k.c
index b16c01a0b6d4..4df5b953a40d 100644
--- a/drivers/bluetooth/ath3k.c
+++ b/drivers/bluetooth/ath3k.c
@@ -523,7 +523,6 @@ static int ath3k_probe(struct usb_interface *intf,
 
 	/* load patch and sysconfig files for AR3012 */
 	if (id->driver_info & BTUSB_ATH3012) {
-
 		/* New firmware with patch and sysconfig files already loaded */
 		if (le16_to_cpu(udev->descriptor.bcdDevice) > 0x0001)
 			return -ENODEV;
-- 
2.16.1
