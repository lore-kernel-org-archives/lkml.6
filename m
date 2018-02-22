Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752056AbeBVX7x (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 18:59:53 -0500
Received: from mail-ua0-f196.google.com ([209.85.217.196]:39782 "EHLO
        mail-ua0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751764AbeBVX7v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 18:59:51 -0500
X-Google-Smtp-Source: AH8x2271YjH5v1YNZzJJ708s0UnhKadaYnLrBcpJKg/ZbaMKTb38w5jYykuBHhM4ubv4yTHGEz7I8Q==
Date: Thu, 22 Feb 2018 20:59:47 -0300
From: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
To: David Airlie <airlied@linux.ie>, Gerd Hoffmann <kraxel@redhat.com>
Cc: dri-devel@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH 1/7] drm/virtio: Add tabs at the start of a line
Message-ID: <1c77c233d4454ee2bdb85beaf17d413e310fac0a.1519343668.git.rodrigosiqueiramelo@gmail.com>
References: <cover.1519343668.git.rodrigosiqueiramelo@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1519343668.git.rodrigosiqueiramelo@gmail.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the checkpatch.pl errors:

drivers/gpu/drm/virtio/virtgpu_drv.h:371: ERROR: code indent should use
tabs where possible
...

Signed-off-by: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
---
 drivers/gpu/drm/virtio/virtgpu_display.c | 2 +-
 drivers/gpu/drm/virtio/virtgpu_drv.h     | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_display.c b/drivers/gpu/drm/virtio/virtgpu_display.c
index 19114a3c5ee4..22513d7f895c 100644
--- a/drivers/gpu/drm/virtio/virtgpu_display.c
+++ b/drivers/gpu/drm/virtio/virtgpu_display.c
@@ -387,7 +387,7 @@ int virtio_gpu_modeset_init(struct virtio_gpu_device *vgdev)
 	for (i = 0 ; i < vgdev->num_scanouts; ++i)
 		vgdev_output_init(vgdev, i);
 
-        drm_mode_config_reset(vgdev->ddev);
+	drm_mode_config_reset(vgdev->ddev);
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.h b/drivers/gpu/drm/virtio/virtgpu_drv.h
index da2fb585fea4..59801728cfeb 100644
--- a/drivers/gpu/drm/virtio/virtgpu_drv.h
+++ b/drivers/gpu/drm/virtio/virtgpu_drv.h
@@ -363,12 +363,12 @@ int virtgpu_gem_prime_pin(struct drm_gem_object *obj);
 void virtgpu_gem_prime_unpin(struct drm_gem_object *obj);
 struct sg_table *virtgpu_gem_prime_get_sg_table(struct drm_gem_object *obj);
 struct drm_gem_object *virtgpu_gem_prime_import_sg_table(
-        struct drm_device *dev, struct dma_buf_attachment *attach,
-        struct sg_table *sgt);
+	struct drm_device *dev, struct dma_buf_attachment *attach,
+	struct sg_table *sgt);
 void *virtgpu_gem_prime_vmap(struct drm_gem_object *obj);
 void virtgpu_gem_prime_vunmap(struct drm_gem_object *obj, void *vaddr);
 int virtgpu_gem_prime_mmap(struct drm_gem_object *obj,
-                                struct vm_area_struct *vma);
+			   struct vm_area_struct *vma);
 
 static inline struct virtio_gpu_object*
 virtio_gpu_object_ref(struct virtio_gpu_object *bo)
-- 
2.16.2
