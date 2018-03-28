Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751191AbeC1XS5 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 19:18:57 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:55278 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750733AbeC1XSz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 19:18:55 -0400
From: Colin King <colin.king@canonical.com>
To: Chas Williams <3chas3@gmail.com>,
        linux-atm-general@lists.sourceforge.net, netdev@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] atm: iphase: fix spelling mistake: "Receiverd" -> "Received"
Date: Thu, 29 Mar 2018 00:18:53 +0100
Message-Id: <20180328231853.28461-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.15.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Trivial fix to spelling mistake in message text

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/atm/iphase.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/atm/iphase.c b/drivers/atm/iphase.c
index 98a3a43484c8..44abb8a0a5e5 100644
--- a/drivers/atm/iphase.c
+++ b/drivers/atm/iphase.c
@@ -3147,7 +3147,7 @@ static int ia_proc_read(struct atm_dev *dev,loff_t *pos,char *page)
                            "  Size of Tx Buffer  :  %u\n"
                            "  Number of Rx Buffer:  %u\n"
                            "  Size of Rx Buffer  :  %u\n"
-                           "  Packets Receiverd  :  %u\n"
+                           "  Packets Received   :  %u\n"
                            "  Packets Transmitted:  %u\n"
                            "  Cells Received     :  %u\n"
                            "  Cells Transmitted  :  %u\n"
-- 
2.15.1
