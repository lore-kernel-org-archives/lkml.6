Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030999AbeBNOqr (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 09:46:47 -0500
Received: from mail-wr0-f196.google.com ([209.85.128.196]:33420 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030981AbeBNOqo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 09:46:44 -0500
X-Google-Smtp-Source: AH8x226wZPVAwVlkphLms0asMFWAaZyG3vWNXww09xnl4iScFPea9+QS3ZHnFjRR9IP5TWu6MZMSRw==
From: Corentin Labbe <clabbe@baylibre.com>
To: David1.Zhou@amd.com, airlied@linux.ie, alexander.deucher@amd.com,
        christian.koenig@amd.com
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v3 04/13] drm/amd/include: remove unused asic_reg/gca headers
Date: Wed, 14 Feb 2018 14:46:08 +0000
Message-Id: <1518619577-19771-5-git-send-email-clabbe@baylibre.com>
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
 .../gpu/drm/amd/include/asic_reg/gca/gfx_8_1_d.h   |  2791 ---
 .../drm/amd/include/asic_reg/gca/gfx_8_1_enum.h    |  6808 ------
 .../drm/amd/include/asic_reg/gca/gfx_8_1_sh_mask.h | 21368 -------------------
 3 files changed, 30967 deletions(-)
 delete mode 100644 drivers/gpu/drm/amd/include/asic_reg/gca/gfx_8_1_d.h
 delete mode 100644 drivers/gpu/drm/amd/include/asic_reg/gca/gfx_8_1_enum.h
 delete mode 100644 drivers/gpu/drm/amd/include/asic_reg/gca/gfx_8_1_sh_mask.h

diff --git a/drivers/gpu/drm/amd/include/asic_reg/gca/gfx_8_1_d.h b/drivers/gpu/drm/amd/include/asic_reg/gca/gfx_8_1_d.h
deleted file mode 100644
index 2d672b3d2fed..000000000000
diff --git a/drivers/gpu/drm/amd/include/asic_reg/gca/gfx_8_1_enum.h b/drivers/gpu/drm/amd/include/asic_reg/gca/gfx_8_1_enum.h
deleted file mode 100644
index f9022097fbe9..000000000000
diff --git a/drivers/gpu/drm/amd/include/asic_reg/gca/gfx_8_1_sh_mask.h b/drivers/gpu/drm/amd/include/asic_reg/gca/gfx_8_1_sh_mask.h
deleted file mode 100644
index 397705a6b3a2..000000000000
-- 
2.13.6
