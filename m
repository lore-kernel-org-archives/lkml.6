Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1425427AbeCBJKm (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 04:10:42 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:45301 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1425343AbeCBJKd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 04:10:33 -0500
From: Colin King <colin.king@canonical.com>
To: Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
        linux-ia64@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ia64/err-inject: fix spelling mistake: "capapbilities" -> "capabilities"
Date: Fri,  2 Mar 2018 09:10:30 +0000
Message-Id: <20180302091030.25897-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.15.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Trivial fix to spelling mistake in debug message text.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 arch/ia64/kernel/err_inject.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/ia64/kernel/err_inject.c b/arch/ia64/kernel/err_inject.c
index 85bba43e7d5d..34e460bd8a95 100644
--- a/arch/ia64/kernel/err_inject.c
+++ b/arch/ia64/kernel/err_inject.c
@@ -117,7 +117,7 @@ store_call_start(struct device *dev, struct device_attribute *attr,
 
 #ifdef ERR_INJ_DEBUG
 	printk(KERN_DEBUG "Returns: status=%d,\n", (int)status[cpu]);
-	printk(KERN_DEBUG "capapbilities=%lx,\n", capabilities[cpu]);
+	printk(KERN_DEBUG "capabilities=%lx,\n", capabilities[cpu]);
 	printk(KERN_DEBUG "resources=%lx\n", resources[cpu]);
 #endif
 	return size;
-- 
2.15.1
