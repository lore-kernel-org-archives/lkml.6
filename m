Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751723AbeCCGxh (ORCPT <rfc822;w@1wt.eu>);
        Sat, 3 Mar 2018 01:53:37 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:44461 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750892AbeCCGxg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Mar 2018 01:53:36 -0500
X-Google-Smtp-Source: AG47ELtq9pasEKTIVCRrrqLK4TJmfaRltr3ZsgrtUeKS0RWisx/s0TXOZDbvjjkdeu4WYhC8nLlc+Q==
From: Gwan-gyeong Mun <elongbug@gmail.com>
To: Daniel Vetter <daniel.vetter@intel.com>
Cc: Gustavo Padovan <gustavo@padovan.org>,
        Sean Paul <seanpaul@chromium.org>, David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Gwan-gyeong Mun <elongbug@gmail.com>
Subject: [PATCH] drm: Fix typo in lastclose description
Date: Sat,  3 Mar 2018 15:52:11 +0900
Message-Id: <20180303065211.28513-1-elongbug@gmail.com>
X-Mailer: git-send-email 2.16.2
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ownershipe -> ownership

Signed-off-by: Mun Gwan-gyeong <elongbug@gmail.com>
---
 include/drm/drm_drv.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/drm/drm_drv.h b/include/drm/drm_drv.h
index d23dcdd1bd95..64cb5975613c 100644
--- a/include/drm/drm_drv.h
+++ b/include/drm/drm_drv.h
@@ -140,7 +140,7 @@ struct drm_driver {
 	 *
 	 * All legacy drivers use this callback to de-initialize the hardware.
 	 * This is purely because of the shadow-attach model, where the DRM
-	 * kernel driver does not really own the hardware. Instead ownershipe is
+	 * kernel driver does not really own the hardware. Instead ownership is
 	 * handled with the help of userspace through an inheritedly racy dance
 	 * to set/unset the VT into raw mode.
 	 *
-- 
2.16.2
