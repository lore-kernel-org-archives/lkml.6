Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932984AbeCSLcl (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 07:32:41 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:55968 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755299AbeCSLch (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 07:32:37 -0400
X-Google-Smtp-Source: AG47ELsnfyUhRrVA5H+XyNZMtfjBlKJIgw5IHFC8nFErHCrNdBHm9ml/IykDwaGw1GwpbRkvVLGcbA==
From: Paul McQuade <paulmcquad@gmail.com>
To: paulmcquad@gmail.com
Cc: marcel@holtmann.org, johan.hedberg@gmail.com,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] Bluetooth: trailing whitespace
Date: Mon, 19 Mar 2018 11:32:19 +0000
Message-Id: <20180319113222.6725-1-paulmcquad@gmail.com>
X-Mailer: git-send-email 2.16.2
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Removed whitespace

Signed-off-by: Paul McQuade <paulmcquad@gmail.com>
---
 drivers/bluetooth/bfusb.c     | 2 +-
 drivers/bluetooth/btuart_cs.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/bluetooth/bfusb.c b/drivers/bluetooth/bfusb.c
index ab090a313a5f..0d5b403fe431 100644
--- a/drivers/bluetooth/bfusb.c
+++ b/drivers/bluetooth/bfusb.c
@@ -148,7 +148,7 @@ static int bfusb_send_bulk(struct bfusb_data *data, struct sk_buff *skb)
 
 	err = usb_submit_urb(urb, GFP_ATOMIC);
 	if (err) {
-		BT_ERR("%s bulk tx submit failed urb %p err %d", 
+		BT_ERR("%s bulk tx submit failed urb %p err %d",
 					data->hdev->name, urb, err);
 		skb_unlink(skb, &data->pending_q);
 		usb_free_urb(urb);
diff --git a/drivers/bluetooth/btuart_cs.c b/drivers/bluetooth/btuart_cs.c
index 310e9c2e09b6..8dce5bfad947 100644
--- a/drivers/bluetooth/btuart_cs.c
+++ b/drivers/bluetooth/btuart_cs.c
@@ -365,10 +365,10 @@ static void btuart_change_speed(struct btuart_info *info,
 
 	fcr = UART_FCR_ENABLE_FIFO | UART_FCR_CLEAR_RCVR | UART_FCR_CLEAR_XMIT;
 
-	/* 
+	/*
 	 * Use trigger level 1 to avoid 3 ms. timeout delay at 9600 bps, and
 	 * almost 1,7 ms at 19200 bps. At speeds above that we can just forget
-	 * about this timeout since it will always be fast enough. 
+	 * about this timeout since it will always be fast enough.
 	 */
 
 	if (speed < 38400)
-- 
2.16.2
