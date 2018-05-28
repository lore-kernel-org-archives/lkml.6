Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S939425AbeE1O7d (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 10:59:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:45372 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1034101AbeE1K0C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:26:02 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hon Weng Chong <honwchong@gmail.com>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Marcel Holtmann <marcel@holtmann.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 266/268] Bluetooth: btusb: Add device ID for RTL8822BE
Date: Mon, 28 May 2018 12:04:00 +0200
Message-Id: <20180528100232.984231861@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100202.045206534@linuxfoundation.org>
References: <20180528100202.045206534@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Larry Finger <Larry.Finger@lwfinger.net>

[ Upstream commit fed03fe7e55b7dc16077f672bd9d7bbe92b3a691 ]

The Asus Z370-I contains a Realtek RTL8822BE device with an associated
BT chip using a USB ID of 0b05:185c. This device is added to the driver.

Signed-off-by: Hon Weng Chong <honwchong@gmail.com>
Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>
Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/bluetooth/btusb.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -346,6 +346,9 @@ static const struct usb_device_id blackl
 	{ USB_DEVICE(0x13d3, 0x3461), .driver_info = BTUSB_REALTEK },
 	{ USB_DEVICE(0x13d3, 0x3462), .driver_info = BTUSB_REALTEK },
 
+	/* Additional Realtek 8822BE Bluetooth devices */
+	{ USB_DEVICE(0x0b05, 0x185c), .driver_info = BTUSB_REALTEK },
+
 	/* Silicon Wave based devices */
 	{ USB_DEVICE(0x0c10, 0x0000), .driver_info = BTUSB_SWAVE },
 
