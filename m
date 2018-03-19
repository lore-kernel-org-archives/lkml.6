Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754856AbeCSAwp (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Mar 2018 20:52:45 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36892 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754258AbeCSAwm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Mar 2018 20:52:42 -0400
X-Google-Smtp-Source: AG47ELv09TeFVRH+rDr9TNlVQLNg6cqagCttB/Hmcm6/jDVVu1JP3/tFfj1OubgleHnsaweTGwQk8w==
From: Paul McQuade <paulmcquad@gmail.com>
To: paulmcquad@gmail.com
Cc: daniel.vetter@intel.com, gustavo@padovan.org, seanpaul@chromium.org,
        airlied@linux.ie, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] GPU: drm: Fixed Spacing issue
Date: Mon, 19 Mar 2018 00:52:22 +0000
Message-Id: <20180319005225.1545-1-paulmcquad@gmail.com>
X-Mailer: git-send-email 2.16.2
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"foo * bar" should be "foo *bar"

Signed-off-by: Paul McQuade <paulmcquad@gmail.com>
---
 drivers/gpu/drm/drm_bufs.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/drm_bufs.c b/drivers/gpu/drm/drm_bufs.c
index 1ee84dd802d4..83b3d0801262 100644
--- a/drivers/gpu/drm/drm_bufs.c
+++ b/drivers/gpu/drm/drm_bufs.c
@@ -129,7 +129,7 @@ static int drm_map_handle(struct drm_device *dev, struct drm_hash_item *hash,
  * type.  Adds the map to the map list drm_device::maplist. Adds MTRR's where
  * applicable and if supported by the kernel.
  */
-static int drm_addmap_core(struct drm_device * dev, resource_size_t offset,
+static int drm_addmap_core(struct drm_device *dev, resource_size_t offset,
 			   unsigned int size, enum drm_map_type type,
 			   enum drm_map_flags flags,
 			   struct drm_map_list ** maplist)
@@ -361,7 +361,7 @@ static int drm_addmap_core(struct drm_device * dev, resource_size_t offset,
 	return 0;
 }
 
-int drm_legacy_addmap(struct drm_device * dev, resource_size_t offset,
+int drm_legacy_addmap(struct drm_device *dev, resource_size_t offset,
 		      unsigned int size, enum drm_map_type type,
 		      enum drm_map_flags flags, struct drm_local_map **map_ptr)
 {
@@ -637,8 +637,8 @@ int drm_legacy_rmmap_ioctl(struct drm_device *dev, void *data,
  *
  * Frees any pages and buffers associated with the given entry.
  */
-static void drm_cleanup_buf_error(struct drm_device * dev,
-				  struct drm_buf_entry * entry)
+static void drm_cleanup_buf_error(struct drm_device *dev,
+				  struct drm_buf_entry *entry)
 {
 	int i;
 
-- 
2.16.2
