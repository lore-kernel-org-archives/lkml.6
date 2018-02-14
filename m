Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031063AbeBNOrJ (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 09:47:09 -0500
Received: from mail-wr0-f194.google.com ([209.85.128.194]:37469 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030684AbeBNOq4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 09:46:56 -0500
X-Google-Smtp-Source: AH8x225qJuH7Sdk6NKaFxvu1ir0UlrSK1YnJPoyf98d9AwH8uYptulhRhmKStRGPybMOVILa3pS9aw==
From: Corentin Labbe <clabbe@baylibre.com>
To: David1.Zhou@amd.com, airlied@linux.ie, alexander.deucher@amd.com,
        christian.koenig@amd.com
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v3 13/13] drm/amd/powerplay: remove unused headers
Date: Wed, 14 Feb 2018 14:46:17 +0000
Message-Id: <1518619577-19771-14-git-send-email-clabbe@baylibre.com>
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
 .../gpu/drm/amd/powerplay/inc/polaris10_ppsmc.h    | 412 ---------------------
 drivers/gpu/drm/amd/powerplay/inc/pp_feature.h     |  67 ----
 2 files changed, 479 deletions(-)
 delete mode 100644 drivers/gpu/drm/amd/powerplay/inc/polaris10_ppsmc.h
 delete mode 100644 drivers/gpu/drm/amd/powerplay/inc/pp_feature.h

diff --git a/drivers/gpu/drm/amd/powerplay/inc/polaris10_ppsmc.h b/drivers/gpu/drm/amd/powerplay/inc/polaris10_ppsmc.h
deleted file mode 100644
index b8f4b73c322e..000000000000
diff --git a/drivers/gpu/drm/amd/powerplay/inc/pp_feature.h b/drivers/gpu/drm/amd/powerplay/inc/pp_feature.h
deleted file mode 100644
index 0faf6a25c18b..000000000000
-- 
2.13.6
