Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967212AbeBNKat (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 05:30:49 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:35539 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754564AbeBNKas (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 05:30:48 -0500
From: Colin King <colin.king@canonical.com>
To: Hannes Reinecke <hare@suse.de>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][scsi-next] scsi: myrs: Fix spelling mistake: "Cashe"-> "Cache"
Date: Wed, 14 Feb 2018 10:30:43 +0000
Message-Id: <20180214103043.3112-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.15.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Trivial fix to spelling mistake in info message text.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/scsi/myrs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/myrs.c b/drivers/scsi/myrs.c
index 3b87c6942a8e..16498e1b0dd4 100644
--- a/drivers/scsi/myrs.c
+++ b/drivers/scsi/myrs.c
@@ -1571,7 +1571,7 @@ static ssize_t myrs_store_flush_cache(struct device *dev,
 		return count;
 	}
 	shost_printk(KERN_INFO, shost,
-		     "Cashe Flush failed, status 0x%02x\n", status);
+		     "Cache Flush failed, status 0x%02x\n", status);
 	return -EIO;
 }
 static DEVICE_ATTR(flush_cache, S_IWUSR, NULL, myrs_store_flush_cache);
-- 
2.15.1
