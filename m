Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754787AbeDTMZY (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 08:25:24 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:40186 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754591AbeDTMZV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 08:25:21 -0400
X-Google-Smtp-Source: AIpwx48M1DZx+cP7RW+Nn8O5iitYgliVN0TMshSdRaqOe0ufVPu0fZRb6wB/lYWT7pY+5OHOYh2Dvw==
From: Stefan Schake <stschake@gmail.com>
To: eric@anholt.net
Cc: airlied@linux.ie, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Stefan Schake <stschake@gmail.com>
Subject: [PATCH v4 2/2] drm/vc4: Add CTM registers to debugfs
Date: Fri, 20 Apr 2018 05:25:45 -0700
Message-Id: <20180420122545.40014-2-stschake@gmail.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180420122545.40014-1-stschake@gmail.com>
References: <20180420122545.40014-1-stschake@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that we set the OLED* registers to do CTM, it's helpful to have them
in the register dump.

Signed-off-by: Stefan Schake <stschake@gmail.com>
---
v4: new in the series.

 drivers/gpu/drm/vc4/vc4_hvs.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/vc4/vc4_hvs.c b/drivers/gpu/drm/vc4/vc4_hvs.c
index 2b62fc5b8d85..5d8c749c9749 100644
--- a/drivers/gpu/drm/vc4/vc4_hvs.c
+++ b/drivers/gpu/drm/vc4/vc4_hvs.c
@@ -58,6 +58,10 @@ static const struct {
 	HVS_REG(SCALER_DISPSTAT2),
 	HVS_REG(SCALER_DISPBASE2),
 	HVS_REG(SCALER_DISPALPHA2),
+	HVS_REG(SCALER_OLEDOFFS),
+	HVS_REG(SCALER_OLEDCOEF0),
+	HVS_REG(SCALER_OLEDCOEF1),
+	HVS_REG(SCALER_OLEDCOEF2),
 };
 
 void vc4_hvs_dump_state(struct drm_device *dev)
-- 
2.14.1
