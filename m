Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753145AbeBTQ1M (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 11:27:12 -0500
Received: from mail-lf0-f67.google.com ([209.85.215.67]:40873 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752907AbeBTQZ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 11:25:56 -0500
X-Google-Smtp-Source: AH8x2248UdeQQ75nw1DFZ2AgVk6WCGT14v/F+igjc/5lxgR6Q4kbCsbj5EOkdt0nBUslVCLb9TewNg==
From: Dmitry Osipenko <digetx@gmail.com>
To: Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>
Cc: devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 08/15] memory: tegra: Remove unused headers inclusions
Date: Tue, 20 Feb 2018 19:25:21 +0300
Message-Id: <637f4a311b576b9361a580019980bbf0329b9e49.1519141896.git.digetx@gmail.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <cover.1519141896.git.digetx@gmail.com>
References: <cover.1519141896.git.digetx@gmail.com>
In-Reply-To: <cover.1519141896.git.digetx@gmail.com>
References: <cover.1519141896.git.digetx@gmail.com>
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
2.16.1
