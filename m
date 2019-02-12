Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20612C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 14:05:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7B70214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 14:05:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730145AbfBLOFO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 09:05:14 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:39286 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728126AbfBLOFO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 09:05:14 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1gtYgP-0001PX-51; Tue, 12 Feb 2019 14:05:09 +0000
From:   Colin King <colin.king@canonical.com>
To:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Zhou <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Rex Zhu <rex.zhu@amd.com>,
        Evan Quan <evan.quan@amd.com>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/amdgpu: fix several indentation issues
Date:   Tue, 12 Feb 2019 14:05:08 +0000
Message-Id: <20190212140508.9296-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There are several statements that are incorrectly indented. Fix these.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c              | 2 +-
 drivers/gpu/drm/amd/amdgpu/dce_v6_0.c                | 2 +-
 drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c               | 2 +-
 drivers/gpu/drm/amd/amdgpu/si.c                      | 2 +-
 drivers/gpu/drm/amd/powerplay/hwmgr/smu7_powertune.c | 2 +-
 drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c   | 2 +-
 6 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index bc62bf41b7e9..b65e18101108 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -207,7 +207,7 @@ int amdgpu_driver_load_kms(struct drm_device *dev, unsigned long flags)
 	if (!r) {
 		acpi_status = amdgpu_acpi_init(adev);
 		if (acpi_status)
-		dev_dbg(&dev->pdev->dev,
+			dev_dbg(&dev->pdev->dev,
 				"Error during ACPI methods call\n");
 	}
 
diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
index db443ec53d3a..bea32f076b91 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
@@ -2980,7 +2980,7 @@ static int dce_v6_0_pageflip_irq(struct amdgpu_device *adev,
 				 struct amdgpu_irq_src *source,
 				 struct amdgpu_iv_entry *entry)
 {
-		unsigned long flags;
+	unsigned long flags;
 	unsigned crtc_id;
 	struct amdgpu_crtc *amdgpu_crtc;
 	struct amdgpu_flip_work *works;
diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c b/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
index 221f26e50322..c69d51598cfe 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
@@ -32,7 +32,7 @@
 
 static u32 nbio_v7_4_get_rev_id(struct amdgpu_device *adev)
 {
-    u32 tmp = RREG32_SOC15(NBIO, 0, mmRCC_DEV0_EPF0_STRAP0);
+	u32 tmp = RREG32_SOC15(NBIO, 0, mmRCC_DEV0_EPF0_STRAP0);
 
 	tmp &= RCC_DEV0_EPF0_STRAP0__STRAP_ATI_REV_ID_DEV0_F0_MASK;
 	tmp >>= RCC_DEV0_EPF0_STRAP0__STRAP_ATI_REV_ID_DEV0_F0__SHIFT;
diff --git a/drivers/gpu/drm/amd/amdgpu/si.c b/drivers/gpu/drm/amd/amdgpu/si.c
index 79c1a9bbcc21..9d8df68893b9 100644
--- a/drivers/gpu/drm/amd/amdgpu/si.c
+++ b/drivers/gpu/drm/amd/amdgpu/si.c
@@ -1436,7 +1436,7 @@ static int si_common_early_init(void *handle)
 			AMD_CG_SUPPORT_UVD_MGCG |
 			AMD_CG_SUPPORT_HDP_LS |
 			AMD_CG_SUPPORT_HDP_MGCG;
-			adev->pg_flags = 0;
+		adev->pg_flags = 0;
 		adev->external_rev_id = (adev->rev_id == 0) ? 1 :
 					(adev->rev_id == 1) ? 5 : 6;
 		break;
diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_powertune.c b/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_powertune.c
index d138ddae563d..58f5589aaf12 100644
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_powertune.c
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_powertune.c
@@ -1211,7 +1211,7 @@ int smu7_power_control_set_level(struct pp_hwmgr *hwmgr)
 				hwmgr->platform_descriptor.TDPAdjustment :
 				(-1 * hwmgr->platform_descriptor.TDPAdjustment);
 
-		 if (hwmgr->chip_id > CHIP_TONGA)
+		if (hwmgr->chip_id > CHIP_TONGA)
 			target_tdp = ((100 + adjust_percent) * (int)(cac_table->usTDP * 256)) / 100;
 		else
 			target_tdp = ((100 + adjust_percent) * (int)(cac_table->usConfigurableTDP * 256)) / 100;
diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c b/drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c
index 0769b1ec562b..aad79affb081 100644
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c
@@ -3456,7 +3456,7 @@ static int vega20_apply_clocks_adjust_rules(struct pp_hwmgr *hwmgr)
 	disable_mclk_switching = ((1 < hwmgr->display_config->num_display) &&
                            !hwmgr->display_config->multi_monitor_in_sync) ||
                             vblank_too_short;
-    latency = hwmgr->display_config->dce_tolerable_mclk_in_active_latency;
+	latency = hwmgr->display_config->dce_tolerable_mclk_in_active_latency;
 
 	/* gfxclk */
 	dpm_table = &(data->dpm_table.gfx_table);
-- 
2.20.1

