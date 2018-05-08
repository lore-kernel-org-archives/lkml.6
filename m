Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932493AbeEHVyk (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 17:54:40 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:43079 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755433AbeEHVyi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 17:54:38 -0400
From: Colin King <colin.king@canonical.com>
To: Bradley Grove <linuxdrivers@attotech.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] scsi: esas2r: fix spelling mistake: "requestss" -> "requests"
Date: Tue,  8 May 2018 22:54:35 +0100
Message-Id: <20180508215435.20190-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Trivial fix to spelling mistake in esas2r_debug message

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/scsi/esas2r/esas2r_ioctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/esas2r/esas2r_ioctl.c b/drivers/scsi/esas2r/esas2r_ioctl.c
index 97623002908f..34bcc8c04ff4 100644
--- a/drivers/scsi/esas2r/esas2r_ioctl.c
+++ b/drivers/scsi/esas2r/esas2r_ioctl.c
@@ -1849,7 +1849,7 @@ int esas2r_read_vda(struct esas2r_adapter *a, char *buf, long off, int count)
 		/* allocate a request */
 		rq = esas2r_alloc_request(a);
 		if (rq == NULL) {
-			esas2r_debug("esas2r_read_vda: out of requestss");
+			esas2r_debug("esas2r_read_vda: out of requests");
 			return -EBUSY;
 		}
 
-- 
2.17.0
