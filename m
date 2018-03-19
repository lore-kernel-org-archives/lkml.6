Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754894AbeCSAww (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Mar 2018 20:52:52 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:37891 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754823AbeCSAwp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Mar 2018 20:52:45 -0400
X-Google-Smtp-Source: AG47ELuxktyZUXTpu8MfuNegrJoBTZ8GbQn3RoPm1pvzJqDGBYKwLkWazXXDSXtF0qGNCMYNI4ytkg==
From: Paul McQuade <paulmcquad@gmail.com>
To: paulmcquad@gmail.com
Cc: daniel.vetter@intel.com, gustavo@padovan.org, seanpaul@chromium.org,
        airlied@linux.ie, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] GPU: drm: Fixed Spacing issue
Date: Mon, 19 Mar 2018 00:52:24 +0000
Message-Id: <20180319005225.1545-3-paulmcquad@gmail.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319005225.1545-1-paulmcquad@gmail.com>
References: <20180319005225.1545-1-paulmcquad@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

space prohibited after that open parenthesis '('

Signed-off-by: Paul McQuade <paulmcquad@gmail.com>
---
 drivers/gpu/drm/drm_bufs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_bufs.c b/drivers/gpu/drm/drm_bufs.c
index 9af9efd84ee7..8e345ba16858 100644
--- a/drivers/gpu/drm/drm_bufs.c
+++ b/drivers/gpu/drm/drm_bufs.c
@@ -224,7 +224,7 @@ static int drm_addmap_core(struct drm_device *dev, resource_size_t offset,
 	case _DRM_SHM:
 		list = drm_find_matching_map(dev, map);
 		if (list != NULL) {
-			if(list->map->size != map->size) {
+			if (list->map->size != map->size) {
 				DRM_DEBUG("Matching maps of type %d with "
 					  "mismatched sizes, (%ld vs %ld)\n",
 					  map->type, map->size, list->map->size);
-- 
2.16.2
