Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031112AbeBNOvZ (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 09:51:25 -0500
Received: from mail-wr0-f194.google.com ([209.85.128.194]:46402 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030913AbeBNOqp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 09:46:45 -0500
X-Google-Smtp-Source: AH8x227neDBsSDol+kNA4SNrIMI3sWG11/aUA/SngBhlTq2113hWnLnCzHXkdvP4FZIHFCPtr54Dgg==
From: Corentin Labbe <clabbe@baylibre.com>
To: David1.Zhou@amd.com, airlied@linux.ie, alexander.deucher@amd.com,
        christian.koenig@amd.com
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v3 05/13] drm/amd/include: remove unused asic_reg/gmc headers
Date: Wed, 14 Feb 2018 14:46:09 +0000
Message-Id: <1518619577-19771-6-git-send-email-clabbe@baylibre.com>
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
 .../drm/amd/include/asic_reg/gmc/gmc_8_1_enum.h    | 1198 --------------------
 .../drm/amd/include/asic_reg/gmc/gmc_8_2_enum.h    | 1068 -----------------
 2 files changed, 2266 deletions(-)
 delete mode 100644 drivers/gpu/drm/amd/include/asic_reg/gmc/gmc_8_1_enum.h
 delete mode 100644 drivers/gpu/drm/amd/include/asic_reg/gmc/gmc_8_2_enum.h

diff --git a/drivers/gpu/drm/amd/include/asic_reg/gmc/gmc_8_1_enum.h b/drivers/gpu/drm/amd/include/asic_reg/gmc/gmc_8_1_enum.h
deleted file mode 100644
index 05b80f2bb147..000000000000
diff --git a/drivers/gpu/drm/amd/include/asic_reg/gmc/gmc_8_2_enum.h b/drivers/gpu/drm/amd/include/asic_reg/gmc/gmc_8_2_enum.h
deleted file mode 100644
index bc18e4d1f20e..000000000000
-- 
2.13.6
