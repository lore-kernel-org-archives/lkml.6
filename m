Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967703AbeBNM3N (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 07:29:13 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:56154 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967394AbeBNM3M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 07:29:12 -0500
X-Google-Smtp-Source: AH8x225RyOs9VtCNnl1bGRlMaZWZmKMuMg3h4ojX28/EMu5c8tv3Gj95Cnt+kvY8QS6Srj98RKPWRA==
From: Corentin Labbe <clabbe@baylibre.com>
To: David1.Zhou@amd.com, airlied@linux.ie, alexander.deucher@amd.com,
        christian.koenig@amd.com
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v2 00/13] gpu: drm: amd: remove unused headers
Date: Wed, 14 Feb 2018 12:28:38 +0000
Message-Id: <1518611331-13144-1-git-send-email-clabbe@baylibre.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

This patchset remove several headers which are not used by any source
file.

Regards

Changes since v1:
- splited in multiple patchs

Corentin Labbe (13):
  drm/amd/include: remove unused asic_reg/oss headers
  drm/amd/include: remove unused asic_reg/bif headers
  drm/amd/include: remove unused asic_reg/dce headers
  drm/amd/include: remove unused asic_reg/gca headers
  drm/amd/include: remove unused asic_reg/gmc headers
  drm/amd/include: remove unused asic_reg/smu headers
  drm/amd/include: remove unused asic_reg/umc headers
  drm/amd/include: remove unused asic_reg/uvd headers
  drm/amd/include: remove unused asic_reg/vce headers
  drm/amd/include: remove unused asic_reg/sdma headers
  drm/amd/include: remove unused asic_reg/nbif headers
  drm/amd/include: remove unused displayobject.h header
  drm/amd/powerplay: remove unused headers

 .../drm/amd/include/asic_reg/bif/bif_5_0_enum.h    |  1198 --
 .../drm/amd/include/asic_reg/bif/bif_5_1_enum.h    |  1068 -
 .../drm/amd/include/asic_reg/dce/dce_11_2_enum.h   |  6813 ------
 .../drm/amd/include/asic_reg/dce/dce_8_0_enum.h    |  1117 -
 .../gpu/drm/amd/include/asic_reg/gca/gfx_8_1_d.h   |  2791 ---
 .../drm/amd/include/asic_reg/gca/gfx_8_1_enum.h    |  6808 ------
 .../drm/amd/include/asic_reg/gca/gfx_8_1_sh_mask.h | 21368 -------------------
 .../drm/amd/include/asic_reg/gmc/gmc_8_1_enum.h    |  1198 --
 .../drm/amd/include/asic_reg/gmc/gmc_8_2_enum.h    |  1068 -
 .../amd/include/asic_reg/nbif/nbif_6_1_sh_mask.h   | 10281 ---------
 .../drm/amd/include/asic_reg/oss/oss_2_4_enum.h    |  1340 --
 .../drm/amd/include/asic_reg/oss/oss_3_0_1_enum.h  |  1464 --
 .../drm/amd/include/asic_reg/oss/oss_3_0_enum.h    |  1497 --
 .../amd/include/asic_reg/sdma0/sdma0_4_0_default.h |   286 -
 .../amd/include/asic_reg/sdma1/sdma1_4_0_default.h |   282 -
 .../gpu/drm/amd/include/asic_reg/smu/smu_6_0_d.h   |   148 -
 .../drm/amd/include/asic_reg/smu/smu_6_0_sh_mask.h |   715 -
 .../gpu/drm/amd/include/asic_reg/smu/smu_7_1_0_d.h |  1344 --
 .../drm/amd/include/asic_reg/smu/smu_7_1_0_enum.h  |  1191 --
 .../amd/include/asic_reg/smu/smu_7_1_0_sh_mask.h   |  5648 -----
 .../drm/amd/include/asic_reg/smu/smu_7_1_1_enum.h  |  1205 --
 .../drm/amd/include/asic_reg/smu/smu_7_1_2_enum.h  |  1246 --
 .../drm/amd/include/asic_reg/smu/smu_7_1_3_enum.h  |  1282 --
 .../drm/amd/include/asic_reg/smu/smu_8_0_enum.h    |  1072 -
 .../drm/amd/include/asic_reg/umc/umc_6_0_default.h |    31 -
 .../drm/amd/include/asic_reg/umc/umc_6_0_offset.h  |    52 -
 .../drm/amd/include/asic_reg/uvd/uvd_4_0_sh_mask.h |   795 -
 .../drm/amd/include/asic_reg/uvd/uvd_5_0_enum.h    |  1211 --
 .../drm/amd/include/asic_reg/uvd/uvd_6_0_enum.h    |  1081 -
 .../gpu/drm/amd/include/asic_reg/vce/vce_1_0_d.h   |    64 -
 .../drm/amd/include/asic_reg/vce/vce_1_0_sh_mask.h |    99 -
 drivers/gpu/drm/amd/include/displayobject.h        |   249 -
 .../gpu/drm/amd/powerplay/inc/polaris10_ppsmc.h    |   412 -
 drivers/gpu/drm/amd/powerplay/inc/pp_feature.h     |    67 -
 34 files changed, 76491 deletions(-)
 delete mode 100644 drivers/gpu/drm/amd/include/asic_reg/bif/bif_5_0_enum.h
 delete mode 100644 drivers/gpu/drm/amd/include/asic_reg/bif/bif_5_1_enum.h
 delete mode 100644 drivers/gpu/drm/amd/include/asic_reg/dce/dce_11_2_enum.h
 delete mode 100644 drivers/gpu/drm/amd/include/asic_reg/dce/dce_8_0_enum.h
 delete mode 100644 drivers/gpu/drm/amd/include/asic_reg/gca/gfx_8_1_d.h
 delete mode 100644 drivers/gpu/drm/amd/include/asic_reg/gca/gfx_8_1_enum.h
 delete mode 100644 drivers/gpu/drm/amd/include/asic_reg/gca/gfx_8_1_sh_mask.h
 delete mode 100644 drivers/gpu/drm/amd/include/asic_reg/gmc/gmc_8_1_enum.h
 delete mode 100644 drivers/gpu/drm/amd/include/asic_reg/gmc/gmc_8_2_enum.h
 delete mode 100644 drivers/gpu/drm/amd/include/asic_reg/nbif/nbif_6_1_sh_mask.h
 delete mode 100644 drivers/gpu/drm/amd/include/asic_reg/oss/oss_2_4_enum.h
 delete mode 100644 drivers/gpu/drm/amd/include/asic_reg/oss/oss_3_0_1_enum.h
 delete mode 100644 drivers/gpu/drm/amd/include/asic_reg/oss/oss_3_0_enum.h
 delete mode 100644 drivers/gpu/drm/amd/include/asic_reg/sdma0/sdma0_4_0_default.h
 delete mode 100644 drivers/gpu/drm/amd/include/asic_reg/sdma1/sdma1_4_0_default.h
 delete mode 100644 drivers/gpu/drm/amd/include/asic_reg/smu/smu_6_0_d.h
 delete mode 100644 drivers/gpu/drm/amd/include/asic_reg/smu/smu_6_0_sh_mask.h
 delete mode 100644 drivers/gpu/drm/amd/include/asic_reg/smu/smu_7_1_0_d.h
 delete mode 100644 drivers/gpu/drm/amd/include/asic_reg/smu/smu_7_1_0_enum.h
 delete mode 100644 drivers/gpu/drm/amd/include/asic_reg/smu/smu_7_1_0_sh_mask.h
 delete mode 100644 drivers/gpu/drm/amd/include/asic_reg/smu/smu_7_1_1_enum.h
 delete mode 100644 drivers/gpu/drm/amd/include/asic_reg/smu/smu_7_1_2_enum.h
 delete mode 100644 drivers/gpu/drm/amd/include/asic_reg/smu/smu_7_1_3_enum.h
 delete mode 100644 drivers/gpu/drm/amd/include/asic_reg/smu/smu_8_0_enum.h
 delete mode 100644 drivers/gpu/drm/amd/include/asic_reg/umc/umc_6_0_default.h
 delete mode 100644 drivers/gpu/drm/amd/include/asic_reg/umc/umc_6_0_offset.h
 delete mode 100644 drivers/gpu/drm/amd/include/asic_reg/uvd/uvd_4_0_sh_mask.h
 delete mode 100644 drivers/gpu/drm/amd/include/asic_reg/uvd/uvd_5_0_enum.h
 delete mode 100644 drivers/gpu/drm/amd/include/asic_reg/uvd/uvd_6_0_enum.h
 delete mode 100644 drivers/gpu/drm/amd/include/asic_reg/vce/vce_1_0_d.h
 delete mode 100644 drivers/gpu/drm/amd/include/asic_reg/vce/vce_1_0_sh_mask.h
 delete mode 100644 drivers/gpu/drm/amd/include/displayobject.h
 delete mode 100644 drivers/gpu/drm/amd/powerplay/inc/polaris10_ppsmc.h
 delete mode 100644 drivers/gpu/drm/amd/powerplay/inc/pp_feature.h

-- 
2.13.6
