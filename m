Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031057AbeBNOuo (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 09:50:44 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36422 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030981AbeBNOqu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 09:46:50 -0500
X-Google-Smtp-Source: AH8x2265V6+BBKT3Z3yZa+i87oAiAjJPhL3yhQAlfykrTDpY+Ejrwjw9XnfL1b6cTfgBd4iqX8c9TA==
From: Corentin Labbe <clabbe@baylibre.com>
To: David1.Zhou@amd.com, airlied@linux.ie, alexander.deucher@amd.com,
        christian.koenig@amd.com
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v3 08/13] drm/amd/include: remove unused asic_reg/uvd headers
Date: Wed, 14 Feb 2018 14:46:12 +0000
Message-Id: <1518619577-19771-9-git-send-email-clabbe@baylibre.com>
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
 .../drm/amd/include/asic_reg/uvd/uvd_4_0_sh_mask.h |  795 -------------
 .../drm/amd/include/asic_reg/uvd/uvd_5_0_enum.h    | 1211 --------------------
 .../drm/amd/include/asic_reg/uvd/uvd_6_0_enum.h    | 1081 -----------------
 3 files changed, 3087 deletions(-)
 delete mode 100644 drivers/gpu/drm/amd/include/asic_reg/uvd/uvd_4_0_sh_mask.h
 delete mode 100644 drivers/gpu/drm/amd/include/asic_reg/uvd/uvd_5_0_enum.h
 delete mode 100644 drivers/gpu/drm/amd/include/asic_reg/uvd/uvd_6_0_enum.h

diff --git a/drivers/gpu/drm/amd/include/asic_reg/uvd/uvd_4_0_sh_mask.h b/drivers/gpu/drm/amd/include/asic_reg/uvd/uvd_4_0_sh_mask.h
deleted file mode 100644
index 8ee3149df5b7..000000000000
diff --git a/drivers/gpu/drm/amd/include/asic_reg/uvd/uvd_5_0_enum.h b/drivers/gpu/drm/amd/include/asic_reg/uvd/uvd_5_0_enum.h
deleted file mode 100644
index 981086f8ee4e..000000000000
diff --git a/drivers/gpu/drm/amd/include/asic_reg/uvd/uvd_6_0_enum.h b/drivers/gpu/drm/amd/include/asic_reg/uvd/uvd_6_0_enum.h
deleted file mode 100644
index ecf47ba55c2d..000000000000
-- 
2.13.6
