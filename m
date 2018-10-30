Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 814D4C2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 11:13:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A2DB2082B
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 11:13:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A2DB2082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727807AbeJ3UGj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 16:06:39 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:48618 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727689AbeJ3UGi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 16:06:38 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1gHRxl-000461-Sw; Tue, 30 Oct 2018 11:13:33 +0000
From:   Colin King <colin.king@canonical.com>
To:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: vt6656: clean up few indentation issues
Date:   Tue, 30 Oct 2018 11:13:33 +0000
Message-Id: <20181030111333.3181-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Trivial fix to clean up indentation issues

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/staging/vt6656/firmware.c | 2 +-
 drivers/staging/vt6656/main_usb.c | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/vt6656/firmware.c b/drivers/staging/vt6656/firmware.c
index 38521c338917..205347cff7c4 100644
--- a/drivers/staging/vt6656/firmware.c
+++ b/drivers/staging/vt6656/firmware.c
@@ -42,7 +42,7 @@ int vnt_download_firmware(struct vnt_private *priv)
 	if (rc) {
 		dev_err(dev, "firmware file %s request failed (%d)\n",
 			FIRMWARE_NAME, rc);
-			goto out;
+		goto out;
 	}
 
 	buffer = kmalloc(FIRMWARE_CHUNK_SIZE, GFP_KERNEL);
diff --git a/drivers/staging/vt6656/main_usb.c b/drivers/staging/vt6656/main_usb.c
index ccafcc2c87ac..b613a1d113bb 100644
--- a/drivers/staging/vt6656/main_usb.c
+++ b/drivers/staging/vt6656/main_usb.c
@@ -245,10 +245,10 @@ static int vnt_init_registers(struct vnt_private *priv)
 		} else {
 			priv->tx_antenna_mode = ANT_B;
 
-		if (priv->tx_rx_ant_inv)
-			priv->rx_antenna_mode = ANT_A;
-		else
-			priv->rx_antenna_mode = ANT_B;
+			if (priv->tx_rx_ant_inv)
+				priv->rx_antenna_mode = ANT_A;
+			else
+				priv->rx_antenna_mode = ANT_B;
 		}
 	}
 
-- 
2.19.1

