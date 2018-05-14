Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932318AbeENNgR (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 09:36:17 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:42708 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752897AbeENNe7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 09:34:59 -0400
From: Robin Murphy <robin.murphy@arm.com>
To: will.deacon@arm.com, mark.rutland@arm.com
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        pawel.moll@arm.com, suzuki.poulose@arm.com
Subject: [PATCH v2 1/3] perf/arm-cc*: Fix MODULE_LICENSE() tags
Date: Mon, 14 May 2018 14:34:51 +0100
Message-Id: <d62c107dcd95ff209cfa87d0165d8987aa5453a9.1526303815.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.17.0.dirty
In-Reply-To: <cover.1526303815.git.robin.murphy@arm.com>
References: <cover.1526303815.git.robin.murphy@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The CCI/CCN drivers are licensed under GPLv2, but the MODULE_LICENSE()
tags are using the bare "GPL" string implying GPLv2 or later. Fix them
to match their actual file license.

Acked-by: Pawel Moll <pawel.moll@arm.com>
Acked-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---

v2: No change

 drivers/perf/arm-cci.c | 2 +-
 drivers/perf/arm-ccn.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/perf/arm-cci.c b/drivers/perf/arm-cci.c
index 383b2d3dcbc6..53c774b20563 100644
--- a/drivers/perf/arm-cci.c
+++ b/drivers/perf/arm-cci.c
@@ -1718,5 +1718,5 @@ static struct platform_driver cci_pmu_driver = {
 };
 
 builtin_platform_driver(cci_pmu_driver);
-MODULE_LICENSE("GPL");
+MODULE_LICENSE("GPL v2");
 MODULE_DESCRIPTION("ARM CCI PMU support");
diff --git a/drivers/perf/arm-ccn.c b/drivers/perf/arm-ccn.c
index 65b7e4042ece..917b47e776df 100644
--- a/drivers/perf/arm-ccn.c
+++ b/drivers/perf/arm-ccn.c
@@ -1594,4 +1594,4 @@ module_init(arm_ccn_init);
 module_exit(arm_ccn_exit);
 
 MODULE_AUTHOR("Pawel Moll <pawel.moll@arm.com>");
-MODULE_LICENSE("GPL");
+MODULE_LICENSE("GPL v2");
-- 
2.17.0.dirty
