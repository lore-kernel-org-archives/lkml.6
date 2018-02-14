Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031102AbeBNOvD (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 09:51:03 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:51262 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030947AbeBNOqs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 09:46:48 -0500
X-Google-Smtp-Source: AH8x226TDDIn/OMQag5nKmpBn3gF5a9rqsP0c7KuG9O97ahOwdJCEv2Q1tWmpf4qNsPwAnKzjDbZ3w==
From: Corentin Labbe <clabbe@baylibre.com>
To: David1.Zhou@amd.com, airlied@linux.ie, alexander.deucher@amd.com,
        christian.koenig@amd.com
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v3 07/13] drm/amd/include: remove unused asic_reg/umc headers
Date: Wed, 14 Feb 2018 14:46:11 +0000
Message-Id: <1518619577-19771-8-git-send-email-clabbe@baylibre.com>
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
 .../drm/amd/include/asic_reg/umc/umc_6_0_default.h | 31 -------------
 .../drm/amd/include/asic_reg/umc/umc_6_0_offset.h  | 52 ----------------------
 2 files changed, 83 deletions(-)
 delete mode 100644 drivers/gpu/drm/amd/include/asic_reg/umc/umc_6_0_default.h
 delete mode 100644 drivers/gpu/drm/amd/include/asic_reg/umc/umc_6_0_offset.h

diff --git a/drivers/gpu/drm/amd/include/asic_reg/umc/umc_6_0_default.h b/drivers/gpu/drm/amd/include/asic_reg/umc/umc_6_0_default.h
deleted file mode 100644
index 128a18f1e362..000000000000
diff --git a/drivers/gpu/drm/amd/include/asic_reg/umc/umc_6_0_offset.h b/drivers/gpu/drm/amd/include/asic_reg/umc/umc_6_0_offset.h
deleted file mode 100644
index 6985dbba39f5..000000000000
-- 
2.13.6
