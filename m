Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753937AbeDITaf (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 15:30:35 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:53886 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752781AbeDIT37 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 15:29:59 -0400
X-Google-Smtp-Source: AIpwx4/84dBRcqTovXthOTtQ6tbr9KkO+jwQxB9swe2AXV5Cd6g7N5zlal4LLyxq7zLUYIqAHuDyZA==
From: Dmitry Osipenko <digetx@gmail.com>
To: Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc: Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 08/15] memory: tegra: Remove unused headers inclusions
Date: Mon,  9 Apr 2018 22:28:30 +0300
Message-Id: <1edd1ed575d21c96f0810bd226bee4b5c315f3db.1523301400.git.digetx@gmail.com>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <cover.1523301400.git.digetx@gmail.com>
References: <cover.1523301400.git.digetx@gmail.com>
In-Reply-To: <cover.1523301400.git.digetx@gmail.com>
References: <cover.1523301400.git.digetx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tegra210 contains some unused leftover headers, remove them for
consistency.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/memory/tegra/tegra210.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/memory/tegra/tegra210.c b/drivers/memory/tegra/tegra210.c
index 3b8d0100088c..b729f49ffc8f 100644
--- a/drivers/memory/tegra/tegra210.c
+++ b/drivers/memory/tegra/tegra210.c
@@ -6,11 +6,6 @@
  * published by the Free Software Foundation.
  */
 
-#include <linux/of.h>
-#include <linux/mm.h>
-
-#include <asm/cacheflush.h>
-
 #include <dt-bindings/memory/tegra210-mc.h>
 
 #include "mc.h"
-- 
2.16.3
