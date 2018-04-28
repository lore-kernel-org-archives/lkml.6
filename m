Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752143AbeD1WWC (ORCPT <rfc822;w@1wt.eu>);
        Sat, 28 Apr 2018 18:22:02 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:46635 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751310AbeD1WWB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Apr 2018 18:22:01 -0400
From: Colin King <colin.king@canonical.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Zhou <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>,
        Rex Zhu <Rex.Zhu@amd.com>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/amd/powerplay: fix spelling mistake: "contruct" -> "construct"
Date: Sat, 28 Apr 2018 23:21:55 +0100
Message-Id: <20180428222155.20242-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Trivial fix to spelling mistake in PP_ASSERT_WITH_CODE message text

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c   | 2 +-
 drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c b/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c
index 26fbeafc3c96..726994cf03ea 100644
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c
@@ -1229,7 +1229,7 @@ static int smu7_enable_dpm_tasks(struct pp_hwmgr *hwmgr)
 
 		tmp_result = smu7_construct_voltage_tables(hwmgr);
 		PP_ASSERT_WITH_CODE((0 == tmp_result),
-				"Failed to contruct voltage tables!",
+				"Failed to construct voltage tables!",
 				result = tmp_result);
 	}
 	smum_initialize_mc_reg_table(hwmgr);
diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c b/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c
index 7cbb56ba6fab..ced1c2aab7a9 100644
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c
@@ -2829,7 +2829,7 @@ static int vega10_enable_dpm_tasks(struct pp_hwmgr *hwmgr)
 
 	tmp_result = vega10_construct_voltage_tables(hwmgr);
 	PP_ASSERT_WITH_CODE(!tmp_result,
-			"Failed to contruct voltage tables!",
+			"Failed to construct voltage tables!",
 			result = tmp_result);
 
 	tmp_result = vega10_init_smc_table(hwmgr);
-- 
2.17.0
