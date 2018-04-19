Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753637AbeDSRmX (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 13:42:23 -0400
Received: from sauhun.de ([88.99.104.3]:47114 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753586AbeDSRmU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 13:42:20 -0400
From: Wolfram Sang <wsa@the-dreams.de>
To: linux-kernel@vger.kernel.org
Cc: Wolfram Sang <wsa@the-dreams.de>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>, linux-input@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: [PATCH] MAINTAINERS: Rakesh Iyer can't be reached anymore
Date: Thu, 19 Apr 2018 19:42:01 +0200
Message-Id: <20180419174211.2532-1-wsa@the-dreams.de>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current mail address is rejected, last activity (with a different
address) in git-history is from 2012. Remove this.

Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
---

If somebody knows a recent address, then we can simply update, of course.

 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index c4b6d379423e..0307426c2564 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13833,7 +13833,6 @@ S:	Supported
 F:	drivers/iommu/tegra*
 
 TEGRA KBC DRIVER
-M:	Rakesh Iyer <riyer@nvidia.com>
 M:	Laxman Dewangan <ldewangan@nvidia.com>
 S:	Supported
 F:	drivers/input/keyboard/tegra-kbc.c
-- 
2.11.0
