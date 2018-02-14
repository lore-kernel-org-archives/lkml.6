Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031051AbeBNOwH (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 09:52:07 -0500
Received: from mail-wr0-f196.google.com ([209.85.128.196]:39890 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030801AbeBNOqn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 09:46:43 -0500
X-Google-Smtp-Source: AH8x225Igmy5ZQsa3/6DxBT0zkAlepq0XPNhEJ/PzFD9Qi9kOSgdJM2zhYxclUHZB6UU77AVtf9waw==
From: Corentin Labbe <clabbe@baylibre.com>
To: David1.Zhou@amd.com, airlied@linux.ie, alexander.deucher@amd.com,
        christian.koenig@amd.com
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v3 03/13] drm/amd/include: remove unused asic_reg/dce headers
Date: Wed, 14 Feb 2018 14:46:07 +0000
Message-Id: <1518619577-19771-4-git-send-email-clabbe@baylibre.com>
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
 .../drm/amd/include/asic_reg/dce/dce_11_2_enum.h   | 6813 --------------------
 .../drm/amd/include/asic_reg/dce/dce_8_0_enum.h    | 1117 ----
 2 files changed, 7930 deletions(-)
 delete mode 100644 drivers/gpu/drm/amd/include/asic_reg/dce/dce_11_2_enum.h
 delete mode 100644 drivers/gpu/drm/amd/include/asic_reg/dce/dce_8_0_enum.h

diff --git a/drivers/gpu/drm/amd/include/asic_reg/dce/dce_11_2_enum.h b/drivers/gpu/drm/amd/include/asic_reg/dce/dce_11_2_enum.h
deleted file mode 100644
index b2ea4202d7bd..000000000000
diff --git a/drivers/gpu/drm/amd/include/asic_reg/dce/dce_8_0_enum.h b/drivers/gpu/drm/amd/include/asic_reg/dce/dce_8_0_enum.h
deleted file mode 100644
index 6bea30ef3df5..000000000000
-- 
2.13.6
