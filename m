Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751911AbeE0Vpa (ORCPT <rfc822;w@1wt.eu>);
        Sun, 27 May 2018 17:45:30 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:55703 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751547AbeE0Vp1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 May 2018 17:45:27 -0400
X-Google-Smtp-Source: AB8JxZoikRRRq1ds+TT+Rp9kwoLWRYA0S4ZtBw7qQ0nFkJ4/wrKqLMLNpCvIdXOb5/EdIPvVX3egZw==
From: Artiom Vaskov <velemas@gmail.com>
Cc: honwchong@gmail.com, Larry.Finger@lwfinger.net,
        Artiom Vaskov <velemas@gmail.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Bluetooth: btusb: Add additional device ID for RTL8822BE
Date: Mon, 28 May 2018 00:44:01 +0300
Message-Id: <20180527214402.12831-1-velemas@gmail.com>
X-Mailer: git-send-email 2.17.0
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Asus ROG GL702ZC laptop contains a Realtek RTL8822BE device with
an associated BT chip using a USB ID of 13d3:3526. This ID is added
to the driver.

Signed-off-by: Artiom Vaskov <velemas@gmail.com>
---
 drivers/bluetooth/btusb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index b937cc1e2c07..34e5aedd4e27 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -379,6 +379,7 @@ static const struct usb_device_id blacklist_table[] = {
 	{ USB_DEVICE(0x13d3, 0x3462), .driver_info = BTUSB_REALTEK },
 
 	/* Additional Realtek 8822BE Bluetooth devices */
+	{ USB_DEVICE(0x13d3, 0x3526), .driver_info = BTUSB_REALTEK },
 	{ USB_DEVICE(0x0b05, 0x185c), .driver_info = BTUSB_REALTEK },
 
 	/* Silicon Wave based devices */
-- 
2.17.0
