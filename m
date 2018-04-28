Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752230AbeD1WLi (ORCPT <rfc822;w@1wt.eu>);
        Sat, 28 Apr 2018 18:11:38 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:46559 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751530AbeD1WLg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Apr 2018 18:11:36 -0400
From: Colin King <colin.king@canonical.com>
To: Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] [media] media/usbvision: fix spelling mistake: "compresion" -> "compression"
Date: Sat, 28 Apr 2018 23:11:34 +0100
Message-Id: <20180428221134.19856-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Trivial fix to spelling mistake in proc text string

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/media/usb/usbvision/usbvision-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/usb/usbvision/usbvision-core.c b/drivers/media/usb/usbvision/usbvision-core.c
index 3f87fbc80be2..7138c2b606cc 100644
--- a/drivers/media/usb/usbvision/usbvision-core.c
+++ b/drivers/media/usb/usbvision/usbvision-core.c
@@ -1857,7 +1857,7 @@ int usbvision_stream_interrupt(struct usb_usbvision *usbvision)
 
 static int usbvision_set_compress_params(struct usb_usbvision *usbvision)
 {
-	static const char proc[] = "usbvision_set_compresion_params: ";
+	static const char proc[] = "usbvision_set_compression_params: ";
 	int rc;
 	unsigned char *value = usbvision->ctrl_urb_buffer;
 
-- 
2.17.0
