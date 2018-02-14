Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030829AbeBNOqo (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 09:46:44 -0500
Received: from mail-wr0-f195.google.com ([209.85.128.195]:42267 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030913AbeBNOql (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 09:46:41 -0500
X-Google-Smtp-Source: AH8x227x+2xWdnGgra5oJ0WquYWESjAPpBJPW2IZ0h+G3Peomvt8L3HvPVinVXEW8ERPHT10jj55pQ==
From: Corentin Labbe <clabbe@baylibre.com>
To: David1.Zhou@amd.com, airlied@linux.ie, alexander.deucher@amd.com,
        christian.koenig@amd.com
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v3 02/13] drm/amd/include: remove unused asic_reg/bif headers
Date: Wed, 14 Feb 2018 14:46:06 +0000
Message-Id: <1518619577-19771-3-git-send-email-clabbe@baylibre.com>
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
 .../drm/amd/include/asic_reg/bif/bif_5_0_enum.h    | 1198 --------------------
 .../drm/amd/include/asic_reg/bif/bif_5_1_enum.h    | 1068 -----------------
 2 files changed, 2266 deletions(-)
 delete mode 100644 drivers/gpu/drm/amd/include/asic_reg/bif/bif_5_0_enum.h
 delete mode 100644 drivers/gpu/drm/amd/include/asic_reg/bif/bif_5_1_enum.h

diff --git a/drivers/gpu/drm/amd/include/asic_reg/bif/bif_5_0_enum.h b/drivers/gpu/drm/amd/include/asic_reg/bif/bif_5_0_enum.h
deleted file mode 100644
index 46b75f4bbc36..000000000000
diff --git a/drivers/gpu/drm/amd/include/asic_reg/bif/bif_5_1_enum.h b/drivers/gpu/drm/amd/include/asic_reg/bif/bif_5_1_enum.h
deleted file mode 100644
index d8d5ae0b341f..000000000000
-- 
2.13.6
