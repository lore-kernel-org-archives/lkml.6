Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752133AbeBWAAW (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 19:00:22 -0500
Received: from mail-vk0-f65.google.com ([209.85.213.65]:40241 "EHLO
        mail-vk0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751816AbeBWAAU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 19:00:20 -0500
X-Google-Smtp-Source: AH8x225ncoBEGve8g/mXptxYFQlaNjrrcj6XNXaJYVjCTBts3AgcK+FFXk7f+FvBem4MbjNeWPHy+A==
Date: Thu, 22 Feb 2018 21:00:17 -0300
From: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
To: David Airlie <airlied@linux.ie>, Gerd Hoffmann <kraxel@redhat.com>
Cc: dri-devel@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH 3/7] drm/virtio: Add */ in block comments to separate line
Message-ID: <f0bd4104a7d26bf7561c3a2b4632041c5411f1f2.1519343668.git.rodrigosiqueiramelo@gmail.com>
References: <cover.1519343668.git.rodrigosiqueiramelo@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1519343668.git.rodrigosiqueiramelo@gmail.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the checkpatch.pl warning:

virtgpu_ioctl.c:551: WARNING: Block comments use a trailing */ on a
separate line
...

Signed-off-by: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
---
 drivers/gpu/drm/virtio/virtgpu_ioctl.c | 3 ++-
 drivers/gpu/drm/virtio/virtgpu_prime.c | 3 ++-
 drivers/gpu/drm/virtio/virtgpu_vq.c    | 3 ++-
 3 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_ioctl.c b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
index 86243f131fc1..d52a86eaa884 100644
--- a/drivers/gpu/drm/virtio/virtgpu_ioctl.c
+++ b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
@@ -548,7 +548,8 @@ struct drm_ioctl_desc virtio_gpu_ioctls[DRM_VIRTIO_NUM_IOCTLS] = {
 			  DRM_AUTH|DRM_UNLOCKED|DRM_RENDER_ALLOW),
 
 	/* make transfer async to the main ring? - no sure, can we
-	   thread these in the underlying GL */
+	 * thread these in the underlying GL
+	 */
 	DRM_IOCTL_DEF_DRV(VIRTGPU_TRANSFER_FROM_HOST,
 			  virtio_gpu_transfer_from_host_ioctl,
 			  DRM_AUTH|DRM_UNLOCKED|DRM_RENDER_ALLOW),
diff --git a/drivers/gpu/drm/virtio/virtgpu_prime.c b/drivers/gpu/drm/virtio/virtgpu_prime.c
index 385e0eb9826a..6c6e9dbab096 100644
--- a/drivers/gpu/drm/virtio/virtgpu_prime.c
+++ b/drivers/gpu/drm/virtio/virtgpu_prime.c
@@ -25,7 +25,8 @@
 #include "virtgpu_drv.h"
 
 /* Empty Implementations as there should not be any other driver for a virtual
- * device that might share buffers with virtgpu */
+ * device that might share buffers with virtgpu
+ */
 
 int virtgpu_gem_prime_pin(struct drm_gem_object *obj)
 {
diff --git a/drivers/gpu/drm/virtio/virtgpu_vq.c b/drivers/gpu/drm/virtio/virtgpu_vq.c
index 16c05bc34bef..809d20eb6571 100644
--- a/drivers/gpu/drm/virtio/virtgpu_vq.c
+++ b/drivers/gpu/drm/virtio/virtgpu_vq.c
@@ -383,7 +383,8 @@ static int virtio_gpu_queue_cursor(struct virtio_gpu_device *vgdev,
 }
 
 /* just create gem objects for userspace and long lived objects,
-   just use dma_alloced pages for the queue objects? */
+ * just use dma_alloced pages for the queue objects?
+ */
 
 /* create a basic resource */
 void virtio_gpu_cmd_create_resource(struct virtio_gpu_device *vgdev,
-- 
2.16.2
