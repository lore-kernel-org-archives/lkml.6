Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031855AbeEZO5P (ORCPT <rfc822;w@1wt.eu>);
        Sat, 26 May 2018 10:57:15 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:56630 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754669AbeEZO5O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 May 2018 10:57:14 -0400
From: Colin King <colin.king@canonical.com>
To: Lee Jones <lee.jones@linaro.org>
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mfd: timberdale: fix spelling mistake "Uknown" -> "Unknown"
Date: Sat, 26 May 2018 15:57:13 +0100
Message-Id: <20180526145713.10160-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Trivial fix to spelling mistake in dev_err message text

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/mfd/timberdale.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/timberdale.c b/drivers/mfd/timberdale.c
index 33abf5a79f2b..f49168fac223 100644
--- a/drivers/mfd/timberdale.c
+++ b/drivers/mfd/timberdale.c
@@ -777,7 +777,7 @@ static int timb_probe(struct pci_dev *dev,
 			&dev->resource[0], msix_entries[0].vector, NULL);
 		break;
 	default:
-		dev_err(&dev->dev, "Uknown IP setup: %d.%d.%d\n",
+		dev_err(&dev->dev, "Unknown IP setup: %d.%d.%d\n",
 			priv->fw.major, priv->fw.minor, ip_setup);
 		err = -ENODEV;
 		goto err_mfd;
-- 
2.17.0
