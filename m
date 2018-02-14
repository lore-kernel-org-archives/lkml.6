Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031015AbeBNOqv (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 09:46:51 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:54333 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030986AbeBNOqr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 09:46:47 -0500
X-Google-Smtp-Source: AH8x227PRdOpqY1AGXWmrQf1X9BSw3ucUAR7AnBG7/3Xd/3q2oweyV/lCUE14m3AEz3IUKDyXuJ2nQ==
From: Corentin Labbe <clabbe@baylibre.com>
To: David1.Zhou@amd.com, airlied@linux.ie, alexander.deucher@amd.com,
        christian.koenig@amd.com
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v3 06/13] drm/amd/include: remove unused asic_reg/smu headers
Date: Wed, 14 Feb 2018 14:46:10 +0000
Message-Id: <1518619577-19771-7-git-send-email-clabbe@baylibre.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1518619577-19771-1-git-send-email-clabbe@baylibre.com>
References: <1518619577-19771-1-git-send-email-clabbe@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All thoses headers are not used by any source files.
Lets just remove them.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 .../gpu/drm/amd/include/asic_reg/smu/smu_6_0_d.h   |  148 -
 .../drm/amd/include/asic_reg/smu/smu_6_0_sh_mask.h |  715 ---
 .../gpu/drm/amd/include/asic_reg/smu/smu_7_1_0_d.h | 1344 -----
 .../drm/amd/include/asic_reg/smu/smu_7_1_0_enum.h  | 1191 -----
 .../amd/include/asic_reg/smu/smu_7_1_0_sh_mask.h   | 5648 --------------------
 .../drm/amd/include/asic_reg/smu/smu_7_1_1_enum.h  | 1205 -----
 .../drm/amd/include/asic_reg/smu/smu_7_1_2_enum.h  | 1246 -----
 .../drm/amd/include/asic_reg/smu/smu_7_1_3_enum.h  | 1282 -----
 .../drm/amd/include/asic_reg/smu/smu_8_0_enum.h    | 1072 ----
 9 files changed, 13851 deletions(-)
 delete mode 100644 drivers/gpu/drm/amd/include/asic_reg/smu/smu_6_0_d.h
 delete mode 100644 drivers/gpu/drm/amd/include/asic_reg/smu/smu_6_0_sh_mask.h
 delete mode 100644 drivers/gpu/drm/amd/include/asic_reg/smu/smu_7_1_0_d.h
 delete mode 100644 drivers/gpu/drm/amd/include/asic_reg/smu/smu_7_1_0_enum.h
 delete mode 100644 drivers/gpu/drm/amd/include/asic_reg/smu/smu_7_1_0_sh_mask.h
 delete mode 100644 drivers/gpu/drm/amd/include/asic_reg/smu/smu_7_1_1_enum.h
 delete mode 100644 drivers/gpu/drm/amd/include/asic_reg/smu/smu_7_1_2_enum.h
 delete mode 100644 drivers/gpu/drm/amd/include/asic_reg/smu/smu_7_1_3_enum.h
 delete mode 100644 drivers/gpu/drm/amd/include/asic_reg/smu/smu_8_0_enum.h

diff --git a/drivers/gpu/drm/amd/include/asic_reg/smu/smu_6_0_d.h b/drivers/gpu/drm/amd/include/asic_reg/smu/smu_6_0_d.h
deleted file mode 100644
index 6b10be61efc3..000000000000
diff --git a/drivers/gpu/drm/amd/include/asic_reg/smu/smu_6_0_sh_mask.h b/drivers/gpu/drm/amd/include/asic_reg/smu/smu_6_0_sh_mask.h
deleted file mode 100644
index 7d3925b7266e..000000000000
diff --git a/drivers/gpu/drm/amd/include/asic_reg/smu/smu_7_1_0_d.h b/drivers/gpu/drm/amd/include/asic_reg/smu/smu_7_1_0_d.h
deleted file mode 100644
index 57588b11ff1a..000000000000
diff --git a/drivers/gpu/drm/amd/include/asic_reg/smu/smu_7_1_0_enum.h b/drivers/gpu/drm/amd/include/asic_reg/smu/smu_7_1_0_enum.h
deleted file mode 100644
index 61face1d0d8d..000000000000
diff --git a/drivers/gpu/drm/amd/include/asic_reg/smu/smu_7_1_0_sh_mask.h b/drivers/gpu/drm/amd/include/asic_reg/smu/smu_7_1_0_sh_mask.h
deleted file mode 100644
index cd7893065a4b..000000000000
diff --git a/drivers/gpu/drm/amd/include/asic_reg/smu/smu_7_1_1_enum.h b/drivers/gpu/drm/amd/include/asic_reg/smu/smu_7_1_1_enum.h
deleted file mode 100644
index c1a7aba19223..000000000000
diff --git a/drivers/gpu/drm/amd/include/asic_reg/smu/smu_7_1_2_enum.h b/drivers/gpu/drm/amd/include/asic_reg/smu/smu_7_1_2_enum.h
deleted file mode 100644
index 73bbf506b1c9..000000000000
diff --git a/drivers/gpu/drm/amd/include/asic_reg/smu/smu_7_1_3_enum.h b/drivers/gpu/drm/amd/include/asic_reg/smu/smu_7_1_3_enum.h
deleted file mode 100644
index f19c4208d963..000000000000
diff --git a/drivers/gpu/drm/amd/include/asic_reg/smu/smu_8_0_enum.h b/drivers/gpu/drm/amd/include/asic_reg/smu/smu_8_0_enum.h
deleted file mode 100644
index e1540c181bf8..000000000000
-- 
2.13.6
