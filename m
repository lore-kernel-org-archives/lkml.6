Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031095AbeBNOu2 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 09:50:28 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35239 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030954AbeBNOqx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 09:46:53 -0500
X-Google-Smtp-Source: AH8x224vfemsul/ABTsD6tcIPafXVH2+coJFwcmq6AvXVftOSQ/yci5WtQOnS8EdlsJUSek4p5Tp0Q==
From: Corentin Labbe <clabbe@baylibre.com>
To: David1.Zhou@amd.com, airlied@linux.ie, alexander.deucher@amd.com,
        christian.koenig@amd.com
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v3 11/13] drm/amd/include: remove unused asic_reg/nbif headers
Date: Wed, 14 Feb 2018 14:46:15 +0000
Message-Id: <1518619577-19771-12-git-send-email-clabbe@baylibre.com>
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
 .../amd/include/asic_reg/nbif/nbif_6_1_sh_mask.h   | 10281 -------------------
 1 file changed, 10281 deletions(-)
 delete mode 100644 drivers/gpu/drm/amd/include/asic_reg/nbif/nbif_6_1_sh_mask.h

diff --git a/drivers/gpu/drm/amd/include/asic_reg/nbif/nbif_6_1_sh_mask.h b/drivers/gpu/drm/amd/include/asic_reg/nbif/nbif_6_1_sh_mask.h
deleted file mode 100644
index c7518b84f559..000000000000
-- 
2.13.6
