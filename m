Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754947AbeCSAxT (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Mar 2018 20:53:19 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:37889 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754723AbeCSAwo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Mar 2018 20:52:44 -0400
X-Google-Smtp-Source: AG47ELuj4+d6r/+keThSNAmQVYu3/hEQzOr/8g44tlpTGODjrq9byrvnoE2cjsGJB7XBvSUeFwXzJg==
From: Paul McQuade <paulmcquad@gmail.com>
To: paulmcquad@gmail.com
Cc: daniel.vetter@intel.com, gustavo@padovan.org, seanpaul@chromium.org,
        airlied@linux.ie, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] GPU: drm: Fixed Spacing issue
Date: Mon, 19 Mar 2018 00:52:23 +0000
Message-Id: <20180319005225.1545-2-paulmcquad@gmail.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319005225.1545-1-paulmcquad@gmail.com>
References: <20180319005225.1545-1-paulmcquad@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"foo ** bar" should be "foo **bar"

Signed-off-by: Paul McQuade <paulmcquad@gmail.com>
---
 drivers/gpu/drm/drm_bufs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_bufs.c b/drivers/gpu/drm/drm_bufs.c
index 83b3d0801262..9af9efd84ee7 100644
--- a/drivers/gpu/drm/drm_bufs.c
+++ b/drivers/gpu/drm/drm_bufs.c
@@ -132,7 +132,7 @@ static int drm_map_handle(struct drm_device *dev, struct drm_hash_item *hash,
 static int drm_addmap_core(struct drm_device *dev, resource_size_t offset,
 			   unsigned int size, enum drm_map_type type,
 			   enum drm_map_flags flags,
-			   struct drm_map_list ** maplist)
+			   struct drm_map_list **maplist)
 {
 	struct drm_local_map *map;
 	struct drm_map_list *list;
-- 
2.16.2
