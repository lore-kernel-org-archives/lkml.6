Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753332AbeDMHHB (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 03:07:01 -0400
Received: from mail-yw0-f195.google.com ([209.85.161.195]:46814 "EHLO
        mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750955AbeDMHHA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 03:07:00 -0400
X-Google-Smtp-Source: AIpwx4+XKHOr+et7FOcdYjPpnDZV3qhofVDhVrE+rcNSnDIncFO+9tmNbvfgsHv6p7nOIVj6HnXfPg==
From: Greg Thelen <gthelen@google.com>
To: Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        Greg Thelen <gthelen@google.com>, Tarick Bedeir <tarick@google.com>
Subject: [PATCH] IB: make INFINIBAND_ADDR_TRANS configurable
Date: Fri, 13 Apr 2018 00:06:44 -0700
Message-Id: <20180413070644.11974-1-gthelen@google.com>
X-Mailer: git-send-email 2.17.0.484.g0c8726318c-goog
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow INFINIBAND without INFINIBAND_ADDR_TRANS.

Signed-off-by: Greg Thelen <gthelen@google.com>
Cc: Tarick Bedeir <tarick@google.com>
---
 drivers/infiniband/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/Kconfig b/drivers/infiniband/Kconfig
index ee270e065ba9..f20a3977087c 100644
--- a/drivers/infiniband/Kconfig
+++ b/drivers/infiniband/Kconfig
@@ -61,7 +61,7 @@ config INFINIBAND_ON_DEMAND_PAGING
 	  pages on demand instead.
 
 config INFINIBAND_ADDR_TRANS
-	bool
+	bool "InfiniBand address translation"
 	depends on INFINIBAND
 	default y
 
-- 
2.17.0.484.g0c8726318c-goog
