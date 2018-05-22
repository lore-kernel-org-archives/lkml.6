Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751443AbeEVI33 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 04:29:29 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:58585 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751324AbeEVI31 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 04:29:27 -0400
From: Colin King <colin.king@canonical.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?q?Christian=20L=C3=BCtke-Stetzkamp?= <christian@lkamp.de>,
        NeilBrown <neil@brown.name>, devel@driverdev.osuosl.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: mt7621-mmc: fix spelling mistake: "Illgal" -> "Illegal"
Date: Tue, 22 May 2018 09:29:22 +0100
Message-Id: <20180522082922.5538-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Trivial fix to another spelling mistake in N_MSG message text

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/staging/mt7621-mmc/sd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/mt7621-mmc/sd.c b/drivers/staging/mt7621-mmc/sd.c
index 11bf4b4c3403..648a2dd1436e 100644
--- a/drivers/staging/mt7621-mmc/sd.c
+++ b/drivers/staging/mt7621-mmc/sd.c
@@ -388,7 +388,7 @@ static void msdc_dump_io_resp(struct msdc_host *host, u32 resp)
 	if (flags & (1 << 7))
 		N_MSG(RSP, "[IO] COM_CRC_ERR");
 	if (flags & (1 << 6))
-		N_MSG(RSP, "[IO] Illgal command");
+		N_MSG(RSP, "[IO] Illegal command");
 	if (flags & (1 << 3))
 		N_MSG(RSP, "[IO] Error");
 	if (flags & (1 << 2))
-- 
2.17.0
