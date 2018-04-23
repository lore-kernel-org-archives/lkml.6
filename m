Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932565AbeDWWRZ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 18:17:25 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:42880 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932454AbeDWWRW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 18:17:22 -0400
X-Google-Smtp-Source: AIpwx49GnfmSGeTricQjko2EBC6SVxn5DeSA1eA0eTGqJRtdv/6P5+AzXD8qaKUPt3gBzjiHtb7Hxg==
From: Matthias Kaehlcke <mka@chromium.org>
To: Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        Brian Norris <briannorris@chromium.org>, Vic Wei <vwei@codeaurora.org>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH] Bluetooth: btusb: add ID for LiteOn 04ca:301a
Date: Mon, 23 Apr 2018 15:17:07 -0700
Message-Id: <20180423221707.82190-1-mka@chromium.org>
X-Mailer: git-send-email 2.17.0.484.g0c8726318c-goog
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vic Wei <vwei@codeaurora.org>

Contains a QCA6174A chipset, with USB BT. Let's support loading
firmware on it.

>From usb-devices:
T:  Bus=02 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#=  2 Spd=12   MxCh= 0
D:  Ver= 2.01 Cls=e0(wlcon) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=04ca ProdID=301a Rev= 0.01
C:* #Ifs= 2 Cfg#= 1 Atr=e0 MxPwr=100mA
I:* If#= 0 Alt= 0 #EPs= 3 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
I:* If#= 1 Alt= 0 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb

Signed-off-by: Vic Wei <vwei@codeaurora.org>
Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---
 drivers/bluetooth/btusb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 366a49c7c08f..c3a99b1ebb05 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -276,6 +276,7 @@ static const struct usb_device_id blacklist_table[] = {
 	{ USB_DEVICE(0x04ca, 0x3011), .driver_info = BTUSB_QCA_ROME },
 	{ USB_DEVICE(0x04ca, 0x3015), .driver_info = BTUSB_QCA_ROME },
 	{ USB_DEVICE(0x04ca, 0x3016), .driver_info = BTUSB_QCA_ROME },
+	{ USB_DEVICE(0x04ca, 0x301a), .driver_info = BTUSB_QCA_ROME },
 
 	/* Broadcom BCM2035 */
 	{ USB_DEVICE(0x0a5c, 0x2009), .driver_info = BTUSB_BCM92035 },
-- 
2.17.0.484.g0c8726318c-goog
