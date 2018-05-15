Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752619AbeEOIyk (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 04:54:40 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:45635 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752346AbeEOIyh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 04:54:37 -0400
From: Colin King <colin.king@canonical.com>
To: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>,
        David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org,
        xen-devel@lists.xen.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] drm/xen-front: fix spelling mistake: "conector" -> "connector"
Date: Tue, 15 May 2018 09:54:33 +0100
Message-Id: <20180515085433.8245-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Trivial fix to spelling mistake in DRM_INFO message.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/gpu/drm/xen/xen_drm_front.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/xen/xen_drm_front.c b/drivers/gpu/drm/xen/xen_drm_front.c
index 0e486cb1c10c..3725de4c4da8 100644
--- a/drivers/gpu/drm/xen/xen_drm_front.c
+++ b/drivers/gpu/drm/xen/xen_drm_front.c
@@ -623,7 +623,7 @@ static int displback_initwait(struct xen_drm_front_info *front_info)
 	if (ret < 0)
 		return ret;
 
-	DRM_INFO("Have %d conector(s)\n", cfg->num_connectors);
+	DRM_INFO("Have %d connector(s)\n", cfg->num_connectors);
 	/* Create event channels for all connectors and publish */
 	ret = xen_drm_front_evtchnl_create_all(front_info);
 	if (ret < 0)
-- 
2.17.0
