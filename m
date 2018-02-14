Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031042AbeBNOq6 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 09:46:58 -0500
Received: from mail-wr0-f193.google.com ([209.85.128.193]:33440 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030786AbeBNOqw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 09:46:52 -0500
X-Google-Smtp-Source: AH8x227hhAy2HOmg51vZosVoUgjoPojLn4T+CmJyjz4FuUsNr+x80KCEXZpDes45hCPa1WUptSSB4w==
From: Corentin Labbe <clabbe@baylibre.com>
To: David1.Zhou@amd.com, airlied@linux.ie, alexander.deucher@amd.com,
        christian.koenig@amd.com
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v3 10/13] drm/amd/include: remove unused asic_reg/sdma headers
Date: Wed, 14 Feb 2018 14:46:14 +0000
Message-Id: <1518619577-19771-11-git-send-email-clabbe@baylibre.com>
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
 .../amd/include/asic_reg/sdma0/sdma0_4_0_default.h | 286 ---------------------
 .../amd/include/asic_reg/sdma1/sdma1_4_0_default.h | 282 --------------------
 2 files changed, 568 deletions(-)
 delete mode 100644 drivers/gpu/drm/amd/include/asic_reg/sdma0/sdma0_4_0_default.h
 delete mode 100644 drivers/gpu/drm/amd/include/asic_reg/sdma1/sdma1_4_0_default.h

diff --git a/drivers/gpu/drm/amd/include/asic_reg/sdma0/sdma0_4_0_default.h b/drivers/gpu/drm/amd/include/asic_reg/sdma0/sdma0_4_0_default.h
deleted file mode 100644
index 4be3cb5c4556..000000000000
diff --git a/drivers/gpu/drm/amd/include/asic_reg/sdma1/sdma1_4_0_default.h b/drivers/gpu/drm/amd/include/asic_reg/sdma1/sdma1_4_0_default.h
deleted file mode 100644
index 934733762ddf..000000000000
-- 
2.13.6
